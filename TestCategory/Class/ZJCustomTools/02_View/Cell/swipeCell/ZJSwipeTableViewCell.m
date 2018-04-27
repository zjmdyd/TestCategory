//
//  ZJSwipeTableViewCell.m
//  TodayTodo
//
//  Created by ZJ on 6/22/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import "ZJSwipeTableViewCell.h"

@interface ZJSwipeTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@property (nonatomic, strong) UISwipeGestureRecognizer *swp;
@property (nonatomic, strong) UITapGestureRecognizer *tap;

@end

@implementation ZJSwipeTableViewCell

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.contentLabel.text = self.content;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.deleteBtn.hidden = _hiddenDeleteBtn = YES;
    
    self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    self.tap.enabled = NO;
    self.tap.delegate = self;
    [self.bgView addGestureRecognizer:self.tap];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.bgView addGestureRecognizer:pan];
}

- (void)tap:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
        self.hiddenDeleteBtn = YES;
    }
}

- (void)pan:(UIPanGestureRecognizer *)pan {
    CGPoint point = [pan translationInView:self.bgView];
    if (pan.state == UIGestureRecognizerStateBegan) {
        self.deleteBtn.hidden = NO;
    }else if (pan.state == UIGestureRecognizerStateChanged) {
        if (point.x < 0) {
            if (fabs(point.x) <= self.deleteBtn.frame.size.width) {
                self.bgView.transform = CGAffineTransformMakeTranslation(point.x, 0);
            }
        }else {
            if (self.bgView.frame.origin.x < 0) {
                self.bgView.transform = CGAffineTransformMakeTranslation(point.x, 0);
            }
        }
    }else if (pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateCancelled) {
        if (point.x < 0) {
            self.hiddenDeleteBtn = !(fabs(point.x) > self.deleteBtn.frame.size.width / 2);
        }else {
            self.hiddenDeleteBtn = (fabs(point.x) > self.deleteBtn.frame.size.width / 2) || self.bgView.frame.origin.x>-self.deleteBtn.frame.size.width/2;
        }
    }
}

- (void)setHiddenDeleteBtn:(BOOL)hiddenDeleteBtn {
    _hiddenDeleteBtn = hiddenDeleteBtn;
    
    if (_hiddenDeleteBtn) {
        [UIView animateWithDuration:0.25 animations:^{
            self.bgView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            self.deleteBtn.hidden = self->_hiddenDeleteBtn;
        }];
    }else {
        self.deleteBtn.hidden = _hiddenDeleteBtn;
        [UIView animateWithDuration:0.25 animations:^{
            self.bgView.transform = CGAffineTransformMakeTranslation(-self.deleteBtn.frame.size.width, 0);
        }];
    }
    self.tap.enabled = !_hiddenDeleteBtn;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
