//
//  ZJBLEDevice+ZJTestBLE.m
//  TestCategory
//
//  Created by ZJ on 27/04/2018.
//  Copyright © 2018 ZJ. All rights reserved.
//

#import "ZJBLEDevice+ZJTestBLE.h"

static NSString *GLCTUUID = @"2A18";
static NSString *GLCTUUID2 = @"1002";

@implementation ZJBLEDevice (ZJTestBLE)

#pragma mark - CBPeripheralDelegate

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    NSLog(@"-->characteristics = %@", service.characteristics);
    
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    NSLog(@"%s, %@", __func__, error);
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error {
    NSLog(@"%s", __func__);
    NSLog(@"%@", characteristic);
    NSLog(@"value = %@, len = %lu", characteristic.value, characteristic.value.length);
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error {
    NSLog(@"%s, %@", __func__, characteristic);
}

@end
