//
//  ZJSearchingView.h
//  Test
//
//  Created by ZJ on 1/19/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJSearchingView : UIView

- (nullable instancetype)initWithFrame:(CGRect)frame content:(nullable id)content;

@property (nonatomic, getter=isSearching) BOOL searching;

/**
 *  是否顺时针,默认为YES
 */
@property (nonatomic, getter=isClosewise) BOOL clockwise;

/**
 *  角度范围, 表示弧线的长度
 */
@property (nonatomic, assign) CGFloat angleSpan;

@property (nonatomic, assign) CGFloat lineWidth;

/**
 *  弧线旋转一圈需要的时间,默认为1
 */
@property (nonatomic, assign) CGFloat duration;

/**
 *  弧线的颜色
 */
@property (nullable, nonatomic, strong) UIColor *frontLineColor;

/**
 *  底部弧线的颜色
 */
@property (nullable, nonatomic, strong) UIColor *bottomLineColor;

/**
 *  是否隐藏frontLineLayer,默认为NO
 */
@property (nonatomic, assign) BOOL hiddenFrontLineLayer;

/**
 *  是否隐藏bottomLineLayer,默认为NO
 */
@property (nonatomic, assign) BOOL hiddenBottomLineLayer;

/**
 *  显示在图层中间的内容  typically a CGImageRef ro a string/mutableString
 */
@property (nullable, nonatomic, strong) id contents;
@property (nullable, nonatomic, strong) UIColor *contentViewBackgroundColor;

/**
 *  如果内容是文本的话, 可以设置文本的字体
 */
@property (nullable, nonatomic, strong) UIFont *font;
@property (nullable, nonatomic, strong) UIColor *textColor;

/**
 *  默认的字体大小为36
 */
@property (nonatomic, assign) CGFloat fontSize;

- (void)startSearching;

- (void)stopSearching;

@end
