//
//  ZJTitleTextFieldTableViewCell.m
//  SportWatch
//
//  Created by ZJ on 3/14/17.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import "ZJTitleTextFieldTableViewCell.h"

@interface ZJTitleTextFieldTableViewCell ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ZJTitleTextFieldTableViewCell

- (void)setTitle:(NSString *)title {
    _title = title;
    
    self.titleLabel.text = _title;
}

- (void)setPlacehold:(NSString *)placehold {
    _placehold = placehold;
    
    self.textField.placeholder = _placehold;
}

- (void)setValue:(NSString *)value {
    _value = value;
    
    self.textField.text = _value;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    _textAlignment = textAlignment;
    
    self.textField.textAlignment = _textAlignment;
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    
    self.textField.textColor = _textColor;
}

- (void)setKeyboardType:(UIKeyboardType)keyboardType {
    _keyboardType = keyboardType;
    
    self.textField.keyboardType = _keyboardType;
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(titleTextFieldTableViewCell:didEndEditWithText:)]) {
        [self.delegate titleTextFieldTableViewCell:self didEndEditWithText:textField.text];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
