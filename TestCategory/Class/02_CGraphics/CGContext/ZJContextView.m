//
//  ZJContextView.m
//  ZJCoreGraphics
//
//  Created by YunTu on 10/7/15.
//  Copyright © 2015 YunTu. All rights reserved.
//

#import "ZJContextView.h"
#import "UIViewExt.h"

@implementation ZJContextView

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();

#define Method1
    
#ifndef Method1
    CGContextTranslateCTM(context, 0, self.height);
    CGContextScaleCTM(context, 1.0, -1.0);
#else
    CGContextRotateCTM(context, M_PI);
    CGContextScaleCTM(context, -1.0, 1.0);
    CGContextTranslateCTM(context, 0, -self.height);
#endif
    
#if 1
    UIImage *img = [UIImage imageNamed:@"1.jpg"];
    
    if (self.tag == 1) {
        CGContextTranslateCTM(context, 0, self.height/2);
    }else if (self.tag == 2) {
        CGContextScaleCTM(context, 1, 0.5);
    }else if(self.tag > 2){
        CGContextScaleCTM(context, 1, 0.5);
        CGContextTranslateCTM(context, 0, self.height/2);
        if (self.tag == 4) {
            CGContextRotateCTM(context, -M_PI/8);
        }
    }
    NSLog(@"%@", NSStringFromCGPoint(self.layer.anchorPoint));
    CGContextDrawImage(context, self.bounds, img.CGImage);
#endif
}

@end
/*
 
 iOS开发中，有时候展示图片等内容的时候，会出现锯齿。比如笔者最近使用 iCarousel 控件的Cover flow效果来展示几幅图片时，两侧的图片出现了较为严重的锯齿，着实不好看。这里列出两个方式：
 
 在info.plist中打开抗锯齿，但是会对影响整个应用的渲染速度；
 Renders with edge antialisasing = YES （UIViewEdgeAntialiasing）
 Renders with group opacity = YES （UIViewGroupOpacity）
 View.layer.shouldRasterize = YES；
 */
