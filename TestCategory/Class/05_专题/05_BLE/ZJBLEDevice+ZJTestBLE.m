//
//  ZJBLEDevice+ZJTestBLE.m
//  TestCategory
//
//  Created by ZJ on 27/04/2018.
//  Copyright © 2018 ZJ. All rights reserved.
//

#import "ZJBLEDevice+ZJTestBLE.h"

@implementation ZJBLEDevice (ZJTestBLE)

- (void)readValueWithType:(ReadDataType)type completion:(UpdateValueCompletionHandle)completion {
    self.updateValueCompletion = completion;
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    NSLog(@"-->characteristics = %@", service.characteristics);
    for (CBCharacteristic *ct in service.characteristics) {
        if ([ct isEqualUUID:CHARACTERISTICUUID1] || [ct isEqualUUID:CHARACTERISTICUUID2]) {
            [self.peripheral setNotifyValue:YES forCharacteristic:ct];
            break;
        }
    }
    if (self.discoverServiceCompletion) {
        self.discoverServiceCompletion(service.characteristics, ZJDeviceDiscoverTypeOfCharacteristics, error);
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error {
    NSLog(@"%s", __func__);
    NSLog(@"%@", characteristic);
    NSLog(@"value = %@, len = %lu", characteristic.value, characteristic.value.length);
    if ([characteristic isEqualUUID:CHARACTERISTICUUID2]) {
        NSData *data = characteristic.value;
        Byte *bytes = (Byte *)data.bytes;   // 0x69b1-->0xb1 69

        // 时间
        Byte times[5];
        for (int i = 0; i < 5; i++) {
            times[i] = bytes[12+i];
        }
        NSArray *units = @[@"-", @"-", @" ", @":", @""];
        NSMutableString *str = @"".mutableCopy;
        for (int i = 0; i < units.count; i++) {
            [str appendString:[NSString stringWithFormat:@"%02d%@", times[i], units[i]]];
        }
        [str insertString:@"20" atIndex:0];
        [str appendString:@":00"];
        NSLog(@"time = %@", str);
        
        // 值
        float idxValues[3] = {18.0, 16.81, 38.66};
//        short value1 = [data valueWithIdx1:17 idx2:18];
//        CGFloat value = value1 / idxValues[self.readDataType];
//        
//        NSLog(@"%d, %f", value1, value);
//        if (self.valueCompletion) {
//            if (self.readDataType == ReadDataTypeOfUA) {
//                value = value * 0.1;
//            }
//            self.valueCompletion(YES, @(value), str, error);
//        }
    }
}

@end
