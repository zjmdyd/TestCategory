//
//  ZJFilePathTableViewCell.m
//  ZJFoundation
//
//  Created by YunTu on 15/8/18.
//  Copyright (c) 2015年 YunTu. All rights reserved.
//

#import "ZJFilePathTableViewCell.h"
#import "UIViewExt.h"

@interface ZJFilePathTableViewCell ()

@property (nonatomic, strong) UIImageView *iv;

@end

@implementation ZJFilePathTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSetting];
    }
    
    return self;
}

- (void)initSetting {
    self.iv = [[UIImageView alloc] init];
    [self.contentView addSubview:self.iv];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.iv.frame = CGRectMake(0, 0, self.width, self.height);
    self.iv.contentMode = self.ivContentMode;
    self.iv.image = self.image;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
