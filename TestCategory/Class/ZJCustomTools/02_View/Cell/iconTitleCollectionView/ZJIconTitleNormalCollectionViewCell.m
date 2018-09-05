//
//  ZJIconTitleNormalCollectionViewCell.m
//  PEPlatform
//
//  Created by ZJ on 12/14/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import "ZJIconTitleNormalCollectionViewCell.h"

@interface ZJIconTitleNormalCollectionViewCell ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end

@implementation ZJIconTitleNormalCollectionViewCell

@synthesize text = _text;
@synthesize iconPath = _iconPath;
@synthesize attrText = _attrText;
@synthesize textColor = _textColor;
@synthesize textAlignment = _textAlignment;
@synthesize font = _font;

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.iconPath) {
        if ([self.iconPath hasPrefix:@"http:"] || [self.iconPath hasPrefix:@"assets-library:"]) {
#ifdef ZJSDWebImage
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.iconPath] placeholderImage:[UIImage imageNamed:self.iconPlaceholder] options:SDWebImageRefreshCached];
#else
            self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.iconPath]]];
#endif
        }else {
            self.imageView.image = [UIImage imageNamed:self.iconPath] ?: [UIImage imageNamed:self.iconPlaceholder];
        }
    }
}

//- (void)setIconPath:(NSString *)iconPath {
//    _iconPath = iconPath;
//    
//    if ([_iconPath hasPrefix:@"http:"] || [self.iconPath hasPrefix:@"assets-library:"]) {
//#ifdef ZJSDWebImage
//        [self.imageView sd_setImageWithURL:[NSURL URLWithString:_iconPath] placeholderImage:[UIImage imageNamed:self.iconPlaceholder] options:SDWebImageRefreshCached];
//#else
//        self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.iconPath]]];
//#endif
//    }else {
//        self.imageView.image = [UIImage imageNamed:_iconPath] ?: [UIImage imageNamed:self.iconPlaceholder];
//    }
//}

- (void)setText:(NSString *)text {
    _text = text;
    self.textLabel.text = _text?:@"";
    self.textField.text = _text?:@"";
}

- (void)setAttrText:(NSAttributedString *)attrText {
    _attrText = attrText;
    
    self.textLabel.attributedText = _attrText;
}

- (void)setFont:(UIFont *)font {
    _font = font;
    self.textField.font = _font;
    self.textLabel.font = _font;
}

- (void)setTextPlaceholder:(NSString *)textPlaceholder {
    _textPlaceholder = textPlaceholder;
    
    self.textField.placeholder = _textPlaceholder;
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    
    self.textField.textColor = _textColor;
    self.textLabel.textColor = _textColor;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    _textAlignment = textAlignment;
    
    self.textField.textAlignment = _textAlignment;
    self.textLabel.textAlignment = _textAlignment;
}

- (void)setEnableEdit:(BOOL)enableEdit {
    _enableEdit = enableEdit;
    
    self.textField.enabled = _enableEdit;
    self.textField.hidden = !_enableEdit;
    self.textLabel.hidden = _enableEdit;
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(iconTitleNormalCollectionViewCell:didEndEditWithText:)]) {
        [self.delegate iconTitleNormalCollectionViewCell:self didEndEditWithText:textField.text];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
