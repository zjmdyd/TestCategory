//
//  ZJNormalTableViewCell.m
//  WeiMing
//
//  Created by ZJ on 12/04/2018.
//  Copyright © 2018 HY. All rights reserved.
//

#import "ZJNormalTableViewCell.h"
#import "ZJDefine.h"

@implementation UIView(FitFrameView)

- (CGFloat) left {
    return self.frame.origin.x;
}

- (void) setLeft: (CGFloat) newleft {
    CGRect newframe = self.frame;
    newframe.origin.x = newleft;
    self.frame = newframe;
}

- (void) setHeight: (CGFloat) newheight {
    CGRect newframe = self.frame;
    newframe.size.height = newheight;
    self.frame = newframe;
}

@end

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
}

- (void)fitTextFont:(UIFont *)font {
    if (font) {
        self.textLabel.font = font;
        self.detailTextLabel.font = font;
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
