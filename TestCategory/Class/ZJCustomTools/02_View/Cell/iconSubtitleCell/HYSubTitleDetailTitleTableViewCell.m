//
//  HYSubTitleDetailTitleTableViewCell.m
//  XAHealthDoctor
//
//  Created by ZJ on 1/4/17.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import "HYSubTitleDetailTitleTableViewCell.h"

@interface HYSubTitleDetailTitleTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconIV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightDetailTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightDetailSubTextLabel;

@end

@implementation HYSubTitleDetailTitleTableViewCell

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

#pragma mark - setter

- (void)setIconSubTitlesObj:(ZJIconSubTitleObject *)iconSubTitlesObj {
    _iconSubTitlesObj = iconSubTitlesObj;
    
//    [self.iconIV sd_setImageWithURL:[NSURL URLWithString:_iconSubTitlesObj.headIconPath] placeholderImage:[UIImage imageNamed:@"ic_touxiang_136x136"] options:SDWebImageRefreshCached];
    self.titleLabel.text = _iconSubTitlesObj.title.length?_iconSubTitlesObj.title:@"--";
    self.subTitleLabel.text = _iconSubTitlesObj.subTitle.length?_iconSubTitlesObj.subTitle:@"--";
    self.rightDetailTextLabel.text = _iconSubTitlesObj.accessoryText;
    self.rightDetailSubTextLabel.text = _iconSubTitlesObj.accessorySubText;
}

- (void)setHiddenDetailView:(BOOL)hiddenDetailView {
    _hiddenDetailView = hiddenDetailView;
    
    self.rightDetailTextLabel.hidden = _hiddenDetailView;
    self.rightDetailSubTextLabel.hidden = _hiddenDetailView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
