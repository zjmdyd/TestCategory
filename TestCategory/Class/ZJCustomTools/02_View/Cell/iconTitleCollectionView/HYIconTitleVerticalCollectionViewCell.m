//
//  HYIconTitleVerticalCollectionViewCell.m
//  PEPlatform
//
//  Created by ZJ on 12/14/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import "HYIconTitleVerticalCollectionViewCell.h"

@interface HYIconTitleVerticalCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation HYIconTitleVerticalCollectionViewCell

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
