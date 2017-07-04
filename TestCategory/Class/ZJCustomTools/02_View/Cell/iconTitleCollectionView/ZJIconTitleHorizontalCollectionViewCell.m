//
//  ZJIconTitleHorizontalCollectionViewCell.m
//  XAHealthDoctor
//
//  Created by ZJ on 1/3/17.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import "ZJIconTitleHorizontalCollectionViewCell.h"

@interface ZJIconTitleHorizontalCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end

@implementation ZJIconTitleHorizontalCollectionViewCell

@synthesize text = _text;
@synthesize textColor = _textColor;
@synthesize iconPath = _iconPath;
@synthesize placeholder = _placeholder;

- (void)setText:(NSString *)text {
    _text = text;
    
    self.textLabel.text = _text?:@"";
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    
    self.textLabel.textColor = _textColor;
}

- (void)setIconPath:(NSString *)iconPath {
    _iconPath = iconPath;
    
    if ([_iconPath hasPrefix:@"http:"]) {
#ifdef SDWebImage
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:_iconPath] placeholderImage:[UIImage imageNamed:self.placeholder] options:SDWebImageRefreshCached];
#else
        self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_iconPath]]];
#endif
    }else {
        self.imageView.image = [UIImage imageNamed:_iconPath] ?: [UIImage imageNamed:self.placeholder];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
