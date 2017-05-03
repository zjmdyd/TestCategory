//
//  ZJNSNumberViewController.m
//  TestCategory
//
//  Created by ZJ on 5/3/17.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import "ZJNSNumberViewController.h"

@interface ZJNSNumberViewController ()

@end

@implementation ZJNSNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self test];
}

/**
 三个内存地址一样
 */
- (void)test {
    NSNumber *obj1 = @1;
    NSNumber *obj2 = [NSNumber numberWithInt:1];
    NSNumber *obj3 = [[NSNumber alloc] initWithInt:1];
    NSLog(@"obj1 = %p, obj2 = %p, obj3 = %p", obj1, obj2, obj3);
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
