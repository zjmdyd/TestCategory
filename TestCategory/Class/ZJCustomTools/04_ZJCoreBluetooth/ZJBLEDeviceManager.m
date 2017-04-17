//
//  ZJBLEDeviceManager.m
//  ZJFramework
//
//  Created by ZJ on 1/26/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import "ZJBLEDeviceManager.h"
#import "ZJBLEDevice.h"

@interface ZJBLEDeviceManager ()<CBCentralManagerDelegate> {
    NSArray *_searchUUIDs;
}

@property (nonatomic, strong) CBCentralManager *centralManager;
@property (nonatomic, strong) BleRefreshCompletionHandle scanCompletion;
@property (nonatomic, strong) BleRefreshCompletionHandle stateCompletion;
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

+ (instancetype)shareManagerDidUpdateStateHandle:(BleRefreshCompletionHandle)completion {
    if (_manager) {         // 手动刷新状态
        [_manager centralManagerDidUpdateState:_manager.centralManager];
    }else {
        _manager = [ZJBLEDeviceManager shareManager];
        _manager.stateCompletion = completion;
    }
    
    return _manager;
}

- (void)scanDeviceWithServiceUUIDs:(NSArray<CBUUID *> *)uuids completion:(BleRefreshCompletionHandle)completion {
    _searchUUIDs = uuids;
    /**
     *  本类自动scan传过来的回调都是nil,当不为nil时(在外部类中调用scan方法),应该更新扫描的回调
     */
    if (completion) {
        self.scanCompletion = completion;
    }
    if (_discoveredBLEDevices.count) {
        _discoveredBLEDevices = @[];
        if (self.scanCompletion) {
            self.scanCompletion(nil, YES);
        }
    }
    [self.centralManager scanForPeripheralsWithServices:uuids options:nil];
}

- (void)connectBLEDevices:(NSArray *)devices completion:(BLEConnectCompletionHandle)completion {
    for (ZJBLEDevice *device in devices) {
        if (device.peripheral.state == CBPeripheralStateDisconnected) {
            [self.centralManager connectPeripheral:device.peripheral options:nil];
        }
    }
    self.connectCompletion = completion;
}

- (void)cancelBLEDevicesConnection:(NSArray *)devices completion:(BLEConnectCompletionHandle)completion {
    for (ZJBLEDevice *device in devices) {
        [self.centralManager cancelPeripheralConnection:device.peripheral];
    }
    self.disConnectCompletion = completion;
}

#pragma mark - CBCentralManagerDelegate

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    if (self.stateCompletion) {
        self.stateCompletion(@(central.state), YES);
    }
    
    if (self.automScan) {
        [central scanForPeripheralsWithServices:_searchUUIDs options:nil];
    }
}

/**
 *  发现设备
 */
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI {
    if ([peripheral.name hasPrefix:@"BAND"] == NO) {
        return;
    }
    NSLog(@"发现设备--->%@, %@", advertisementData, peripheral.identifier.UUIDString);
    NSMutableArray *ary = [NSMutableArray arrayWithArray:self.discoveredBLEDevices];
    for (int i = 0; i < ary.count; i++) {
        ZJBLEDevice *device = ary[i];
        if ([device.peripheral.identifier.UUIDString isEqualToString:peripheral.identifier.UUIDString]) {
            [ary removeObject:device];
            break;
        }
    }

    ZJBLEDevice *device = [[ZJBLEDevice alloc] initWithPeripheral:peripheral RSSI:RSSI];
    [ary addObject:device];
    _discoveredBLEDevices = [ary copy];
    
    /**
     *  不管是用户手动扫描还是automScan,都用scanCompletion回调
     */
    if (self.scanCompletion) {
        self.scanCompletion(_discoveredBLEDevices, YES);
    }
}

/**
 *  已连接
 */
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"%s", __func__);
    NSMutableArray *discoverAry = [NSMutableArray arrayWithArray:self.discoveredBLEDevices];
    NSMutableArray *connAry = [NSMutableArray arrayWithArray:self.connectedBLEDevices];
    
    ZJBLEDevice *device;
    for (int i = 0; i < discoverAry.count; i++) {
        device = discoverAry[i];
        if ([device.peripheral.identifier.UUIDString isEqualToString:peripheral.identifier.UUIDString]) {
            [connAry addObject:device];
            [discoverAry removeObject:device];
            break;
        }
    }
    _discoveredBLEDevices = [discoverAry copy];
    _connectedBLEDevices = [connAry copy];

//    if (device) {
//        self.connectCompletion(device, YES, nil);
//    }
    
    if (device) {
        [device discoverServices:^(BOOL success, id obj, NSError *error) {
            if (success && self.connectCompletion) {
                self.connectCompletion(device, YES, error);
            }
        }];
    }
}

/**
 *  断开连接
 */
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"%s, error = %@", __func__, error);
    NSMutableArray *connAry = [NSMutableArray arrayWithArray:self.connectedBLEDevices];
    
    ZJBLEDevice *device;
    for (int i = 0; i < connAry.count; i++) {
        device = connAry[i];
        if ([device.peripheral.identifier.UUIDString isEqualToString:peripheral.identifier.UUIDString]) {
            [connAry removeObject:device];
            break;
        }
    }
    _connectedBLEDevices = [connAry copy];
    
    /**
     *  当有disconnectCompletion就用disconnectCompletion回调, 否则用connectionCompletion回调
     */
    if (self.disConnectCompletion) {
        self.disConnectCompletion(device, NO, error);
    }else if (self.connectCompletion) {
        self.connectCompletion(device, NO, error);
    }
    
    if (self.isAutomScan) {
        [self scanDeviceWithServiceUUIDs:_searchUUIDs completion:nil];
    }
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"连接失败:%@", error);
    ZJBLEDevice *device = [[ZJBLEDevice alloc] initWithPeripheral:peripheral];
    if (self.connectCompletion) {
        self.connectCompletion(device, YES, error);
    }
}

#pragma mark -

- (void)rescan {
    self.automScan = YES;
    [self scanDeviceWithServiceUUIDs:_searchUUIDs completion:nil];
}

- (void)stopScan {
    self.automScan = NO;
    [self.centralManager stopScan];
}

- (void)reset {
    _discoveredBLEDevices = @[];
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
