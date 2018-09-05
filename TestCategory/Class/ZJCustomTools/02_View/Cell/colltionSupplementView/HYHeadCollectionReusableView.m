//
//  HYHeadCollectionReusableView.m
//  AoShiTong
//
//  Created by ZJ on 2018/7/27.
//  Copyright © 2018 HY. All rights reserved.
//

#import "HYHeadCollectionReusableView.h"

@interface HYHeadCollectionReusableView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation HYHeadCollectionReusableView

- (void)setTitle:(NSString *)title {
    _title = title;
    
    self.titleLabel.text = _title;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
