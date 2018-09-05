//
//  ZJIconTitleHorizontalCollectionViewCell.m
//  XAHealthDoctor
//
//  Created by ZJ on 1/3/17.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import "ZJIconTitleHorizontalCollectionViewCell.h"

@interface ZJIconTitleHorizontalCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation ZJIconTitleHorizontalCollectionViewCell

@synthesize text = _text;
@synthesize textColor = _textColor;
@synthesize iconPath = _iconPath;

- (void)setText:(NSString *)text {
    _text = text;
    
    [self.btn setTitle:_text forState:UIControlStateNormal];
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    
    [self.btn setTitleColor:_textColor forState:UIControlStateNormal];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.iconPath) {
        if ([self.iconPath hasPrefix:@"http:"] || [self.iconPath hasPrefix:@"assets-library:"]) {
#ifdef ZJSDWebImage
            [self.btn sd_setImageWithURL:[NSURL URLWithString:_iconPath] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:self.iconPlaceholder]];
#else
            [self.btn setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_iconPath]]] forState:UIControlStateNormal];
#endif
        }else {
            UIImage *image = [UIImage imageNamed:_iconPath] ?: [UIImage imageNamed:self.iconPlaceholder];
            [self.btn setImage:image forState:UIControlStateNormal];        }
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
