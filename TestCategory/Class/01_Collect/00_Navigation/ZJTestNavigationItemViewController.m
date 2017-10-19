//
//  ZJTestNavigationItemViewController.m
//  TestCategory
//
//  Created by ZJ on 09/05/2017.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import "ZJTestNavigationItemViewController.h"

@interface ZJTestNavigationItemViewController ()

@end

@implementation ZJTestNavigationItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%s", __func__);
    NSLog(@"self.navigationController = %@", self.navigationController);
    NSLog(@"self.navigationItem = %@", self.navigationItem);
    NSLog(@"self.navigationController.navigationItem = %@", self.navigationController.navigationItem);
    NSLog(@"\n");
}

/**
 self.navigationItem:每一个加到navigationController的viewController都会有一个对应的navigationItem，该对象由viewController以懒加载的方式创建
 
 self.navigationController.navigationItem : 只会创建一个
 */
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"%s", __func__);
    NSLog(@"self.navigationController = %@", self.navigationController);
    NSLog(@"self.navigationItem = %@", self.navigationItem);
    NSLog(@"self.navigationController.navigationItem = %@", self.navigationController.navigationItem);
    NSLog(@"\n");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog(@"%s", __func__);
    NSLog(@"self.navigationController = %@", self.navigationController);
    NSLog(@"self.navigationItem = %@", self.navigationItem);
    NSLog(@"self.navigationController.navigationItem = %@", self.navigationController.navigationItem);
    NSLog(@"\n");
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
