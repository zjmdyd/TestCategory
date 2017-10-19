//
//  ColorTransformer.m
//  ZJFoundation
//
//  Created by YunTu on 15/6/13.
//  Copyright (c) 2015年 YunTu. All rights reserved.
//

#import "ColorTransformer.h"
#import <UIKit/UIKit.h>

@implementation ColorTransformer

//+ (BOOL)allowsReverseTransformation {
//    return YES;
//}
//
//+ (Class)transformedValueClass {
//    return [NSData class];
//}
//
//- (id)transformedValue:(id)value {
//    UIColor *color = (UIColor *)value;
//    CGFloat red, green, blue, alpha;
//    
//    [color getRed:&red green:&green blue:&blue alpha:&alpha];
//    CGFloat components[4] = {red, green, blue, alpha};
//    
//    NSData *dataFormaterColor = [[NSData alloc] initWithBytes:components length:sizeof(components)];
//    return dataFormaterColor;
//}
//
//- (id)reverseTransformedValue:(id)value {
//    NSData *data = (NSData *)value;
//    CGFloat components[4] = {0.0, 0.0, 0.0, 0.0};
//    [data getBytes:components length:sizeof(components)];
//    UIColor *color = [UIColor colorWithRed:components[0] green:components[1] blue:components[2] alpha:components[3]];
//    
//    return color;
//}

@end
