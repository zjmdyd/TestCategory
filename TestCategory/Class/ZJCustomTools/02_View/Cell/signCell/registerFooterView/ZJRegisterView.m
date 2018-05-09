//
//  ZJRegisterView.m
//  CanShengHealth
//
//  Created by ZJ on 29/01/2018.
//  Copyright © 2018 HY. All rights reserved.
//

#import "ZJRegisterView.h"

@interface ZJRegisterView()

@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIButton *termsIconBtn;
@property (weak, nonatomic) IBOutlet UIButton *termsButton;

@end

@implementation ZJRegisterView

- (void)setTitle:(NSString *)title {
    _title = title;
    
    [self.button setTitle:_title forState:UIControlStateNormal];
}

- (void)setImgName:(NSString *)imgName {
    _imgName = imgName;

    [self.termsIconBtn setImage:[UIImage imageNamed:_imgName] forState:UIControlStateNormal];
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    
    [self.button setTitleColor:_titleColor forState:UIControlStateNormal];
}

- (void)setTermsColor:(UIColor *)termsColor {
    _termsColor = termsColor;
    
    self.termsButton.tintColor = _termsColor;
}

- (void)setBgColor:(UIColor *)bgColor {
    _bgColor = bgColor;
    
    self.button.backgroundColor = _bgColor;
}

- (IBAction)buttonEvent:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(registerFooterView:didClickButtonAtIndex:)]) {
        [self.delegate registerFooterView:self didClickButtonAtIndex:sender.tag];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.button.layer.cornerRadius = 8.0;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
