//
//  ZJSexView.m
//  WeiMing
//
//  Created by ZJ on 18/04/2018.
//  Copyright © 2018 HY. All rights reserved.
//

#import "ZJSexView.h"

@interface ZJSexView ()

@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UILabel *label;

@end

@implementation ZJSexView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initSetting];
    }
    
    return self;
}

- (void)initSetting {    
    self.btn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.btn.frame = CGRectMake(0, 0, 31, 31);
    [self addSubview:self.btn];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(self.btn.frame.origin.x + self.btn.frame.size.width+4, self.btn.frame.origin.y+5, 18, 21)];
    self.label.text = @"男";
    [self addSubview:self.label];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    self.label.text = _title;
}

- (void)setTarget:(id)target {
    _target = target;
    
    [self.btn addTarget:self.target action:NSSelectorFromString(@"selectSexEvent:") forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelect:(BOOL)select {
    _select = select;
    
    [self.btn setImage:[_select ? self.selectImg : self.unSelectImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    
    if (_select) {
        if (self.selectTitleColor) {
            self.label.textColor = self.selectTitleColor;
        }
    }else {
        if (self.unselectTitleColor) {
            self.label.textColor = self.unselectTitleColor;
        }else {
            self.label.textColor = [UIColor blackColor];
        }
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
