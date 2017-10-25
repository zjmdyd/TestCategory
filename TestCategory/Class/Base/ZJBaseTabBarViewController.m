//
//  ZJBaseTabBarViewController.m
//  TestCategory
//
//  Created by ZJ on 5/3/17.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import "ZJBaseTabBarViewController.h"
#import "ZJViewHeaderFile.h"
#import "ZJCategoryHeaderFile.h"

@interface ZJBaseTabBarViewController () <UINavigationControllerDelegate>

@property (nonatomic, strong) UIButton *foregroundBtn;

@end

@implementation ZJBaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initSetting];
}

- (void)initSetting {
    NSArray *titles = @[
                        @"Basic", @"Collect", @"CGGraphics", @"CAAnimation", @"Demo"
                        ];
    NSArray *image = @[
                       @"ic_shouye_72x72", @"ic_wode_72x72", @"ic_dangan_72x72", @"ic_faxian_72x72", @"ic_faxian_72x72"
                       ];
    NSArray *selectImage = @[
                             @"ic_shouye_blue_72x72", @"ic_wode_blue_72x72", @"ic_dangan_blue_72x72", @"ic_faxian_blue_72x72", @"ic_faxian_blue_72x72"
                             ];
    NSArray *nibNames = @[
                          @"ZJBasicTableViewController", @"ZJCollectTableViewController", @"ZJCAGraphicsTableViewController",
                          @"ZJAnimationTableViewController", @"ZJDemoTableViewController"
                          ];
    
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
        vc.tabBarItem.image = [[UIImage imageNamed:image[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : UIColorFromHex(0x0EC6DC)} forState:UIControlStateSelected];
        navi.delegate = self;
        [ary addObject:navi];
    }

    self.viewControllers = [ary copy];
}

- (void)btnEvent:(UIButton *)sender {
    UIViewController *vc = [self createVCWithName:@"ZJTopicTableViewController" title:sender.currentTitle isGroupTableVC:YES];
    vc.hidesBottomBarWhenPushed = YES;
    [self.selectedViewController pushViewController:vc animated:YES];
}

- (UIButton *)foregroundBtn {
    if (!_foregroundBtn) {
        _foregroundBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _foregroundBtn.frame = CGRectMake(kScreenW-100, kScreenH-160, 70, 70);
        [_foregroundBtn setTitle:@"专题" forState:UIControlStateNormal];
        [_foregroundBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_foregroundBtn setBackgroundImage:[UIImage imageNamed:@"ic_asu_142x142"] forState:UIControlStateNormal];
        [_foregroundBtn addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _foregroundBtn;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (!_foregroundBtn) {
        [KeyWindow addSubview:self.foregroundBtn];
    }
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    _foregroundBtn.hidden = navigationController.viewControllers.count > 1;
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
