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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self share];
}

- (void)share {
    //分享的标题
    NSString *textToShare = @"哈哈哈";
    //分享的图片
    UIImage *imageToShare = [UIImage imageNamed:@"aa"];
    //分享的url
    NSURL *urlToShare = [NSURL URLWithString:@"http://www.baidu.com"];
    //在这里呢 如果想分享图片 就把图片添加进去  文字什么的通上
    NSArray *activityItems = @[textToShare, imageToShare, urlToShare];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
    //不出现在活动项目
    activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll, UIActivityTypePostToFlickr, UIActivityTypePostToVimeo, UIActivityTypeSaveToCameraRoll];
    [self presentViewController:activityVC animated:YES completion:nil];
}

- (IBAction)exitEvent:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  self需要是present / showDetail才能起作用
 */
#pragma mark - 横屏

// 支持屏幕旋转方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {  // 2 4
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
}

// 自动旋转
- (BOOL)shouldAutorotate {  // 3
    return NO;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeRight;    // 1
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
 
    self.view.backgroundColor = [UIColor brownColor];

    if ([UIApplication sharedApplication].isStatusBarHidden) {
        [UIApplication sharedApplication].statusBarHidden = NO;
    }
    
    [self.view setNeedsDisplay];
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
