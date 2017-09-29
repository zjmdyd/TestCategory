//
//  HYTestAutoRotationViewController.m
//  Test
//
//  Created by ZJ on 27/09/2017.
//  Copyright © 2017 HY. All rights reserved.
//

#import "HYTestAutoRotationViewController.h"

@interface HYTestAutoRotationViewController ()

@end

@implementation HYTestAutoRotationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)exitEvent:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  self需要是present / showDetail才能起作用
 */
#pragma mark - 横屏

// 支持屏幕旋转方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
}

// 自动旋转
- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeRight;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
 
    self.view.backgroundColor = [UIColor brownColor];

    if ([UIApplication sharedApplication].isStatusBarHidden) {
        [UIApplication sharedApplication].statusBarHidden = NO;
    }
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
