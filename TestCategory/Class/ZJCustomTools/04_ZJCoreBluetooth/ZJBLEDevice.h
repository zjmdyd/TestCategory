//
//  ZJBLEDevice.h
//  ZJFramework
//
//  Created by ZJ on 1/26/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

/**
 *  处理服务和特征的状态
 */
typedef NS_ENUM(NSUInteger, ZJDeviceDiscoverType) {
    ZJDeviceDiscoverTypeOfServices = 0,
    ZJDeviceDiscoverTypeOfCharacteristics,
    ZJDeviceDiscoverTypeOfDealCharacteristic,  // 处理特征 设置notify
};

typedef void(^DiscoverServiceCompletionHandle)(id obj, ZJDeviceDiscoverType type, NSError *error);
typedef void(^UpdateValueCompletionHandle)(BOOL success, id value, NSError *error);

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
@property (nonatomic, strong) DiscoverServiceCompletionHandle discoverServiceCompletion;
@property (nonatomic, strong) UpdateValueCompletionHandle updateValueCompletion;

- (void)discoverServices:(NSArray<CBUUID *> *)serviceUUIDs completion:(DiscoverServiceCompletionHandle)completion;
- (void)discoverCharacteristics:(NSArray<CBUUID *> *)characteristicUUIDs forService:(CBService *)service;

@end

@interface CBCharacteristic (ZJCBCharacteristic)

- (BOOL)isEqualUUID:(NSString *)uuid;

@end

@implementation CBCharacteristic (ZJCBCharacteristic)

- (BOOL)isEqualUUID:(NSString *)uuid {
    return [self.UUID.UUIDString isEqualToString:uuid];
}

@end
