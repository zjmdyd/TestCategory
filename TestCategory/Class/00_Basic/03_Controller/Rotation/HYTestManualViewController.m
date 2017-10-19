//
//  HYTestManualViewController.m
//  Test
//
//  Created by ZJ on 27/09/2017.
//  Copyright © 2017 HY. All rights reserved.
//

#import "HYTestManualViewController.h"

@interface HYTestManualViewController ()

@property (nonatomic, assign) BOOL fullScreen;
@property (nonatomic, assign) UIInterfaceOrientation visibleInterfaceOrientation;

@end

@implementation HYTestManualViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.visibleInterfaceOrientation = UIInterfaceOrientationPortrait;
}

- (IBAction)buttonEvent:(UIButton *)sender {
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:NO];

    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (IBAction)rotation:(UIButton *)sender {
    self.fullScreen = !self.fullScreen;
    
    if (self.fullScreen) {
        self.visibleInterfaceOrientation = UIInterfaceOrientationLandscapeRight;
    }else {
        self.visibleInterfaceOrientation = UIInterfaceOrientationPortrait;
    }
    
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:YES];
    
    self.view.transform = CGAffineTransformMakeRotation(self.fullScreen ? M_PI/2 : 0);
    CGFloat width, height;
    if (self.fullScreen) {
        width = [UIScreen mainScreen].bounds.size.width;
        height = [UIScreen mainScreen].bounds.size.height;
    }else {
        height = [UIScreen mainScreen].bounds.size.width;
        width = [UIScreen mainScreen].bounds.size.height;
    }
    self.view.bounds = CGRectMake(0, 0, width, height);
    [[UIApplication sharedApplication] setStatusBarOrientation:self.visibleInterfaceOrientation animated:YES];
    if ([UIApplication sharedApplication].isStatusBarHidden) {
        [UIApplication sharedApplication].statusBarHidden = NO;
    }
}

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
    return self.visibleInterfaceOrientation;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
 
    self.view.backgroundColor = [UIColor brownColor];
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
