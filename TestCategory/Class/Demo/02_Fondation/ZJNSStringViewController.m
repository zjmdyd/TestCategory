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

/**
 两个地址不一样
 */
- (void)test {
    NSString *obj1 = @"呵呵";
    NSString *obj2 = [NSString stringWithFormat:@"%@", @"呵呵"];
    NSLog(@"obj1 = %p, obj2 = %p", obj1, obj2);
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
