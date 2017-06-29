//
//  ZJTestTabBarViewController.m
//  TestCategory
//
//  Created by ZJ on 29/06/2017.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import "ZJTestTabBarViewController.h"
#import "ZJTabBarViewController.h"
#import "ZJCategoryHeaderFile.h"

@interface ZJTestTabBarViewController ()

@end

@implementation ZJTestTabBarViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initAry];
    [self initSettiing];
}

- (void)initAry {
    
}

- (void)initSettiing {
    NSArray *titles = @[@"俱乐部", @"场馆"];
    NSArray *vcs = @[@"ZJTestViewController", @"ZJTestViewController"];
    
    NSMutableArray *ary = [NSMutableArray array];
    for (int i = 0; i < titles.count; i++) {
        UIViewController *vc = [self createVCWithName:vcs[i] title:titles[i]];
        [ary addObject:vc];
    }
    
    ZJTabBarViewController *barVC = [[ZJTabBarViewController alloc] initWithViewControllers:ary];
//    barVC.delegate = self;
//    barVC.offsetX = 20;
    barVC.hidesBottomBarWhenPushed = YES;
    barVC.topViewBgColor = [UIColor greenColor];
    [self addChildViewController:barVC];
    [self.view addSubview:barVC.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    self.navigationController.navigationBar.hidden = YES;
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
