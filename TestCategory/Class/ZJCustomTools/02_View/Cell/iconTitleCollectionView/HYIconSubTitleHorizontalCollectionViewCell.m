//
//  HYIconSubTitleHorizontalCollectionViewCell.m
//  XAHealthDoctor
//
//  Created by ZJ on 1/3/17.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import "HYIconSubTitleHorizontalCollectionViewCell.h"

@interface HYIconSubTitleHorizontalCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@end

#ifndef kScreenW

#define kScreenW    ([UIScreen mainScreen].bounds.size.width)
#define kScreenH    ([UIScreen mainScreen].bounds.size.height)

#endif

@implementation HYIconSubTitleHorizontalCollectionViewCell

- (void)layoutSubviews {
    [super layoutSubviews];
    
//    CGFloat kWidth = (kScreenW-1)/2 - 8 - 4;    // cell的宽度
//    CGFloat height = (kScreenW-1)/2.5;          // cell的高度
//    CGFloat widht = (height-1)/2-24;            // icon的宽度
    
//    [self.subTitleLabel fitFontWithPointSize:13 width:kWidth-widht height:21 descend:!kIsIplus];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    self.titleLabel.text = _title;
}

- (void)setSubTitle:(NSString *)subTitle {
    _subTitle = subTitle;
    
    self.subTitleLabel.text = _subTitle;
}

- (void)setIconPath:(NSString *)iconPath {
    _iconPath = iconPath;
    
    if ([_iconPath hasPrefix:@"http:"]) {
        
    }else {
        self.imageView.image = [UIImage imageNamed:_iconPath];
    }
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    
    self.titleLabel.textColor = _titleColor;
}

- (void)setSubTitleColor:(UIColor *)subTitleColor {
    _subTitleColor = subTitleColor;
    
    self.subTitleColor = _titleColor;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
