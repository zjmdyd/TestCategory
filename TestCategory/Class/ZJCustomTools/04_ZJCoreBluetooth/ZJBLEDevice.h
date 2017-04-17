//
//  ZJBLEDevice.h
//  ZJFramework
//
//  Created by ZJ on 1/26/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

typedef NS_ENUM(NSInteger, WriteDataType) {
    WriteDataTypeOfVersion,                     // 软件版本
    WriteDataTypeOfSNCode,                      // SN Code

    WriteDataTypeOfSynchronizeTime,             // 同步时间
    WriteDataTypeOfStep,                        // 查询实时步数
    WriteDataTypeOfHistorySteps,                // 查询历史步数
    WriteDataTypeOfSettingSampling,             // 设置采样率
    
    WriteDataTypeOfBeganOriginSampling,         // 启动原始数据采集
    WriteDataTypeOfEndOriginSampling,           // 结束原始数据采集
    
    WriteDataTypeOfBeganSingleHertSampling,     // 开启心率单次测量

    WriteDataTypeOfBeganHertRealTimeSampling,   // 开启心率实时测量
    WriteDataTypeOfEndHertRealTimeSampling,     // 关闭心率实时测量
};

/**
 *  原始数据采集类型
 */
typedef NS_ENUM(NSInteger, OriginSamplingType) {
    OriginSamplingTypeOfHeart,          // 心率
    OriginSamplingTypeOfStep,           // 计步
    OriginSamplingTypeOfStepHeart,      // 心率和计步
};

/**
 *  设备主动推送数据类型
 */
typedef NS_ENUM(NSInteger, UpdateNotifyValueType) {
    UpdateNotifyValueTypeOfStep,           // 计步
    UpdateNotifyValueTypeOfPower,          // 电量
};

typedef void(^DeviceWriteDataCompletionHandle)(BOOL success, id obj, NSError *error);
typedef void(^DeviceUpdateValueCompletionHandle)(BOOL success, UpdateNotifyValueType type, NSInteger value, NSError *error);
typedef void(^DeviceOriginDataSamplingCompletionHandle)(BOOL success, NSArray *stepValues, NSArray *heartValues, NSError *error);

@interface ZJBLEDevice : NSObject

- (instancetype)init NS_UNAVAILABLE;

/**
 *  每个BLEDevice对象对应一个peripheral
 */
- (instancetype)initWithPeripheral:(CBPeripheral *)peripheral;
- (instancetype)initWithPeripheral:(CBPeripheral *)peripheral RSSI:(NSNumber *)rssi;

/**
 *  Pointer to CoreBluetooth peripheral
 */
@property (nonatomic, strong, readonly) CBPeripheral *peripheral;

/**
 *  Pointer to CoreBluetooth manager that found this peripheral
 */
@property (nonatomic, strong) CBCentralManager *manager;

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *identify;
@property (nonatomic, strong, readonly) NSNumber *RSSI;
@property (nonatomic, strong, readonly) NSArray *services;

@property (nonatomic, copy, readonly) NSString *snCode;
/**
 *  须同步时间后此属性值才有效
 */
@property (nonatomic, assign, readonly) NSInteger power;
@property (nonatomic, assign, readonly) NSInteger samplingFrequency;

- (void)discoverServices:(DeviceWriteDataCompletionHandle)completion;
- (void)writeDataWithType:(WriteDataType)type completion:(DeviceWriteDataCompletionHandle)completion;

- (void)updateNotifyValueCompletion:(DeviceUpdateValueCompletionHandle)completion;
- (void)writeSamplingFrequencyWithValue:(NSInteger)value completion:(DeviceWriteDataCompletionHandle)completion;
- (void)writeBeganOriginSamplingWithType:(OriginSamplingType)type completion:(DeviceOriginDataSamplingCompletionHandle)completion;

@end
