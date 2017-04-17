//
//  HYSelectSexTableViewCell.m
//  ButlerSugar
//
//  Created by ZJ on 2/26/16.
//  Copyright © 2016 csj. All rights reserved.
//

#import "HYSelectSexTableViewCell.h"
#import "ZJSelectButton.h"

@interface HYSelectSexTableViewCell () {
    BOOL _isFirstLoad;
}

@property (weak, nonatomic) IBOutlet UIView *selectSexView;
@property (nonatomic, strong) NSArray *sexButtons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *titleLabels;

@end

@implementation HYSelectSexTableViewCell

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.text = @"性别";
    self.accessoryType = UITableViewCellAccessoryNone;
}

- (IBAction)selectSexAction:(ZJSelectButton *)sender {
    sender.select = YES;
    
    for (ZJSelectButton *btn in self.sexButtons) {
        if (![btn isEqual:sender]) {
            btn.select = NO;
            break;
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(hySelectSexTableViewCell:didClickButtonAtIndex:)]) {
        [self.delegate hySelectSexTableViewCell:self didClickButtonAtIndex:sender.tag];
    }
}

#pragma mark - setter

- (void)setDelegate:(id<HYSelectSexDelegate>)delegate {
    _delegate = delegate;
    
    self.selectSexView.userInteractionEnabled = !(_delegate==nil);
}

- (void)setSelectImgNames:(NSArray *)selectImgNames {
    _selectImgNames = selectImgNames;
    
    if (selectImgNames.count > 0 && _selectImgNames.count == self.sexButtons.count) {
        for (ZJSelectButton *btn in self.sexButtons) {
            btn.selectImg = [UIImage imageNamed:_selectImgNames[btn.tag]];
        }
    }
}

- (void)setUnselectImgNames:(NSArray *)unselectImgNames {
    _unselectImgNames = unselectImgNames;
    
    if (_unselectImgNames.count > 0 && _unselectImgNames.count == self.sexButtons.count) {
        for (ZJSelectButton *btn in self.sexButtons) {
            btn.unSelectImg = [UIImage imageNamed:_unselectImgNames[btn.tag]];
        }
    }
}

- (void)setSelectIndex:(NSInteger)selectIndex {
    if (selectIndex<0 || selectIndex > 1) {
        selectIndex = 0;
    }
    _selectIndex = selectIndex;
    
    for (ZJSelectButton *btn in self.sexButtons) {
        if (btn.tag == selectIndex) {
            btn.select = YES;
        }else {
            btn.select = NO;
        }
    }
}

- (void)setTitles:(NSArray *)titles {
    _titles = titles;
    
    if (_titles.count >= self.titleLabels.count) {
        for (UILabel *btn in self.titleLabels) {
            btn.text = _titles[btn.tag];
            btn.textColor = [UIColor groupTableViewBackgroundColor];
        }
    }
}

#pragma mark - getter

- (NSArray *)sexButtons {
    if (!_sexButtons) {
        NSMutableArray *ary = [NSMutableArray array];        
        for (UIView *view in self.selectSexView.subviews) {
            if ([view isMemberOfClass:[ZJSelectButton class]]) {
                [ary addObject:view];
            }
        }
        _sexButtons = [ary mutableCopy];
    }
    
    return _sexButtons;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectSexView.userInteractionEnabled = NO;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
