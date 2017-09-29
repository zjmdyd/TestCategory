//
//  ZJTestBackBarButtonItemViewController.m
//  TestCategory
//
//  Created by ZJ on 09/05/2017.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import "ZJTestBackBarButtonItemViewController.h"

@interface ZJTestBackBarButtonItemViewController ()

@end

@implementation ZJTestBackBarButtonItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%s", __func__);

    NSLog(@"navigationController = %@", self.navigationController);
    NSLog(@"navigationItem.leftBarButtonItem = %@", self.navigationItem.leftBarButtonItem);
    NSLog(@"navigationItem.backBarButtonItem = %@", self.navigationItem.backBarButtonItem);
    NSLog(@"navigationBar.backItem = %@", self.navigationController.navigationBar.backItem);
    NSLog(@"navigationBar.backItem.title = %@", self.navigationController.navigationBar.backItem.title);
    NSLog(@"\n");
}

/**
 默认情况下，在当前视图控制器调用self.navigationItem.backBarButtonItem=nil ，除非你手动实例化它。（请记住它代表的是下一个视图的返回按钮，而不是当前的）
 系统不允许开发者获取当前视图控制器所显示的返回按钮UIBackBarButtonItem
 
 注意: 自定义返回按钮将导致侧滑返回手势失效!
 解决: self.navigationController.interactivePopGestureRecognizer.delegate = self;  //
 */
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"%s", __func__);

    NSLog(@"navigationItem.leftBarButtonItem = %@", self.navigationItem.leftBarButtonItem);
    NSLog(@"navigationItem.backBarButtonItem = %@", self.navigationItem.backBarButtonItem);
    NSLog(@"navigationBar.backItem = %@", self.navigationController.navigationBar.backItem);
    NSLog(@"navigationBar.backItem.title = %@", self.navigationController.navigationBar.backItem.title);
    NSLog(@"\n");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog(@"%s", __func__);

    NSLog(@"navigationItem.leftBarButtonItem = %@", self.navigationItem.leftBarButtonItem);
    NSLog(@"navigationItem.backBarButtonItem = %@", self.navigationItem.backBarButtonItem);
    NSLog(@"navigationBar.backItem = %@", self.navigationController.navigationBar.backItem);
    NSLog(@"navigationBar.backItem.title = %@", self.navigationController.navigationBar.backItem.title);
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
