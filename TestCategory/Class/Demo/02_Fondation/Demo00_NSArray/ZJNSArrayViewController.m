//
//  ZJNSArrayViewController.m
//  TestCategory
//
//  Created by ZJ on 4/14/17.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import "ZJNSArrayViewController.h"

@interface ZJNSArrayViewController ()

@end

@implementation ZJNSArrayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *ary = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        [ary addObject:@(i).stringValue];
    }
    
    NSLog(@"%@", [ary componentsJoinedByString:@", "]);
    NSLog(@"%zd", [ary containsObject:@"1"]);
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
