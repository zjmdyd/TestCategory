//
//  ZJBaseTabBarViewController.m
//  TestCategory
//
//  Created by ZJ on 5/3/17.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import "ZJBaseTabBarViewController.h"
//#import "ZJControllerHeaderFile.h"
#import "ZJUIViewCategory.h"

@interface ZJBaseTabBarViewController ()

@end

@implementation ZJBaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initSetting];
}

- (void)initSetting {
    NSArray *titles = @[@"NSObject", @"UIKit", @"Fondation", @"Controller", @"Other"];
    NSArray *image = @[@"ic_shouye_72x72", @"ic_dangan_72x72", @"ic_faxian_72x72", @"ic_wode_72x72", @"ic_faxian_72x72"];
    NSArray *selectImage = @[@"ic_shouye_blue_72x72", @"ic_dangan_blue_72x72", @"ic_faxian_blue_72x72", @"ic_wode_blue_72x72", @"ic_faxian_blue_72x72"];
    NSArray *nibNames = @[@"ZJNSObjectTableViewController", @"ZJUIKitTableViewController", @"ZJFondationTableViewController", @"ZJControllerTableViewController", @"ZJOtherTableViewController"];
    
    NSMutableArray *ary = [NSMutableArray array];
    for (int i = 0; i < nibNames.count; i++) {
        UIViewController *vc = [NSClassFromString(nibNames[i]) alloc];
        if ([vc isKindOfClass:[UITableViewController class]]) {
            vc = [((UITableViewController *)vc) initWithStyle:UITableViewStyleGrouped];
        }else {
            vc = [vc init];
        }
        
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
        ((UIViewController *)navi.viewControllers[0]).title = titles[i];
        navi.navigationBar.translucent = NO;
        navi.tabBarItem.image = [[UIImage imageNamed:image[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        navi.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [navi.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : UIColorFromHex(0x0EC6DC)} forState:UIControlStateSelected];
        [ary addObject:navi];
    }
    
    self.viewControllers = [ary copy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
//        navi.navigationBarBgColor = UIColorFromHex(0x64ebeb);
//        navi.navigationBarTintColor = UIColorFromHex(0xfffffa);//[UIColor whiteColor];
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
