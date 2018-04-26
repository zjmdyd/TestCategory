//
//  ZJSelectSexTableViewCell.m
//  ButlerSugar
//
//  Created by ZJ on 2/26/16.
//  Copyright © 2016 csj. All rights reserved.
//

#import "ZJSelectSexTableViewCell.h"
#import "ZJSexView.h"

@interface ZJSelectSexTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *selectSexView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;   // 默认为性别
@property (strong, nonatomic) IBOutletCollection(ZJSexView) NSArray *sexViews;

@end

@implementation ZJSelectSexTableViewCell

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self updateUI];
}

- (void)selectSexEvent:(UIButton *)sender {
    self.selectIndex = sender.superview.tag;
    [self updateUI];
    
    if ([self.delegate respondsToSelector:@selector(selectSexTableViewCell:didClickButtonAtIndex:)]) {
        [self.delegate selectSexTableViewCell:self didClickButtonAtIndex:sender.superview.tag];
    }
}

#pragma mark - setter

- (void)setTitle:(NSString *)title {
    _title = title;
    
    self.titleLabel.text = _title;
}

- (void)setSexTitles:(NSArray *)sexTitles {
    _sexTitles = sexTitles;
    
    for (int i = 0; i < _sexTitles.count; i++) {
        if (i < self.sexViews.count) {
            ZJSexView *sv = self.sexViews[i];
            sv.title = _sexTitles[i];
        }
    }
}

- (void)setDelegate:(id<HYSelectSexDelegate>)delegate {
    _delegate = delegate;
    
    self.selectSexView.userInteractionEnabled = _delegate!=nil;
}

- (void)setSelectImgNames:(NSArray *)selectImgNames {
    _selectImgNames = selectImgNames;

    for (int i = 0; i < _selectImgNames.count; i++) {
        if (i < self.sexViews.count) {
            ZJSexView *sv = self.sexViews[i];
            sv.selectImg = [UIImage imageNamed:_selectImgNames[i]];
        }
    }
}

- (void)setUnselectImgNames:(NSArray *)unselectImgNames {
    _unselectImgNames = unselectImgNames;

    for (int i = 0; i < _unselectImgNames.count; i++) {
        if (i < self.sexViews.count) {
            ZJSexView *sv = self.sexViews[i];
            sv.unSelectImg = [UIImage imageNamed:_unselectImgNames[i]];
        }
    }
}

- (void)setSelectTitleColors:(NSArray *)selectTitleColors {
    _selectTitleColors = selectTitleColors;
    
    for (int i = 0; i < _selectTitleColors.count; i++) {
        if (i < self.sexViews.count) {
            ZJSexView *sv = self.sexViews[i];
            sv.selectTitleColor = _selectTitleColors[i];
        }
    }
}

- (void)setUnselectTitleColors:(NSArray *)unselectTitleColors {
    _unselectTitleColors = unselectTitleColors;
    
    for (int i = 0; i < _unselectTitleColors.count; i++) {
        if (i < self.sexViews.count) {
            ZJSexView *sv = self.sexViews[i];
            sv.selectTitleColor = _unselectTitleColors[i];
        }
    }
}

- (void)updateUI {
    for (ZJSexView *sv in self.sexViews) {
        sv.select = self.selectIndex == sv.tag;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    for (ZJSexView *sv in self.sexViews) {
        sv.target = self;
        sv.title = @[@"男", @"女"][sv.tag];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
