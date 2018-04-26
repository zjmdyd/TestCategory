//
//  ZJLoginFooterView.m
//  CanShengHealth
//
//  Created by ZJ on 29/01/2018.
//  Copyright © 2018 HY. All rights reserved.
//

#import "ZJLoginFooterView.h"


@interface ZJLoginFooterView()

@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIButton *regButton;

@end

@implementation ZJLoginFooterView

- (void)setTitle:(NSString *)title {
    _title = title;
    
    [self.button setTitle:_title forState:UIControlStateNormal];
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    
    [self.button setTitleColor:_titleColor forState:UIControlStateNormal];
}

- (void)setBgColor:(UIColor *)bgColor {
    _bgColor = bgColor;
    
    self.button.backgroundColor = _bgColor;
}

- (IBAction)buttonEvent:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(loginFooterView:didClickButtonAtIndex:)]) {
        [self.delegate loginFooterView:self didClickButtonAtIndex:sender.tag];
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
