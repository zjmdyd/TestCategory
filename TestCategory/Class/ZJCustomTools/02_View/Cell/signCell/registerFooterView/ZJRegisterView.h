//
//  ZJRegisterView.h
//  CanShengHealth
//
//  Created by ZJ on 29/01/2018.
//  Copyright © 2018 HY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZJRegisterView;

@protocol ZJRegisterViewDelegate <NSObject>

- (void)registerFooterView:(ZJRegisterView *)view didClickButtonAtIndex:(NSInteger)index;

@end

@interface ZJRegisterView : UIView

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imgName;
@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *termsColor;
@property (nonatomic, weak) id<ZJRegisterViewDelegate> delegate;

@end
