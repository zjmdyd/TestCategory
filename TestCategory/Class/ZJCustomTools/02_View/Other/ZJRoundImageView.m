//
//  ZJRoundImageView.m
//  ButlerSugarDoctor
//
//  Created by ZJ on 4/6/16.
//  Copyright © 2016 csj. All rights reserved.
//

#import "ZJRoundImageView.h"

@implementation ZJRoundImageView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.frame.size.width / 2;
    self.contentMode = UIViewContentModeScaleAspectFill;
    
    self.layer.cornerRadius = self.needCorneradius ? self.frame.size.width/2 : 0;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.needCorneradius = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
