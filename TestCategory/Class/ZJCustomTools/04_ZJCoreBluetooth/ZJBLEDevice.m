//
//  ZJBLEDevice.m
//  ZJFramework
//
//  Created by ZJ on 1/26/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import "ZJBLEDevice.h"
#import <UIKit/UIKit.h>

@implementation NSString (ZJBLEString)

+ (NSString *)hy_stringFromDate:(NSDate *)date withFormat:(NSString *)format {
    static NSDateFormatter *dateFormater = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormater = [[NSDateFormatter alloc] init];
    });
    dateFormater.timeZone = [NSTimeZone systemTimeZone];
    dateFormater.locale = [NSLocale autoupdatingCurrentLocale];
    dateFormater.dateFormat = format;
    
    return [dateFormater stringFromDate:date];
}

@end

#define kLocal(key)    NSLocalizedString(key, nil)

@interface ZJBLEDevice () <CBPeripheralDelegate> {
    NSInteger _tempSamplingFrequency;
}

@property (nonatomic, assign) WriteDataType writeDataType;

@property (nonatomic, strong) DeviceWriteDataCompletionHandle discoverServiceCompletion;
@property (nonatomic, strong) DeviceWriteDataCompletionHandle writeDataCompletion;
@property (nonatomic, strong) DeviceOriginDataSamplingCompletionHandle originSamplingCompletion;
@property (nonatomic, strong) DeviceUpdateValueCompletionHandle updateValueCompletion;

@property (nonatomic, strong) CBCharacteristic *normalCharacteristic;
@property (nonatomic, assign) BOOL isRealTimeSampling;
@property (nonatomic, assign) BOOL isOriginSampling;
@property (nonatomic, assign) BOOL isHeartSingleTest;

@property (nonatomic, assign) BOOL isWriteData;

@end

#define MatchServiceUUID @"00000001-1212-EFDE-1523-785FEABCD123"
#define MatchCharacteristicUUID @"00000003-1212-efde-1523-785feabcd123" // 设备通知特性

@implementation ZJBLEDevice

- (instancetype)initWithPeripheral:(CBPeripheral *)peripheral {
    self = [super init];
    if (self) {
        [self initSettingWithPeriphera:peripheral];
    }
    
    return self;
}

- (instancetype)initWithPeripheral:(CBPeripheral *)peripheral RSSI:(NSNumber *)rssi {
    self = [super init];
    if (self) {
        [self initSettingWithPeriphera:peripheral];
        _RSSI = rssi;
    }
    
    return self;
}

- (void)initSettingWithPeriphera:(CBPeripheral *)peripheral {
    _peripheral = peripheral;
    _peripheral.delegate = self;
    _name = peripheral.name;
    _identify = peripheral.identifier.UUIDString;
}

- (void)writeWithData:(NSData *)data {
    if (self.normalCharacteristic) {
        [self.peripheral writeValue:data forCharacteristic:self.normalCharacteristic type:CBCharacteristicWriteWithResponse];
    }
}

#pragma mark - public method

- (void)writeDataWithType:(WriteDataType)type completion:(DeviceWriteDataCompletionHandle)completion {
    if (type > WriteDataTypeOfEndHertRealTimeSampling || type < WriteDataTypeOfVersion) return;
    self.isWriteData = YES;
    self.writeDataType = type;
    self.writeDataCompletion = completion;
    
    Byte bytes[11][4] = {
        {0x00, 0x13, 0x00, 0x00},   // 固件版本 0x00 0x13 0x00 0x03 0x01 0x00 0x00
        {0x00, 0x13, 0x02, 0x00},   // 获取SN Code
        {0x00, 0x13, 0x02, 0x00},   // 时间同步 ** 填充 **
        
        {0x00, 0x41, 0x03, 0x00},   // 查询实时步数 0xA0 0x41 0x03 0x02 MSB|LSB
        {0x00, 0x41, 0x04, 0x00},   // 查询历史步数 0xA0 0x41 0x04 0x14
        
        {0x00, 0x21, 0x00, 0x11},   // ** 填充 **
        
        {0x00, 0x32, 0x02, 0x02},   // ** 填充 **
        {0x00, 0x32, 0x03, 0x00},   // 结束原始数据采集 0xA0 0x32 0x03 0x01 0x01/0x00(失败/成功)
        
        {0x00, 0x32, 0x06, 0x00},   // 开启心率单次测量 0xA0 0x32 0x06 0x01 0x00/0x01(失败/成功)
        
        {0x00, 0x32, 0x07, 0x00},   // 开启心率实时测量 0xA0 0x32 0x07 0x01 0x01/0x00(失败/成功)
        {0x00, 0x32, 0x08, 0x00},   // 关闭心率实时测量 0xA0 0x32 0x08 0x01 0x01/0x00(失败/成功)
    };
    if (self.writeDataType == WriteDataTypeOfSynchronizeTime) {
        Byte bytes[7];
        bytes[0] = 0x00, bytes[1] = 0x12, bytes[2] = 0x00, bytes[3] = 0x03;
        NSString *date = [NSString hy_stringFromDate:[NSDate date] withFormat:@"HH:mm:ss"];
        NSArray *ary = [date componentsSeparatedByString:@":"];
        bytes[4] = [ary[0] integerValue];
        bytes[5] = [ary[1] integerValue];
        bytes[6] = [ary[2] integerValue];
        [self writeWithData:[NSData dataWithBytes:bytes length:sizeof(bytes)/sizeof(Byte)]];
    }else if (self.writeDataType == WriteDataTypeOfSettingSampling) {
        [self writeSamplingFrequencyWithValue:25 completion:completion];                // 默认操作
    }else if (self.writeDataType == WriteDataTypeOfBeganOriginSampling) {
        // [self writeBeganOriginSamplingWithType:OriginSamplingTypeOfHeart completion:completion];   // 默认操作
    }else {
        Byte (*p)[4];
        p = bytes + self.writeDataType;
        [self writeWithData:[NSData dataWithBytes:p length:sizeof(*p)/sizeof(Byte)]];
    }
}

// 设置采样率
- (void)writeSamplingFrequencyWithValue:(NSInteger)value completion:(DeviceWriteDataCompletionHandle)completion {
    self.isWriteData = YES;
    
    self.writeDataType = WriteDataTypeOfSettingSampling;
    self.writeDataCompletion = completion;
    _tempSamplingFrequency = value;
    
    Byte bytes[5] = {0x00, 0x21, 0x00, 0x01, value};
    [self writeWithData:[NSData dataWithBytes:bytes length:sizeof(bytes)/sizeof(Byte)]];
}

// 启动原始数据采集 0xA0 0x32 0x02 0x01 0x00/0x01(失败/成功)
- (void)writeBeganOriginSamplingWithType:(OriginSamplingType)type completion:(DeviceOriginDataSamplingCompletionHandle)completion {
    self.isWriteData = YES;
    
    self.writeDataType = WriteDataTypeOfBeganOriginSampling;
    self.originSamplingCompletion = completion;

    Byte types[3][2] = {
        {0x00, 0x01},
        {0x01, 0x00},
        {0x01, 0x01},
    };
    
    Byte bytes[6] = {0x00, 0x32, 0x02, 0x02, types[type][0], types[type][1]};   // 启动原始数据采集 0xA0 0x32 0x02 0x01 0x00/0x01(失败/成功)
    [self writeWithData:[NSData dataWithBytes:bytes length:sizeof(bytes)/sizeof(Byte)]];
}

- (void)discoverServices:(DeviceWriteDataCompletionHandle)completion {
    if (!self.services) {
        self.discoverServiceCompletion = completion;
        [self.peripheral discoverServices:@[[CBUUID UUIDWithString:MatchServiceUUID]]];
    }else {
        completion(YES, self.services, nil);
    }
}

- (void)updateNotifyValueCompletion:(DeviceUpdateValueCompletionHandle)completion {
    self.isWriteData = NO;
    
    self.updateValueCompletion = completion;
}

#pragma mark - CBPeripheralDelegate

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(nullable NSError *)error {
    NSLog(@"-->services = %@", peripheral.services);
    _services = peripheral.services;
    
    for (CBService *sev in peripheral.services) {
        
        if ([sev.UUID.UUIDString caseInsensitiveCompare:MatchServiceUUID] == NSOrderedSame) {
            [peripheral discoverCharacteristics:nil forService:sev];
            break;
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    NSLog(@"-->characteristics = %@", service.characteristics);
    if (error) {
        if (self.discoverServiceCompletion) {
            self.discoverServiceCompletion(NO, nil, error);
        }
    }else {
        for (CBCharacteristic *ct in service.characteristics) {
            if ([ct.UUID.UUIDString caseInsensitiveCompare:MatchCharacteristicUUID] == NSOrderedSame) {
                [self.peripheral setNotifyValue:YES forCharacteristic:ct];
            }else {
                self.normalCharacteristic = ct;
            }
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    NSLog(@"%s, %@", __func__, error);
}

/**
 
 */
- (void)notifyValue:(NSData *)data error:(NSError *)error {
    Byte *bytes = (Byte *)data.bytes;
    NSInteger length = data.length;
    
    if (self.isOriginSampling && length == 20) {
        NSMutableArray *sAry, *hAry;
        NSLog(@"原始数据采样中: %zd", length);
        sAry = [NSMutableArray array], hAry = [NSMutableArray array];
        for (int i = 4; i < 20; i+=2) {
            char chs[] = {bytes[i+1], bytes[i]};
            unsigned short value = *(unsigned short *)chs;
            if (i < 15) {
                [sAry addObject:@(value)];
            }else {
                [hAry addObject:@(value)];
            }
        }
        self.originSamplingCompletion(YES, sAry, hAry, error);
    }else if (self.isRealTimeSampling && length == 5 && bytes[2] == 0x0c) {
        self.writeDataCompletion(YES, @(bytes[4]), error);
    }else if (self.isHeartSingleTest && length == 5 && bytes[2] == 0x0B) {
        self.isHeartSingleTest = NO;
        self.writeDataCompletion(YES, @(bytes[4]), error);
    }else if (self.updateValueCompletion) {
        if (length == 6) {
            if (bytes[2] == 0x03) {         // 计步
                char chs[] = {bytes[5], bytes[4]};
                unsigned short value = *(unsigned short *)chs;
                self.updateValueCompletion(YES, UpdateNotifyValueTypeOfStep, value, error);
            }else if (bytes[1] == 0x12) {   // 电量
                _power = bytes[4];
                _samplingFrequency = bytes[5];
                self.updateValueCompletion(YES, UpdateNotifyValueTypeOfPower, _power, error);
            }
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error {
    NSLog(@"%s", __func__);
    
    if (error) {
        NSLog(@"error = %@", error);
    }else {
        NSLog(@"value = %@, len = %zd", characteristic.value, characteristic.value.length);
        Byte *bytes = (Byte *)characteristic.value.bytes;
        if (self.isWriteData == NO) {
            [self notifyValue:characteristic.value error:error];
        }else {
            NSInteger length = characteristic.value.length;
            BOOL success = NO;
            id obj;
            switch (self.writeDataType) {
                    case WriteDataTypeOfVersion: {
                        if (length > 5 && bytes[1] == 0x13) {
                            success = YES;
                            NSMutableString *str = [NSMutableString string];
                            for (int i = 4; i < length; i++) {
                                [str appendString:[NSString stringWithFormat:@"%zd", bytes[i]]];
                                if (i != length - 1) {
                                    [str appendString:@"."];
                                }
                            }
                            obj = str;
                            if (self.writeDataCompletion) {
                                self.isWriteData = NO;
                                self.writeDataCompletion(success, obj, error);
                            }
                        }else {
                            [self notifyValue:characteristic.value error:error];
                        }
                    }
                    break;
                    case WriteDataTypeOfSNCode: {
                        if (length == 16) {
                            success = YES;
                            Byte *bytes = (Byte *)[characteristic.value bytes];
                            NSMutableString *str = [NSMutableString string];
                            for (int i = 4; i < [characteristic.value length]; i++) {
                                int k = bytes[i];
                                [str appendString:[NSString stringWithFormat:@"%d", k]];
                            }
                            obj = str;
                            _snCode = obj;
                            self.isWriteData = NO;
                            self.writeDataCompletion(success, obj, error);
                        }else {
                            [self notifyValue:characteristic.value error:error];
                        }
                    }
                    break;
                    case WriteDataTypeOfSynchronizeTime: {
                        if (length == 6 && bytes[1] == 0x12) {
                            success = YES;
                            _power = bytes[4];
                            _samplingFrequency = bytes[5];
                            self.isWriteData = NO;
                            self.writeDataCompletion(success, obj, error);
                        }else {
                            [self notifyValue:characteristic.value error:error];
                        }
                    }
                    break;
                    case WriteDataTypeOfStep: {
                        if (length == 6 && bytes[1] == 0x41) {
                            success = YES;
                            char chs[] = {bytes[5], bytes[4]};
                            unsigned short value = *(unsigned short *)chs;
                            obj = @(value);
                            self.isWriteData = NO;
                            self.writeDataCompletion(success, obj, error);
                            self.writeDataCompletion = nil;
                        }else {
                            [self notifyValue:characteristic.value error:error];
                        }
                    }
                    break;
                    case WriteDataTypeOfHistorySteps: {
                        if (length == 18 && bytes[1] == 0x41) {
                            obj = [NSMutableArray array];
                            for (int i = 4; i < length; i+=2) {
                                char chs[] = {bytes[i+1], bytes[i]};
                                unsigned short value = *(unsigned short *)chs;
                                [((NSMutableArray *)obj) addObject:@(value)];
                            }
                            success = YES;
                            self.isWriteData = NO;
                            self.writeDataCompletion(success, obj, error);
                            self.writeDataCompletion = nil;
                        }else {
                            [self notifyValue:characteristic.value error:error];
                        }
                    }
                    break;
                    case WriteDataTypeOfSettingSampling: {
                        if (length == 5 && bytes[1] == 0x21) {
                            success = bytes[4] == 0xaa;
                            if (bytes[4] == 0xaa) {
                                _samplingFrequency = _tempSamplingFrequency;
                            }
                            self.isWriteData = NO;
                            self.writeDataCompletion(success, obj, error);
                        }else {
                            [self notifyValue:characteristic.value error:error];
                        }
                    }
                    break;
                    case WriteDataTypeOfBeganSingleHertSampling: {
                        if (length == 5) {
                            if (bytes[2] == 0x06 && bytes[4] == 0x00) {
                                self.isHeartSingleTest = YES;
                                success = YES;
                            }
                            self.isWriteData = NO;
                            self.writeDataCompletion(success, obj, error);
                        }else {
                            [self notifyValue:characteristic.value error:error];
                        }
                    }
                    break;
                    case WriteDataTypeOfBeganOriginSampling: {
                        if (length == 5 && bytes[2] == 0x02) {
                            NSLog(@"原始数据采样开始");
                            if (bytes[4] == 0x00) {
                                success = YES;
                                self.isOriginSampling = YES;
                            }
                            self.isWriteData = NO;
                            self.writeDataCompletion = nil;
//                            self.writeDataCompletion(success, obj, error);
                        }else {
                            [self notifyValue:characteristic.value error:error];
                        }
                    }
                    break;
                    case WriteDataTypeOfEndOriginSampling:
                    case WriteDataTypeOfEndHertRealTimeSampling: {                        
                        if (length == 5) {
                            NSLog(@"原始数据采样结束");
                            
                            self.isRealTimeSampling = NO;
                            self.isOriginSampling = NO;
                            
                            success = bytes[4] == 0x00;
                            self.isWriteData = NO;
                            self.writeDataCompletion(success, obj, error);
                            self.writeDataCompletion = nil;
                            self.originSamplingCompletion = nil;
                        }else {
                            [self notifyValue:characteristic.value error:error];
                        }
                    }
                    break;
                    case WriteDataTypeOfBeganHertRealTimeSampling:{
                        if (length == 5 && bytes[2] == 0x07) {
                            NSLog(@"心率实时测量开始");
                            if (bytes[4] == 0x00) {
                                success = YES;
                                self.isRealTimeSampling = YES;
                            }
                            self.isWriteData = NO;
                            self.writeDataCompletion(success, obj, error);
                        }else {
                            [self notifyValue:characteristic.value error:error];
                        }
                    }
                    break;
                    
                default:
                    break;
            }
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error {
    NSLog(@"%s, %@", __func__, characteristic);
    if (self.discoverServiceCompletion) {
        if (error) {
            self.discoverServiceCompletion(NO, nil, error);
        }else {
            self.discoverServiceCompletion(YES, self.services, error);
        }
    }
}

@end
