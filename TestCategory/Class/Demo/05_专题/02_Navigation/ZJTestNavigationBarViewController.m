//
//  ZJTestNavigationBarViewController.m
//  TestCategory
//
//  Created by ZJ on 29/09/2017.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import "ZJTestNavigationBarViewController.h"

@interface ZJTestNavigationBarViewController ()

@end

@implementation ZJTestNavigationBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.view.backgroundColor = [UIColor redColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor redColor];
    
    for (UIView *view in self.navigationController.navigationBar.subviews) {
        if ([view isMemberOfClass:NSClassFromString(@"_UIBarBackground")]) {
            for (UIView *sView in view.subviews) {
                if ([sView isMemberOfClass:NSClassFromString(@"UIVisualEffectView")]) {
                    for (UIView *ssView in sView.subviews) {
                        if ([ssView isMemberOfClass:NSClassFromString(@"_UIVisualEffectSubview")]) {
                            ssView.hidden = YES;
                            // [ssView removeFromSuperview];    // 该子视图移除不了, 只能隐藏
                        }else {
                            ssView.backgroundColor = [UIColor redColor];
                        }
                    }
                }else {
                    sView.hidden = YES;
                }
            }
        }else {
            // _UINavigationBarContentView
        }
    }
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
