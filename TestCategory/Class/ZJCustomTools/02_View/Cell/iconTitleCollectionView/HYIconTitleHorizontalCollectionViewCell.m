//
//  HYIconTitleHorizontalCollectionViewCell.m
//  XAHealthDoctor
//
//  Created by ZJ on 1/3/17.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import "HYIconTitleHorizontalCollectionViewCell.h"

@interface HYIconTitleHorizontalCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation HYIconTitleHorizontalCollectionViewCell

- (void)setTitle:(NSString *)title {
    _title = title;
    
    self.titleLabel.text = _title;
}

- (void)setIconPath:(NSString *)iconPath {
    _iconPath = iconPath;
    
    if ([_iconPath hasPrefix:@"http:"]) {
        
    }else {
        self.imageView.image = [UIImage imageNamed:_iconPath];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
