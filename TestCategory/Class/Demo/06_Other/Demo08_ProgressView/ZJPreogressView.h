//
//  ZJPreogressView.h
//  弧形进度条
//
//  Created by clare on 15/12/8.
//  Copyright © 2015年 zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kScreenW [[UIScreen mainScreen] bounds].size.width
#define kScreenH [[UIScreen mainScreen] bounds].size.height

@interface ZJPreogressView : UIView

@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) CGFloat originValue;
@property (nonatomic, assign) CGFloat maxValue;

/**
 默认是0，暂时不考虑,后再完善
 */
@property (nonatomic, assign) CGFloat minValue;

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, strong) UIColor *bottomLayerColor;
@property (nonatomic, strong) UIColor *frontLayerColor;

- (void)showContentWithAnimate:(BOOL)animated;

@end
