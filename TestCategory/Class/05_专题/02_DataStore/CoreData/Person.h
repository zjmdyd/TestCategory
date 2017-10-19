//
//  Person.h
//  ZJFoundation
//
//  Created by YunTu on 15/9/6.
//  Copyright (c) 2015年 YunTu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Person : NSManagedObject

@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) id color;
@property (nonatomic, retain) id lover;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) id routes;

@end
