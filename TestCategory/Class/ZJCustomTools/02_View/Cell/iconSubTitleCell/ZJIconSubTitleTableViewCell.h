//
//  ZJIconSubTitleTableViewCell.h
//  CanShengHealth
//
//  Created by ZJ on 31/01/2018.
//  Copyright © 2018 HY. All rights reserved.
//

#import "ZJNormalTableViewCell.h"

@interface ZJIconSubTitleTableViewCell : ZJNormalTableViewCell

@property (nonatomic, copy) NSString *imgName;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, copy) NSString *accessoryText;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *subTitleColor;
@property (nonatomic, strong) UIColor *accessoryTextColor;
@property (nonatomic, assign) BOOL read;

/**
 文本是否需要左边距，默认为NO, 当有照片时为默认为YES,
 */
@property (nonatomic, assign) BOOL needTitleLeftMargin;

/**
 icon左边距，默认为16
 */
@property (nonatomic, assign) CGFloat iconLeftMargin;

@end
