//
//  ZJLoginFooterView.h
//  CanShengHealth
//
//  Created by ZJ on 29/01/2018.
//  Copyright © 2018 HY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZJLoginFooterView;

@protocol ZJLoginFooterViewDelegate <NSObject>

- (void)loginFooterView:(ZJLoginFooterView *)view didClickButtonAtIndex:(NSInteger)index;

@end

@interface ZJLoginFooterView : UIView

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, weak) id<ZJLoginFooterViewDelegate> delegate;

@end
