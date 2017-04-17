//
//  HYPullDownSelectView.m
//  DiabetesGuardForDoctor
//
//  Created by ZJ on 6/28/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import "HYPullDownSelectView.h"
#import "ZJSelectButton.h"

#define kToolBarH 44
#define kPullButtonWidth 50

@interface HYPullDownSelectView ()<ZJFooterViewDelegate>

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *topTitleLabel;

@end

@implementation HYPullDownSelectView

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self initSetting];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSetting];
    }
    
    return self;
}

- (void)initSetting {
    self.hidden = YES;
    self.touchEnable = NO;
    
    CGFloat height = 21;
    
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 0)];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.bgView];
    
    self.topTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (kToolBarH-height)/2, kScreenW-kPullButtonWidth, height)];
    self.topTitleLabel.textColor = [UIColor lightGrayColor];
    [self.bgView addSubview:self.topTitleLabel];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(kScreenW-kPullButtonWidth, 5, kPullButtonWidth, kToolBarH-10);
    btn.tintColor = [UIColor lightGrayColor];
    [btn setImage:[UIImage imageNamed:@"ic_arrow_up_gray_32x18"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(showSelectView:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:btn];
}

- (void)showSelectView:(UIButton *)sender {
    self.hidden = !self.isHidden;
}

- (void)selectPullDownView:(ZJSelectButton *)sender {
    sender.select = !sender.isSelect;
    
    if (sender.isSelect) {
        sender.backgroundColor = [UIColor mainColor];
    }else {
        sender.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
}

#pragma mark - setter

- (void)setTopTitle:(NSString *)topTitle {
    _topTitle = topTitle;
    
    self.topTitleLabel.text = _topTitle;
}

- (void)setTitles:(NSArray *)titles {
    _titles = titles;
    
    NSInteger count = 4;
    CGFloat width = (self.bgView.width - 2*SeparateHeight - 3*DefaultMargin) / count;
    CGFloat height = 35;
    
    for (int i = 0; i < _titles.count; i++) {
        ZJSelectButton *btn = [ZJSelectButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(SeparateHeight + DefaultMargin*(i%count) + width*(i%count), self.topTitleLabel.bottom + i/4*height + SeparateHeight*(i/count+1), width, height);
        btn.select = YES;
        [btn setTitle:_titles[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(selectPullDownView:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:btn];
        
        if (i == _titles.count - 1) {
            ZJFooterView *footView = [ZJFooterView footerViewWithTitle:@"完成" delegate:self];
            footView.delegate = self;
            [self.bgView addSubview:footView];
            self.bgView.height = footView.bottom + DefaultMargin;
        }
    }
}

- (void)footerViewDidClick:(ZJFooterView *)footView {
    self.hidden = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
