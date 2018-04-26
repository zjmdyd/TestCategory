//
//  ZJBLEDevice.m
//  ZJFramework
//
//  Created by ZJ on 1/26/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import "ZJBLEDevice.h"
#import <UIKit/UIKit.h>
#import "ZJFondationCategory.h"

@interface ZJBLEDevice () <CBPeripheralDelegate> {
    NSMutableData *_data;
}

@property (nonatomic, strong) DeviceDiscoverServiceCompletionHandle discoverServiceCompletion;
@property (nonatomic, strong) CBCharacteristic *normalCharacteristic;
@property (nonatomic, strong) CBCharacteristic *writeCharacteristic;    // 血压用

// 体脂称
@property (nonatomic, strong) CBCharacteristic *ackWriteCharacteristic;     // APP-->设备 消息确认
@property (nonatomic, strong) CBCharacteristic *ackReceiveCharacteristic;   // 设备-->APP 收到确认消息
@property (nonatomic, strong) CBCharacteristic *writeWRCharacteristic;      // APP-->设备 写有反馈
@property (nonatomic, strong) CBCharacteristic *writeWNCharacteristic;      // APP-->设备 写无反馈

@property (nonatomic, strong) DeviceUpdateValueCompletionHandle valueCompletion;
@property (nonatomic, assign) ReadDataType readDataType;

@end

static NSString *GLCTUUID = @"2A18";

// 血压
static NSString *BPCTREADUUID = @"0000FFF1";
static NSString *BPCTWRITEUUID = @"0000FFF2";

// 卡迪克血脂
static NSString *CardioServiceUUID = @"FFE0";
static NSString *CardioCTUUID = @"FFE4";

// 体脂
static NSString *TZServiceUUID = @"A602";
static NSString *TZACKWriteCTUUID = @"A622";    // app-->设备 消息确认
static NSString *TZACKReceiveCTUUID = @"A625";  // 设备-->APP 收到确认消息
static NSString *TZWRCTUUID = @"A623";  // APP-->设备 写有反馈
static NSString *TZWNCTUUID = @"A624";  // APP-->设备 写无反馈

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

- (void)discoverServices:(NSArray<CBUUID *> *)serviceUUIDs completion:(DeviceDiscoverServiceCompletionHandle)completion {
    self.discoverServiceCompletion = completion;
    [self.peripheral discoverServices:serviceUUIDs];
}

- (void)readValueWithType:(ReadDataType)type completion:(DeviceUpdateValueCompletionHandle)completion {
    self.readDataType = type;
    self.valueCompletion = completion;
    
    if (type == ReadDataTypeOfBP) {
        Byte bytes[] = {0xFD, 0xFD, 0xFA, 0x05, 0X0D, 0x0A};
        NSData *data = [NSData dataWithBytes:bytes length:sizeof(bytes)/sizeof(Byte)];
        [self writeWithData:data type:CBCharacteristicWriteWithoutResponse];
    }else if (type == ReadDataTypeOfTZ) {
        Byte bytes[] = {0x00, 0x01, 0x11, 0x02, 0X03, 0x04, 0x05, 0x06};
        NSData *data = [NSData dataWithBytes:bytes length:sizeof(bytes)/sizeof(Byte)];
        [self.peripheral writeValue:data forCharacteristic:self.writeWNCharacteristic type:CBCharacteristicWriteWithoutResponse];
    }
}

- (void)writeWithData:(NSData *)data type:(CBCharacteristicWriteType)type {
    if (self.writeCharacteristic) {
        [self.peripheral writeValue:data forCharacteristic:self.writeCharacteristic type:type];
    }
}

#pragma mark - CBPeripheralDelegate

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(nullable NSError *)error {
    NSLog(@"-->services = %@", peripheral.services);
    _services = peripheral.services;
    
    for (CBService *sev in peripheral.services) {
        [peripheral discoverCharacteristics:nil forService:sev];
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    NSLog(@"-->characteristics = %@", service.characteristics);
    
    if ([self isTZDevice:service]) {  // 体脂设备
        for (CBCharacteristic *ct in service.characteristics) {
            if ([ct.UUID.UUIDString isEqualToString:TZACKWriteCTUUID]) {
                self.ackWriteCharacteristic = ct;
            }else if ([ct.UUID.UUIDString isEqualToString:TZACKReceiveCTUUID]) {
                self.ackReceiveCharacteristic = ct;
                [self.peripheral setNotifyValue:YES forCharacteristic:ct];
            }else if ([ct.UUID.UUIDString isEqualToString:TZWRCTUUID]) {
                self.writeWRCharacteristic = ct;
                [self.peripheral setNotifyValue:YES forCharacteristic:ct];
            }else if ([ct.UUID.UUIDString isEqualToString:TZWNCTUUID]) {
                self.writeWNCharacteristic = ct;
            }
        }
    }else {
        for (CBCharacteristic *ct in service.characteristics) {
            if ([ct.UUID.UUIDString isEqualToString:GLCTUUID]) {  // 血糖、尿酸、血脂(胆固醇)
                self.normalCharacteristic = ct;
                [self.peripheral setNotifyValue:YES forCharacteristic:ct];
                break;
            }else if ([ct.UUID.UUIDString isEqualToString:CardioCTUUID]) {  // 血脂(卡迪克)
                self.normalCharacteristic = ct;
                [self.peripheral setNotifyValue:YES forCharacteristic:ct];
                break;
            }else if ([ct.UUID.UUIDString hasPrefix:BPCTREADUUID]) {  // 血压读
                self.normalCharacteristic = ct;
                [self.peripheral setNotifyValue:YES forCharacteristic:ct];
            }else if ([ct.UUID.UUIDString hasPrefix:BPCTWRITEUUID]) {  // 血压写
                self.writeCharacteristic = ct;
            }
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    NSLog(@"%s, %@", __func__, error);
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error {
    NSLog(@"%s", __func__);
    NSLog(@"%@", characteristic);
    NSLog(@"value = %@, len = %lu", characteristic.value, characteristic.value.length);
    NSData *data = characteristic.value;
    Byte *bytes = (Byte *)data.bytes;   // 0x69b1-->0xb1 69
    if (data.length) {
        if (self.readDataType <= ReadDataTypeOfBF) {
            short value1 = [data valueWithIdx1:10 idx2:11];
            short value2 = value1 & 0x0fff; // 169
            Byte byte1 = bytes[11];         // b1
            Byte byte2 = byte1 & 0xf0;      // b0
            Byte byte3 = byte2 / 16;        // b
            NSLog(@"%d, %0x, %0x, %0x, %0x", value1, value2, byte1, byte2, byte3);
            CGFloat value = value2 * pow(10, byte3-16);
            NSLog(@"%lf", value);
            
            if (self.valueCompletion) {
                self.valueCompletion(YES, @(value*1000), error);
            }
        }else if (self.readDataType == ReadDataTypeOfBFCardio) {
            if (!_data) {
                _data = [[NSMutableData alloc] initWithData:data];
            }else {
                [_data appendData:data];
                if (data.length == 6 && (bytes[0] == 0x0d && bytes[1] == 0x0a)) {
                    NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
                    NSString *string = [[NSString alloc] initWithData:_data encoding:gbkEncoding];
                    NSLog(@"string = %@", string);
                    NSArray *strs = [string componentsSeparatedByString:@"\n"];    // 所有行
                    NSArray *titles = @[@"CHOL", @"TRIG", @"HDLCHOL", @"CALCLDL"];
                    NSMutableArray *values = [NSMutableArray arrayWithObject:@"0" count:titles.count];
                    for (int i = 0; i < titles.count; i++) {
                        for (int j = 0; j < strs.count; j++) {
                            NSArray *lineStrings = [strs[j] componentsSeparatedByString:@":"];
                            NSString *v0 = lineStrings[0];   // 标题所在
                            NSString *v2 = lineStrings[1];   // 值所在
                            if ([v0 containsString:titles[i]]) {
                                NSArray *v2Strs = [v2 componentsSeparatedByString:@" "];    // 值用空格分割
                                for (NSString *v2s in v2Strs) {
                                    NSString *str = [v2s stringByReplacingOccurrencesOfString:@" " withString:@""];
                                    if ([str hasNumber]) {
                                        NSLog(@"matchValue = %@", str);
                                        [values replaceObjectAtIndex:i withObject:str];
                                        break;
                                    }
                                }
                                break;
                            }
                        }
                    }
                    if (self.valueCompletion) {
                        self.valueCompletion(YES, values, error);
                    }
                }
            }
        }else if(self.readDataType == ReadDataTypeOfBP) {   // 血压
            if (data.length == 21 || data.length == 16) {
                NSLog(@"高压:%d", bytes[3]);
                NSLog(@"低压:%d", bytes[4]);
                NSLog(@"心率:%d", bytes[5]);
                NSInteger v1 = bytes[3], v2 = bytes[4], v3 = bytes[5];
                // 结束测量
//                Byte bts[] = {0xFD, 0xFD, 0xFE, 0x06, 0X0D, 0x0A};
//                NSData *data = [NSData dataWithBytes:bts length:sizeof(bts)/sizeof(Byte)];
//                [self writeWithData:data type:CBCharacteristicWriteWithoutResponse];
                
                NSArray *values = @[@(v1).stringValue, @(v2).stringValue, @(v3).stringValue];
                if (self.valueCompletion) {
                    self.valueCompletion(YES, values, error);
                }
            }else if(data.length == 8) {
                NSLog(@"高压:%d", bytes[3]);
                NSLog(@"低压:%d", bytes[4]);
                NSLog(@"心率:%d", bytes[5]);
            }
        }else if(self.readDataType == ReadDataTypeOfTZ) {
            if (data.length == 3 && bytes[0] == 0x00) { // 注册设备请求的数据确认包
                Byte bytes[] = {0x48, 0x01, 0x00, 0x01};
                NSData *data = [NSData dataWithBytes:bytes length:sizeof(bytes)/sizeof(Byte)];
                [self.peripheral writeValue:data forCharacteristic:self.writeWNCharacteristic type:CBCharacteristicWriteWithoutResponse];
            }
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error {
    NSLog(@"%s, %@", __func__, characteristic);
    
    if (self.discoverServiceCompletion) {
        if ([characteristic.UUID.UUIDString isEqualToString:GLCTUUID] ||
            [characteristic.UUID.UUIDString isEqualToString:CardioCTUUID]  ||
            [characteristic.UUID.UUIDString hasPrefix:BPCTREADUUID] ||
            [characteristic.UUID.UUIDString isEqualToString:TZWRCTUUID]) {
            self.discoverServiceCompletion(characteristic, error);
        }
    }
}

- (BOOL)isTZDevice:(CBService *)service {
    return [service.UUID.UUIDString isEqualToString:TZServiceUUID];
}

@end
