//
//  ZJTestNavigationBarViewController.m
//  TestCategory
//
//  Created by ZJ on 29/09/2017.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import "ZJTestNavigationBarViewController.h"
#import "ZJUIViewCategory.h"

@interface ZJTestNavigationBarViewController ()

@end

@implementation ZJTestNavigationBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor redColor]];
    [self.navigationController.navigationBar setHiddenSeparateLine:YES];
    self.view.backgroundColor = [UIColor redColor];
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
