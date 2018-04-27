//
//  ZJBLEDevice+ZJTestBLE.h
//  TestCategory
//
//  Created by ZJ on 27/04/2018.
//  Copyright © 2018 ZJ. All rights reserved.
//

#import "ZJBLEDevice.h"

typedef NS_ENUM(NSInteger, ReadDataType) {
    ReadDataTypeOfGL,       // 血糖
    ReadDataTypeOfUA,       // 尿酸
};

static NSString *SEVICEUUID = @"1000";

static NSString *CHARACTERISTICUUID1 = @"2A18";
static NSString *CHARACTERISTICUUID2 = @"1002";

@interface ZJBLEDevice (ZJTestBLE)

- (void)readValueWithType:(ReadDataType)type completion:(UpdateValueCompletionHandle)completion;

@end
