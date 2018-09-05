//
//  ZJSelectLabel.h
//  AoShiTong
//
//  Created by ZJ on 2018/8/3.
//  Copyright © 2018 HY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJSelectLabel : UILabel

@property (nonatomic, assign) BOOL select;
@property (nonatomic, strong) UIColor *selectColor;
@property (nonatomic, strong) UIColor *unSelectColor;

@end
