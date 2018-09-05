//
//  ZJSelectLabel.m
//  AoShiTong
//
//  Created by ZJ on 2018/8/3.
//  Copyright © 2018 HY. All rights reserved.
//

#import "ZJSelectLabel.h"

@implementation ZJSelectLabel

- (void)setSelect:(BOOL)select {
    _select = select;
    
    self.hidden = _select ? NO : YES;
    self.backgroundColor = _select ? self.selectColor : self.unSelectColor;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
