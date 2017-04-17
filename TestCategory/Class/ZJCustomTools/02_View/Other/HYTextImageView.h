//
//  HYTextImageView.h
//  PEPlatform
//
//  Created by ZJ on 11/12/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewExt.h"

@interface HYTextImageView : UIControl

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)image textRatio:(CGFloat)ratio;


/**
 @param ratio   text 宽度占比,默认为0.5
 */
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title imgName:(NSString *)imgName textRatio:(CGFloat)ratio;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, assign) BOOL needIVRound;
@property (nonatomic, assign) CGFloat leftMargin;
@property (nonatomic, assign) CGFloat titleLeftMargin;

@end
