//
//  ZJNameIDObject.h
//  PhysicalDate
//
//  Created by ZJ on 3/23/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJNameIDObject : NSObject<NSCopying, NSMutableCopying>

@property (nonatomic, copy  ) NSString *name;
@property (nonatomic, strong) NSNumber *objID;

@property (nonatomic, getter=isSelect) BOOL select;

@end
