//
//  ZJBLEDeviceManager.m
//  ZJFramework
//
//  Created by ZJ on 1/26/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import "ZJBLEDeviceManager.h"
#import "ZJBLEDevice.h"

@interface CBPeripheral (ZJPeripheral)

- (BOOL)isEqual:(CBPeripheral *)peripheral;

@end

@implementation CBPeripheral (ZJPeripheral)

- (BOOL)isEqual:(CBPeripheral *)peripheral {
    return [self.identifier.UUIDString isEqualToString:peripheral.identifier.UUIDString];
}

@end

@interface NSMutableArray (ZJPeripheralAry)

- (ZJBLEDevice *)deviceWithPeripheral:(CBPeripheral *)peripheral;

@end

@implementation NSMutableArray (ZJPeripheralAry)

- (ZJBLEDevice *)deviceWithPeripheral:(CBPeripheral *)peripheral {
    for (int i = 0; i < self.count; i++) {
        ZJBLEDevice *dv = self[i];
        if ([dv.peripheral isEqual:peripheral]) {
            return dv;
        }
    }
    
    return nil;
}

@end

@interface ZJBLEDeviceManager ()<CBCentralManagerDelegate> {
    NSArray *_searchServiceUUIDs;
    NSString *_prefix;
}

@property (nonatomic, strong) CBCentralManager *centralManager;
@property (nonatomic, strong) BLERefreshStateCompletionHandle stateCompletion;
@property (nonatomic, strong) BLEScanCompletionHandle scanCompletion;
@property (nonatomic, strong) BLEConnectCompletionHandle connectCompletion;
@property (nonatomic, strong) BLEConnectCompletionHandle disConnectCompletion;

@end

static ZJBLEDeviceManager *_manager = nil;

@implementation ZJBLEDeviceManager

@synthesize state = _state;

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initSetting];
    }
    
    return self;
}

- (void)initSetting {
    self.automScan = YES;

    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
}

+ (instancetype)shareManager {
    if (!_manager) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _manager = [[ZJBLEDeviceManager alloc] init];
        });
    }
    
    return _manager;
}

+ (instancetype)shareManagerDidUpdateStateHandle:(BLERefreshStateCompletionHandle)completion {
    if (!_manager) {
        _manager = [ZJBLEDeviceManager shareManager];
    }
    _manager.stateCompletion = completion;
    
    return _manager;
}

- (void)scanDeviceWithServiceUUIDs:(NSArray<CBUUID *> *)uuids completion:(BLEScanCompletionHandle)completion {
    [self scanDeviceWithServiceUUIDs:uuids prefix:nil completion:completion];
}

- (void)scanDeviceWithServiceUUIDs:(NSArray<CBUUID *> *)uuids prefix:(NSString *)prefix completion:(BLEScanCompletionHandle)completion {
    _prefix = prefix;
    
    _searchServiceUUIDs = uuids;
    /**
     *  本类自动scan传过来的回调都是nil,当不为nil时(在外部类中调用scan方法),应该更新扫描的回调
     */
    if (completion) {
        self.scanCompletion = completion;
    }
    
    if (_discoveredBLEDevices.count) {
        _discoveredBLEDevices = nil;
        if (self.scanCompletion) {
            self.scanCompletion(_discoveredBLEDevices);
        }
    }
    
    [self.centralManager scanForPeripheralsWithServices:uuids options:nil];
}

- (void)connectBLEDevices:(NSArray<ZJBLEDevice *> *)devices completion:(BLEConnectCompletionHandle)completion {
    for (ZJBLEDevice *device in devices) {
        if (device.peripheral.state == CBPeripheralStateDisconnected) {
            [self.centralManager connectPeripheral:device.peripheral options:nil];
        }
    }
    
    self.connectCompletion = completion;
}

- (void)cancelBLEDevicesConnection:(NSArray<ZJBLEDevice *> *)devices completion:(BLEConnectCompletionHandle)completion {
    for (ZJBLEDevice *device in devices) {
        [self.centralManager cancelPeripheralConnection:device.peripheral];
    }
    
    self.disConnectCompletion = completion;
}

#pragma mark - CBCentralManagerDelegate

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    if (self.stateCompletion) {
        self.stateCompletion((ZJDeviceManagerState)central.state);
    }
    
//    if (self.automScan) {
//        [central scanForPeripheralsWithServices:_searchServiceUUIDs options:nil];
//    }
}

/**
 *  发现设备
 */
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI {
    if (_prefix && [peripheral.name hasPrefix:_prefix] == NO) {
        return;
    }
    NSLog(@"发现设备--->%@, %@", advertisementData, peripheral.identifier.UUIDString);
    NSMutableArray *ary = [NSMutableArray arrayWithArray:self.discoveredBLEDevices];
    ZJBLEDevice *device = [ary deviceWithPeripheral:peripheral];
    if (device) {
        [ary removeObject:device];
    }

    ZJBLEDevice *dv = [[ZJBLEDevice alloc] initWithPeripheral:peripheral RSSI:RSSI];
    [ary addObject:dv];
    _discoveredBLEDevices = [ary copy];
    
    /**
     *  不管是用户手动扫描还是automScan,都用scanCompletion回调
     */
    if (self.scanCompletion) {
        self.scanCompletion(_discoveredBLEDevices);
    }
}

/**
 *  已连接
 */
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"%s", __func__);
    NSMutableArray *discoverAry = [NSMutableArray arrayWithArray:self.discoveredBLEDevices];
    NSMutableArray *connAry = [NSMutableArray arrayWithArray:self.connectedBLEDevices];
    
    ZJBLEDevice *device = [discoverAry deviceWithPeripheral:peripheral];
    if (device) {
        [connAry addObject:device];
        [discoverAry removeObject:device];
        _discoveredBLEDevices = [discoverAry copy];
        _connectedBLEDevices = [connAry copy];
        
        if (self.connectCompletion) {
            self.connectCompletion(device, YES, nil);
        }
    }
}

/**
 *  断开连接
 */
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"%s, error = %@", __func__, error);
    NSMutableArray *connAry = [NSMutableArray arrayWithArray:self.connectedBLEDevices];
    
    ZJBLEDevice *device = [connAry deviceWithPeripheral:peripheral];
    if (device) {
        [connAry removeObject:device];
        _connectedBLEDevices = [connAry copy];
        
        /**
         *  当有disconnectCompletion就用disconnectCompletion回调, 否则用connectionCompletion回调
         */
        if (self.disConnectCompletion) {
            self.disConnectCompletion(device, NO, error);
        }else if (self.connectCompletion) {
            self.connectCompletion(device, NO, error);
        }
    }
    
//    if (self.isAutomScan) {
//        [self scanDeviceWithServiceUUIDs:_searchServiceUUIDs completion:nil];
//    }
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"%s, error = %@", __func__, error);
    NSMutableArray *discoverAry = [NSMutableArray arrayWithArray:self.discoveredBLEDevices];
    ZJBLEDevice *device = [discoverAry deviceWithPeripheral:peripheral];
    if (device && self.connectCompletion) {
        self.connectCompletion(device, YES, nil);
    }
}

#pragma mark - public

- (void)rescan {
    self.automScan = YES;
    [self scanDeviceWithServiceUUIDs:_searchServiceUUIDs completion:nil];
}

- (void)stopScan {
    self.automScan = NO;
    [self.centralManager stopScan];
}

- (void)reset {
    _discoveredBLEDevices = nil;
    self.scanCompletion = nil;
    self.stateCompletion = nil;
    self.disConnectCompletion = nil;
    if (self.connectedBLEDevices.count == 0) {
        self.connectCompletion = nil;        
    }
}

#pragma mark - getter

- (ZJDeviceManagerState)state {
    _state = (ZJDeviceManagerState)self.centralManager.state;
    return _state;
}

@end
