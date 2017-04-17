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

/**
 *  显示在图层中间的内容  typically a CGImageRef ro a string/mutableString
 */
@property (nullable, strong) id contents;

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
@property (nullable, nonatomic, strong) UIColor *lineColor;

/**
 *  是否显示底部lineLayer,默认为NO
 */
@property (nonatomic, assign) BOOL hiddenLineLayer;

/**
 *  底部弧线的颜色
 */
@property (nullable, nonatomic, strong) UIColor *bottomLineLayerColor;


/**
 *  是否显示底部lineLayer,默认为NO
 */
@property (nonatomic, assign) BOOL hiddenBottomLineLayer;

/**
 *  如果内容是文本的话, 可以设置文本的字体
 */
@property (nullable, nonatomic, strong) UIFont *font;

/**
 *  默认的字体大小为36
 */
@property (nonatomic, assign) CGFloat fontSize;

- (void)startSearching;

- (void)stopSearching;

@end
