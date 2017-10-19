//
//  ZJRuntimeViewController.m
//  ZJFoundation
//
//  Created by ZJ on 8/18/16.
//  Copyright © 2016 YunTu. All rights reserved.
//

#import "ZJRuntimeViewController.h"
#import <objc/runtime.h>

@interface ZJRuntimeViewController ()

@end

@implementation ZJRuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *ary1 = @[@1, @2, @3];
    NSArray *ary2 = @[@1, @2, @3, @4];
    
    //根据方法名say找到该方法的id,将sel与其绑定；
    SEL sel = @selector(count);//也可以这样写：SEL sel=NSSelectorFromString(@"say");
    IMP imp1 = [ary1 methodForSelector:sel];
    IMP imp2 = [ary2 methodForSelector:sel];
    
    imp1(ary1, sel);
    imp2(ary2, sel);
    //因为每个方法都有自己的地址，这种方式直接找到地址区分相同ID的方法，效率最高，但灵活性不如SEL方式。
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
