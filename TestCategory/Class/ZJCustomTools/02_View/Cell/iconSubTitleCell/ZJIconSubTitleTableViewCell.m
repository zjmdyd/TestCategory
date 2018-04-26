//
//  ZJIconSubTitleTableViewCell.m
//  CanShengHealth
//
//  Created by ZJ on 31/01/2018.
//  Copyright © 2018 HY. All rights reserved.
//

#import "ZJIconSubTitleTableViewCell.h"
#import "ZJRoundImageView.h"
#import "ZJCategoryHeaderFile.h"

@interface ZJIconSubTitleTableViewCell()

@property (weak, nonatomic) IBOutlet ZJRoundImageView *iconIV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *accessoryTextLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconLeftWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLeftConstraint;

@end

@implementation ZJIconSubTitleTableViewCell

#pragma mark - setter

- (void)setImgName:(NSString *)imgName {
    _imgName = imgName;
    
    [self.iconIV setImageWithPath:_imgName placeholdName:@"ic_tixing_152x152"];
    
    self.iconWidthConstraint.constant = 60;
    self.titleLeftConstraint.constant = DefaultMargin;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    self.titleLabel.text = _title;
}

- (void)setSubTitle:(NSString *)subTitle {
    _subTitle = subTitle;
    
    self.subTitleLabel.text = _subTitle;
}

- (void)setAccessoryText:(NSString *)accessoryText {
    _accessoryText = accessoryText;
    
    self.accessoryTextLabel.text = _accessoryText;
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    
    self.titleLabel.textColor = _titleColor;
}

- (void)setSubTitleColor:(UIColor *)subTitleColor {
    _subTitleColor = subTitleColor;
    
    self.subTitleLabel.textColor = _subTitleColor;
}

- (void)setAccessoryTextColor:(UIColor *)accessoryTextColor {
    _accessoryTextColor = accessoryTextColor;
    
    self.accessoryTextLabel.textColor = _accessoryTextColor;
}

- (void)setRead:(BOOL)read {
    _read = read;
    if (!_read) {
        [self.iconIV addIconBadgeWithText:@"" bgColor:[UIColor redColor]];
    }else {
        [self.iconIV removeIconBadge];
    }
}

- (void)setIconLeftMargin:(CGFloat)iconLeftMargin {
    _iconLeftMargin = iconLeftMargin;
    
    self.iconLeftWidthConstraint.constant = _iconLeftMargin;
}

- (void)setNeedTitleLeftMargin:(BOOL)needTitleLeftMargin {
    _needTitleLeftMargin = needTitleLeftMargin;
    
    self.titleLeftConstraint.constant = _needTitleLeftMargin ? DefaultMargin : FLT_EPSILON;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.iconWidthConstraint.constant = FLT_EPSILON;
    self.needTitleLeftMargin = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
