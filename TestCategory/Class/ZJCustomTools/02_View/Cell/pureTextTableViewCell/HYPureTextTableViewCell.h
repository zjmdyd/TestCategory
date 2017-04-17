//
//  HYPureTextTableViewCell.h
//  PEPlatform
//
//  Created by ZJ on 11/11/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYPureTextTableViewCell : UITableViewCell

@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, assign) NSInteger numberOfLine;
@property (nonatomic, assign) NSTextAlignment textAlignment;

@end
