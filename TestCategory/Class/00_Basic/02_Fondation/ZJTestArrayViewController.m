//
//  ZJTestArrayViewController.m
//  TestCategory
//
//  Created by ZJ on 4/14/17.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import "ZJTestArrayViewController.h"

@interface ZJTestArrayViewController ()

@end

@implementation ZJTestArrayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *ary = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        [ary addObject:@(i)];
    }
    
    NSLog(@"%@", [ary componentsJoinedByString:@", "]);
    NSLog(@"%d", [ary containsObject:@0]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
