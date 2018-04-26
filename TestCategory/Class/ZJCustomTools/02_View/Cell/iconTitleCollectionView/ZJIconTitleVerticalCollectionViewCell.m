//
//  ZJIconTitleVerticalCollectionViewCell.m
//  PEPlatform
//
//  Created by ZJ on 12/14/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import "ZJIconTitleVerticalCollectionViewCell.h"

@interface ZJIconTitleVerticalCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;

@end

@implementation ZJIconTitleVerticalCollectionViewCell

@synthesize text = _text;
@synthesize textColor = _textColor;
@synthesize textAlignment = _textAlignment;
@synthesize iconWidth = _iconWidth;

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.iconPath) {
        if ([self.iconPath hasPrefix:@"http:"] || [self.iconPath hasPrefix:@"assets-library:"]) {
#ifdef SDWebImage
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.iconPath] placeholderImage:[UIImage imageNamed:self.iconPlaceholder] options:SDWebImageRefreshCached];
#else
            self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.iconPath]]];
#endif
        }else {
            self.imageView.image = [UIImage imageNamed:self.iconPath] ?: [UIImage imageNamed:self.iconPlaceholder];
        }
    }
}

- (void)setText:(NSString *)text {
    _text = text;
    
    self.textLabel.text = _text?:@"";
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    
    self.textLabel.textColor = _textColor;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    _textAlignment = textAlignment;
    
    self.textLabel.textAlignment = _textAlignment;
}

- (void)setIconWidth:(CGFloat)iconWidth {
    _iconWidth = iconWidth;
    
    self.widthConstraint.constant = _iconWidth;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
