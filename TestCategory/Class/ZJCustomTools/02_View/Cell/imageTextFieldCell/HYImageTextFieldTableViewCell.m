//
//  HYImageTextFieldTableViewCell.m
//  SuperGymV4
//
//  Created by ZJ on 4/22/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import "HYImageTextFieldTableViewCell.h"

@interface HYImageTextFieldTableViewCell ()<UITextFieldDelegate> {
    NSInteger _countDown;
}

@property (weak, nonatomic) IBOutlet UIImageView *iconIV;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *verifyButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconLeftWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *verifyWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textFieldLeadingConstraint;

@end

#ifndef DefaultMargin

#define DefaultMargin 8     // 默认边距

#endif

@implementation HYImageTextFieldTableViewCell

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.imgName) {
        self.iconIV.image = [UIImage imageNamed:self.imgName];
    }
    
    if (self.placehold && self.textColor) {
        self.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placehold attributes:@{NSForegroundColorAttributeName: self.textColor}];
    }else {
        self.textField.placeholder = self.placehold;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.verifyCode = NO;
    self.needLeftMargin = YES;
    self.needtextFieldLeftMargin = NO;
    
    self.iconWidthConstraint.constant = FLT_EPSILON;
    
//    self.verifyButton.backgroundColor = [UIColor mainColor];
    self.verifyButton.layer.cornerRadius = 4.0;
    [self.verifyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - setter

- (void)setImgName:(NSString *)imgName {
    _imgName = imgName;

    self.iconWidthConstraint.constant = 25;
    
    self.iconLeftWidthConstraint.constant = self.isNeedLeftMargin ? DefaultMargin : FLT_EPSILON;
    self.textFieldLeadingConstraint.constant = DefaultMargin;
}

- (void)setVerifyCode:(BOOL)verifyCode {
    _verifyCode = verifyCode;
    
    self.verifyWidthConstraint.constant = _verifyCode ? 60 : FLT_EPSILON;
    self.verifyButton.hidden = !_verifyCode;
}

- (void)setNeedLeftMargin:(BOOL)needLeftMargin {
    _needLeftMargin = needLeftMargin;
    
    self.iconLeftWidthConstraint.constant = _needLeftMargin ? DefaultMargin : FLT_EPSILON;
}

- (void)setNeedtextFieldLeftMargin:(BOOL)needtextFieldLeftMargin {
    _needtextFieldLeftMargin = needtextFieldLeftMargin;
    
    self.textFieldLeadingConstraint.constant = _needtextFieldLeftMargin ? DefaultMargin : FLT_EPSILON;
}

- (void)setNeedSeparateLineMargin:(BOOL)needSeparateLineMargin {
    _needSeparateLineMargin = needSeparateLineMargin;
    
    CGFloat margin = DefaultMargin*2;
    if (!_needSeparateLineMargin) {
        margin = FLT_EPSILON;
    }
    
    UIEdgeInsets edge = UIEdgeInsetsMake(0, margin, 0, 0);
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:edge];
    }
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:edge];
    }
}

- (void)setSecretInput:(BOOL)secretInput {
    _secretInput = secretInput;
    
    self.textField.secureTextEntry = _secretInput;
}

- (void)setText:(NSString *)text {
    _text = text;
    self.textField.text = _text;
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    
    self.textField.textColor = _textColor;
    self.textField.tintColor = _textColor;
}

- (void)setTextFont:(UIFont *)textFont {
    _textFont = textFont;
    self.textField.font = _textFont;
}

- (void)setIsKeyboardTypeNumberPad:(BOOL)isKeyboardTypeNumberPad {
    _isKeyboardTypeNumberPad = isKeyboardTypeNumberPad;
    
    if (_isKeyboardTypeNumberPad) {
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
    }else {
        self.textField.keyboardType = UIKeyboardTypeDefault;
    }
}

- (void)setVerifyBtnBgColor:(UIColor *)verifyBtnBgColor {
    _verifyBtnBgColor = verifyBtnBgColor;
    
    self.verifyButton.backgroundColor = _verifyBtnBgColor;
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(imageTextFieldTabeViewCell:didEndEditWithText:)]) {
        [self.delegate imageTextFieldTabeViewCell:self didEndEditWithText:textField.text];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(imageTextFieldTabeViewCell:didBeganEditWithText:)]) {
        [self.delegate imageTextFieldTabeViewCell:self didBeganEditWithText:textField.text];
    }
}

- (IBAction)getVerify:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(imageTextFieldTabeViewCellRequestVerify:)] && _countDown == 0) {
        if ([self.delegate isKindOfClass:[UIViewController class]]) {
            [((UIViewController *)self.delegate).view endEditing:YES];
        }
        [self.delegate imageTextFieldTabeViewCellRequestVerify:self];
    }
}

- (void)countDown:(NSTimer *)timer {
    _countDown--;
    [self.verifyButton setTitle:[NSString stringWithFormat:@"%zds", _countDown] forState:UIControlStateNormal];
    
    if (_countDown == 0) {
        [timer invalidate];
        [self.verifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
}

- (void)beganCountDown {
    _countDown = 60;
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
