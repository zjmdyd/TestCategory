//
//  ZJTimeValueObject.h
//  SuperGymV4
//
//  Created by ZJ on 5/24/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJTimeValueObject : NSObject

@property (nonatomic, copy  ) NSString *value;
@property (nonatomic, strong) NSNumber *time;

@property (nonatomic, getter=isSelect) BOOL select;

@end
