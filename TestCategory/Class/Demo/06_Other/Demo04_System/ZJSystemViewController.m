
//
//  ZJSystemViewController.m
//  TestCategory
//
//  Created by ZJ on 1/1/17.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import "ZJSystemViewController.h"
#import "ZJNSObjectCategory.h"

@interface ZJSystemViewController ()

@end

@implementation ZJSystemViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [UIDevice deviceType];
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
