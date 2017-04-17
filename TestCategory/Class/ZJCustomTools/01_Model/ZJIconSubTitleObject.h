//
//  ZJIconSubTitleObject.h
//  DiabetesGuardForDoctor
//
//  Created by ZJ on 6/26/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJIconSubTitleObject : NSObject

@property (nonatomic, copy) NSString *headIconPath;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, copy) NSString *accessoryText;
@property (nonatomic, copy) NSString *accessorySubText;
@property (nonatomic, copy) NSString *accessorySubText2;

@property (nonatomic, strong) NSNumber *objID;
@property (nonatomic, strong) NSNumber *status;

@end
