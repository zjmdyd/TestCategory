//
//  ZJImageTextFieldTableViewCell.h
//  SuperGymV4
//
//  Created by ZJ on 4/22/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZJImageTextFieldTableViewCell;

@protocol ZJImageTextFieldTableViewCellDelegate  <NSObject>

@required
- (void)imageTextFieldTabeViewCell:(ZJImageTextFieldTableViewCell *)cell didEndEditWithText:(NSString *)text;

@optional
- (void)imageTextFieldTabeViewCell:(ZJImageTextFieldTableViewCell *)cell didBeganEditWithText:(NSString *)text;

- (void)imageTextFieldTabeViewCellRequestVerify:(ZJImageTextFieldTableViewCell *)cell;

@end

@interface ZJImageTextFieldTableViewCell : UITableViewCell

/**
 是否是验证码,默认为NO
 */
@property (nonatomic, getter=isVerifyCode) BOOL verifyCode;

/**
 cell是否需要左边距，默认为YES
 */
@property (nonatomic, getter=isNeedLeftMargin) BOOL needLeftMargin;

/**
 文本框是否需要左边距，默认为NO
 */
@property (nonatomic, getter=isNeedTextFieldLeftMargin) BOOL needtextFieldLeftMargin;

/**
 cell的分割线的边距,默认为YES
 */
@property (nonatomic, getter=isNeedSeparateLineMargin) BOOL needSeparateLineMargin;

/**
 是否是隐私输入,默认为NO
 */
@property (nonatomic, assign) BOOL secretInput;

@property (nonatomic, copy) NSString *placehold;
@property (nonatomic, copy) NSString *imgName;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *textFont;

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) UIColor *verifyBtnBgColor;

/**
 是否是数字键盘,默认为NO
 */
@property (nonatomic, assign) BOOL isKeyboardTypeNumberPad;

@property (nonatomic, weak) id <ZJImageTextFieldTableViewCellDelegate>delegate;

- (void)beganCountDown;

@end
