//
//  HYSubTitleRectangleIconTableViewCell.m
//  XAHealthDoctor
//
//  Created by ZJ on 1/4/17.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import "HYSubTitleRectangleIconTableViewCell.h"

@interface HYSubTitleRectangleIconTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconIV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIView *detailView;
@property (weak, nonatomic) IBOutlet UIImageView *detailIconIV;
@property (weak, nonatomic) IBOutlet UILabel *rightDetailTextLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;

@end

@implementation HYSubTitleRectangleIconTableViewCell

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.needCornerRadius) {
        [self performSelector:@selector(resetFrame) withObject:nil afterDelay:0.1];
    }
}

- (void)resetFrame {
    self.iconIV.layer.cornerRadius = self.iconIV.frame.size.width / 2;
    self.iconIV.layer.masksToBounds = YES;
}

- (IBAction)btnAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(subTitleRectangleIconTableViewCell:didSelectDetailViewAtIndexPath:)]) {
        [self.delegate subTitleRectangleIconTableViewCell:self didSelectDetailViewAtIndexPath:self.indexPath];
    }
}

#pragma mark - setter

- (void)setIconSubTitlesObj:(ZJIconSubTitleObject *)iconSubTitlesObj {
    _iconSubTitlesObj = iconSubTitlesObj;
    
//    [self.iconIV sd_setImageWithURL:[NSURL URLWithString:_iconSubTitlesObj.headIconPath] placeholderImage:[UIImage imageNamed:@"ic_touxiang_136x136"] options:SDWebImageRefreshCached];
    self.titleLabel.text = _iconSubTitlesObj.title;
    self.subTitleLabel.text = _iconSubTitlesObj.subTitle;
}

- (void)setHiddenDetailView:(BOOL)hiddenDetailView {
    _hiddenDetailView = hiddenDetailView;
    
    self.detailView.hidden = _hiddenDetailView;
    self.widthConstraint.constant = _hiddenDetailView ? 0.0:48;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.hiddenDetailView = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
