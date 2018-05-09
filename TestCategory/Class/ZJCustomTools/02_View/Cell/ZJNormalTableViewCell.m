//
//  ZJNormalTableViewCell.m
//  WeiMing
//
//  Created by ZJ on 12/04/2018.
//  Copyright © 2018 HY. All rights reserved.
//

#import "ZJNormalTableViewCell.h"
#import "UIViewExt.h"

#ifndef DefaultMargin

#define DefaultMargin 8     // 默认边距

#endif

@implementation ZJNormalTableViewCell

- (void)layoutSubviews {
    [super layoutSubviews];
    
    for (UIView *subview in self.contentView.superview.subviews) {
        if ([NSStringFromClass(subview.class) hasSuffix:@"SeparatorView"]) {
            subview.hidden = self.hiddenSeparateLine;
            subview.alpha = 1;
            if (!self.hiddenSeparateLine) {
                subview.left = self.needSeparateLineMargin ? DefaultMargin*2 : FLT_EPSILON;
                if (!self.needSeparateLineMargin) {
                    [self setSeparatorInset:UIEdgeInsetsZero];
                }
            }
        }
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.font = [UIFont systemFontOfSize:17];
        self.detailTextLabel.font = [UIFont systemFontOfSize:17];
        
        self.needSeparateLineMargin = YES;
        self.imageView.layer.masksToBounds = YES;
    }
    
    return self;
}

- (void)setIVCornerRadius:(CGFloat)needCornerRadius {
    self.imageView.layer.cornerRadius = needCornerRadius;
    self.imageView.layer.masksToBounds = YES;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
