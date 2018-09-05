//
//  ZJRegisterView.m
//  CanShengHealth
//
//  Created by ZJ on 29/01/2018.
//  Copyright © 2018 HY. All rights reserved.
//

#import "ZJRegisterView.h"
#import "ZJSelectButton.h"

@interface ZJRegisterView()

@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIButton *articleButton;
@property (weak, nonatomic) IBOutlet ZJSelectButton *selectBtn;

@end

@implementation ZJRegisterView

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
    if ([self.delegate respondsToSelector:@selector(registerFooterView:didClickButtonAtIndex:)]) {
        [self.delegate registerFooterView:self didClickButtonAtIndex:sender.tag];
        
        if (sender.tag == 1) {
            ZJSelectButton *btn = (ZJSelectButton *)sender;
            btn.select = !btn.isSelect;
        }
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectBtn.selectImgName = @"ic_quan_red_36x36";
    self.selectBtn.unSelectImgName = @"ic_quan_white_36x36";
#ifdef MainColor
    [self.articleButton setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
#endif
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
