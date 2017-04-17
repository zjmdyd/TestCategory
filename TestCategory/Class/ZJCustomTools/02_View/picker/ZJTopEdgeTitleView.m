//
//  ZJTopEdgeTitleView.m
//  ZJCustomTools
//
//  Created by ZJ on 6/15/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import "ZJTopEdgeTitleView.h"

@interface ZJTopEdgeTitleView ()

@property (nonatomic, strong) UILabel *mentionLabel;

@end

@implementation ZJTopEdgeTitleView

@synthesize leftButtonTitleColor = _leftButtonTitleColor;
@synthesize rightButtonTitleColor = _rightButtonTitleColor;

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self initSettingWithTarget:nil];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSettingWithTarget:nil];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame target:(id)target {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSettingWithTarget:target];
    }
    
    return self;
}

- (void)initSettingWithTarget:(id)target {
    self.backgroundColor = [UIColor whiteColor];
    
    NSArray *titles = @[@"取消", @"确定"];
    CGFloat width = 50;
    for (int i = 0; i < titles.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.tag = i;
        btn.frame = CGRectMake(i*(self.frame.size.width - width), 0, width, self.frame.size.height);
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        if (target) {
            [btn addTarget:target action:NSSelectorFromString(@"clickButton:") forControlEvents:UIControlEventTouchUpInside];
        }
        [self addSubview:btn];
    }
    
    self.mentionLabel = [[UILabel alloc] initWithFrame:CGRectMake(width, 0, self.frame.size.width - 2*width, self.frame.size.height)];
    self.mentionLabel.textAlignment = NSTextAlignmentCenter;
    self.mentionLabel.textColor = self.mentionTitleColor;
    [self addSubview:self.mentionLabel];
}

- (void)setTarget:(id)target {
    _target = target;
    
    for (UIButton *btn in self.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            [btn addTarget:_target action:NSSelectorFromString(@"clickButton:") forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

#pragma mark - setter

- (void)setLeftTitle:(NSString *)leftTitle {
    _leftTitle = leftTitle;
    UIButton *btn = [self.subviews objectAtIndex:0];
    [btn setTitle:_leftTitle forState:UIControlStateNormal];
}

- (void)setRightTitle:(NSString *)rightTitle {
    _rightTitle = rightTitle;
    UIButton *btn = [self.subviews objectAtIndex:1];
    [btn setTitle:_rightTitle forState:UIControlStateNormal];
}

- (void)setMentionTitle:(NSString *)mentionTitle {
    _mentionTitle = mentionTitle;
    self.mentionLabel.text = _mentionTitle;
}

- (void)setLeftButtonTitleColor:(UIColor *)leftButtonTitleColor {
    _leftButtonTitleColor = leftButtonTitleColor;
    UIButton *btn = [self.subviews objectAtIndex:0];
    [btn setTitleColor:_leftButtonTitleColor forState:UIControlStateNormal];
}

- (void)setRightButtonTitleColor:(UIColor *)rightButtonTitleColor {
    _rightButtonTitleColor = rightButtonTitleColor;
    UIButton *btn = [self.subviews objectAtIndex:1];
    [btn setTitleColor:_rightButtonTitleColor forState:UIControlStateNormal];
}

- (void)setMentionTitleColor:(UIColor *)mentionTitleColor {
    _mentionTitleColor = mentionTitleColor;
    self.mentionLabel.textColor = _mentionTitleColor;
}

@end
