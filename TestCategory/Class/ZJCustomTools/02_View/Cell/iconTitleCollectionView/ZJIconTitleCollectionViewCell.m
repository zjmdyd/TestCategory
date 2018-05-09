//
//  ZJIconTitleCollectionViewCell.m
//  TestCategory
//
//  Created by ZJ on 03/07/2017.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import "ZJIconTitleCollectionViewCell.h"

@implementation ZJIconTitleCollectionViewCell

- (void)setContentBgColor:(UIColor *)contentBgColor {
    _contentBgColor = contentBgColor;
    
    self.contentView.backgroundColor = _contentBgColor;
    self.backgroundColor = [UIColor clearColor];
}

- (void)setNeedCorner:(BOOL)needCorner {
    _needCorner = needCorner;
    if (needCorner) {
        self.contentView.layer.cornerRadius = 10;
        self.contentView.layer.masksToBounds = YES;
    }
}

@end
