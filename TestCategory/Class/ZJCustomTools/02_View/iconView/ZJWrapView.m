//
//  ZJWrapView.m
//  WeiMing
//
//  Created by ZJ on 13/04/2018.
//  Copyright © 2018 HY. All rights reserved.
//

#import "ZJWrapView.h"

@implementation ZJWrapView

+ (UIView *)createNibViewWithNibName:(NSString *)name frame:(CGRect)frame needWrap:(BOOL)need {
    UIView *view = [[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil].firstObject;
    
    if (need) {
        ZJWrapView *wrapView;
        wrapView = [[ZJWrapView alloc] initWithFrame:frame];
        view.frame = wrapView.bounds;
        wrapView.wrapView = view;
        [wrapView addSubview:view];
        
        return wrapView;
    }else {
        view.frame = frame;
    }
    return view;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
