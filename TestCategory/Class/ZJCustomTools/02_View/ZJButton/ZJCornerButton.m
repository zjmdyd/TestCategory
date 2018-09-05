//
//  ZJCornerButton.m
//  LeBangAED
//
//  Created by ZJ on 2018/8/31.
//  Copyright © 2018 HY. All rights reserved.
//

#import "ZJCornerButton.h"

@implementation ZJCornerButton

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.layer.cornerRadius = 8.0;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 8.0;
    }
    
    return self;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    
    self.layer.cornerRadius = _cornerRadius;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
