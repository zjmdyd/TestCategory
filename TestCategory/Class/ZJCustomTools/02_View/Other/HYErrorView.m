//
//  HYErrorView.m
//  Care
//
//  Created by ZJ on 8/12/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import "HYErrorView.h"

@interface HYErrorView ()

@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *loadBtn;

@end

@implementation HYErrorView

- (IBAction)btnAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(errorViewDidTriggerEvent:)]) {
        self.hidden = YES;
        [self.delegate errorViewDidTriggerEvent:self];
    }
}

- (void)showErrorViewWithMsg:(NSString *)msg {
    [self showMsg:msg];
    self.loadBtn.hidden = NO;
}

- (void)showErrorViewWithMsg:(NSString *)msg type:(HYErrorViewType)type {
    [self showMsg:msg];
    
    self.loadBtn.hidden = type == HYErrorViewTypeOfEmpty;
}

- (void)showMsg:(NSString *)msg {
    self.hidden = NO;
    self.textLabel.text = msg;
}

#pragma mark - setter

- (void)setImgName:(NSString *)imgName {
    _imgName = imgName;
    self.imageView.image = [UIImage imageNamed:_imgName];
}

- (void)setButtonTitle:(NSString *)buttonTitle {
    _buttonTitle = buttonTitle;
    [self.loadBtn setTitle:_buttonTitle forState:UIControlStateNormal];
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    [self.loadBtn setTitleColor:_titleColor forState:UIControlStateNormal];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
