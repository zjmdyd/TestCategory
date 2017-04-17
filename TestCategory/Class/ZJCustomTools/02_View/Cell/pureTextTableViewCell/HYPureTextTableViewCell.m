//
//  HYPureTextTableViewCell.m
//  PEPlatform
//
//  Created by ZJ on 11/11/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import "HYPureTextTableViewCell.h"

@interface HYPureTextTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *mTextLabel;

@end

@implementation HYPureTextTableViewCell

- (void)setText:(NSString *)text {
    _text = text;
    
    self.mTextLabel.text = _text;
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    
    self.mTextLabel.textColor = _textColor;
}

- (void)setFont:(UIFont *)font {
    self.mTextLabel.font = _font;
}

- (void)setNumberOfLine:(NSInteger)numberOfLine {
    _numberOfLine = numberOfLine;
    
    self.mTextLabel.numberOfLines = _numberOfLine;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    _textAlignment = textAlignment;
    
    self.mTextLabel.textAlignment = _textAlignment;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
