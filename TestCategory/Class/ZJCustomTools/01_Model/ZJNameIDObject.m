//
//  ZJNameIDObject.m
//  PhysicalDate
//
//  Created by ZJ on 3/23/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import "ZJNameIDObject.h"

@implementation ZJNameIDObject

- (id)copyWithZone:(NSZone *)zone {
    ZJNameIDObject *obj = [[ZJNameIDObject allocWithZone:zone] init];
    obj.name = self.name;
    obj.objID = self.objID;
    obj.select = self.select;
    
    return obj;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    ZJNameIDObject *obj = [[ZJNameIDObject allocWithZone:zone] init];
    obj.name = self.name;
    obj.objID = self.objID;
    obj.select = self.select;
    
    return obj;
}

- (BOOL)isEqual:(id)object {
    if (self.objID.integerValue == [object objID].integerValue && [self.name isEqualToString:[object name]]) {
        return YES;
    }
    return NO;
}

@end
