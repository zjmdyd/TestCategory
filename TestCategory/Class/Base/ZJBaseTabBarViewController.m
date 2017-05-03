//
//  ZJBaseTabBarViewController.m
//  TestCategory
//
//  Created by ZJ on 5/3/17.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import "ZJBaseTabBarViewController.h"
#import "ZJControllerHeaderFile.h"

@interface ZJBaseTabBarViewController ()

@end

@implementation ZJBaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initSetting];
}

- (void)initSetting {
    NSArray *titles = @[@"NSObject", @"UIKit", @"Fondation", @"Controller"];
    NSArray *image = @[@"ic_shouye_72x72", @"ic_xiaoxi_72x72", @"ic_wode_72x72", @"ic_wode_72x72"];
    NSArray *selectImage = @[@"ic_shouye_blue_72x72", @"ic_xiaoxi_blue_72x72", @"ic_wode_blue_72x72", @"ic_wode_blue_72x72"];
    NSArray *nibNames = @[@"ZJNSObjectTableViewController", @"ZJUIKitTableViewController", @"ZJFondationTableViewController", @"ZJControllerTableViewController"];
    
    NSMutableArray *ary = [NSMutableArray array];
    for (int i = 0; i < nibNames.count; i++) {
        UIViewController *vc = [NSClassFromString(nibNames[i]) alloc];
        if ([vc isKindOfClass:[UITableViewController class]]) {
            vc = [((UITableViewController *)vc) initWithStyle:UITableViewStyleGrouped];
        }else {
            vc = [vc init];
        }
        
        ZJNavigationController *navi = [[ZJNavigationController alloc] initWithRootViewController:vc];
        navi.navigationBarBgColor = [UIColor whiteColor];
        navi.navigationBarTintColor = [UIColor blackColor];
        ((UIViewController *)navi.viewControllers[0]).navigationItem.title = navi.tabBarItem.title = titles[i];
        navi.tabBarItem.image = [[UIImage imageNamed:image[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        navi.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [navi.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]} forState:UIControlStateSelected];
        [ary addObject:navi];
    }
    
    self.viewControllers = [ary copy];
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
