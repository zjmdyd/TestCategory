//
//  HYIocnCollectionViewCell.m
//  PEPlatform
//
//  Created by ZJ on 12/14/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import "HYIocnCollectionViewCell.h"

@interface HYIocnCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation HYIocnCollectionViewCell

- (void)setTitle:(NSString *)title {
    _title = title;
    
    self.titleLabel.hidden = NO;
    self.titleLabel.text = _title;
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    
    self.titleLabel.textColor = _titleColor;
}

- (void)setIconPath:(NSString *)iconPath {
    _iconPath = iconPath;
    
    if ([_iconPath hasPrefix:@"http:"]) {
//        [self.imageView sd_setImageWithURL:[NSURL URLWithString:_iconPath] placeholderImage:[UIImage imageNamed:@"ic_yisheng_106x106"] options:SDWebImageRefreshCached];
    }else {
        self.imageView.image = [UIImage imageNamed:_iconPath]?:[UIImage imageNamed:@"ic_yisheng_106x106"];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
