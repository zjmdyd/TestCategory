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

@property (nonatomic, strong) DiscoverServiceCompletionHandle discoverServiceCompletion;
@property (nonatomic, strong) UpdateValueCompletionHandle valueCompletion;

@property (nonatomic, strong) CBCharacteristic *normalCharacteristic;
@property (nonatomic, strong) CBCharacteristic *writeCharacteristic;

@end

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

- (void)discoverServices:(NSArray<CBUUID *> *)serviceUUIDs completion:(DiscoverServiceCompletionHandle)completion {
    self.discoverServiceCompletion = completion;
    [self.peripheral discoverServices:serviceUUIDs];
}

#pragma mark - CBPeripheralDelegate

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(nullable NSError *)error {
    NSLog(@"-->services = %@", peripheral.services);
    _services = peripheral.services;
}

@end
