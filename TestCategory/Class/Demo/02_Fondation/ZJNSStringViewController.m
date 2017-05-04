//
//  ZJNSStringViewController.m
//  TestCategory
//
//  Created by ZJ on 5/3/17.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import "ZJNSStringViewController.h"

@interface ZJNSStringViewController ()

@end

@implementation ZJNSStringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self test];
}

- (void)test {
    /**
     obj1和obj2两个地址不一样
     */
    NSString *obj1 = @"呵呵";
    NSString *obj2 = [NSString stringWithFormat:@"%@", @"呵呵"];
    NSLog(@"obj1 = %p, obj2 = %p", obj1, obj2);
    
    /*
        obj1和obj3指向的地址是一样的,obj1和obj4指向的地址是不一样的
     */
    NSString *obj3 = [obj1 copy];
    NSString *obj4 = [obj1 mutableCopy];
    NSLog(@"obj3 = %p, %p", obj3, &obj3);   // obj3 = 0x10c324160, 0x7fff53935018
    NSLog(@"obj1 = %p, %p", obj1, &obj1);   // obj1 = 0x10c324160, 0x7fff53935028
    NSLog(@"obj4 = %p, %p", obj4, &obj4);   // obj3 = 0x10c324160, 0x7fff53935018
    
    [self stringToColor:@""];
}

/**
 一个面试题：使用内联函数把@“#ff3344”转成UIColor
 */
- (UIColor *)stringToColor:(NSString *)str {
    if (!str || [str isEqualToString:@""]) {
        return nil;
    }
    unsigned red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 1;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&red];
    range.location = 3;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&green];
    range.location = 5;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&blue];
    UIColor *color= [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1];
    return color;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
