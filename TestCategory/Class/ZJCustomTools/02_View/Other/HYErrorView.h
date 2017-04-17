//
//  HYErrorView.h
//  Care
//
//  Created by ZJ on 8/12/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HYErrorViewType) {
    HYErrorViewTypeOfError, // 请求出错
    HYErrorViewTypeOfEmpty, // 空数据
};

@class HYErrorView;

@protocol HYErrorViewDelegate <NSObject>

- (void)errorViewDidTriggerEvent:(HYErrorView *)view;

@end

@interface HYErrorView : UIView

@property (nonatomic, copy  ) NSString *imgName;
@property (nonatomic, copy  ) NSString *buttonTitle;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, assign) HYErrorViewType errorType;
@property (nonatomic, weak) id <HYErrorViewDelegate>delegate;


/**
 默认为加载失败
 @param msg 失败提示
 */
- (void)showErrorViewWithMsg:(NSString *)msg;
- (void)showErrorViewWithMsg:(NSString *)msg type:(HYErrorViewType)type;

@end
