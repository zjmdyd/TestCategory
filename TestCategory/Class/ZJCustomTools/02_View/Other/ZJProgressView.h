//
//  ZJProgressView.h
//  弧形进度条
//
//  Created by clare on 15/12/8.
//  Copyright © 2015年 zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJProgressView : UIView

@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) CGFloat radius;

@property (nonatomic, strong) UIColor *bottomLayerColor;
@property (nonatomic, strong) UIColor *frontLayerColor;

@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *unitColor;
@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSAttributedString *attributeText;
@property (nonatomic, copy) NSString *unit;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSTextAlignment textAlignment;

@property (nonatomic, assign) CGFloat valueRatio;

@property (nonatomic, assign) CGFloat valueDash; // 增长因子，默认为1，当动画的时候才有用

@property (nonatomic, assign) BOOL needTailLabel;   // 默认为NO
@property (nonatomic, copy) NSString *headValue;
@property (nonatomic, copy) NSString *tailValue;

- (void)showContent:(NSString *)content withAnimate:(BOOL)animated;

@end
