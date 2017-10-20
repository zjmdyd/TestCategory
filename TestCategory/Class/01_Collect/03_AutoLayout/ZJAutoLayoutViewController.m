//
//  ZJAutoLayoutViewController.m
//  ZJUIKit
//
//  Created by YunTu on 15/7/16.
//  Copyright (c) 2015年 YunTu. All rights reserved.
//

#import "ZJAutoLayoutViewController.h"
#import "UIViewExt.h"

@interface ZJAutoLayoutViewController () {
    CGFloat _maxContentHeight, _minContentHeight;
}

@property (weak, nonatomic) IBOutlet UIButton *logBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

#define BarBottom self.navigationController.navigationBar.bottom
#define BarHeight self.navigationController.navigationBar.height
#define StatusBarHeight 20

@implementation ZJAutoLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"statusBarFrame = %@", NSStringFromCGRect([UIApplication sharedApplication].statusBarFrame));
}

/*
    如果不修改约束,则不能改变mapView的frame,因为logBtn的centerY约束的值保持不变,不会自动随着屏幕大小改变而改变
 */
- (void)viewWillAppear:(BOOL)animated { // contentHeight = Max(width, height) - BarBottom
    NSLog(@"%s", __func__);
    NSLog(@"\n\n");
    NSLog(@"view_size = %@", NSStringFromCGSize(self.view.size));
    NSLog(@"size = %@", NSStringFromCGSize(self.scrollView.size));
    NSLog(@"contentSize = %@", NSStringFromCGSize(self.scrollView.contentSize));

    if (self.view.width < self.view.height) {   // 竖屏
        if (self.view.height - BarBottom != self.scrollView.height) {  // 如果设备尺寸与storyboar大小不匹配
            CGFloat height = (self.view.size.height - BarBottom)*0.5 - self.logBtn.height*0.5 - 26;
            [self updateConstrains:height];
        }
        _maxContentHeight = (self.view.height - BarBottom) * 0.5;
        _minContentHeight = (self.view.width - BarHeight) * 0.5;
    }else {
        _maxContentHeight = (self.view.width - BarBottom - StatusBarHeight) * 0.5;
        _minContentHeight = (self.view.height - BarBottom) * 0.5;
        CGFloat height = (self.view.size.width - BarBottom) * 0.5 - self.logBtn.height*0.5 - 26 + _maxContentHeight - _minContentHeight;
        [self updateConstrains:height];
    }
}

- (void)updateConstrains:(CGFloat)height {
    NSLog(@"\n\n");
    NSLog(@"%s", __func__);
    NSLog(@"height = %f\n\n", height);
    for (NSLayoutConstraint *cst in self.scrollView.constraints) {
        if (cst.firstAttribute == NSLayoutAttributeCenterY) {
            [self.scrollView removeConstraint:cst];
            
            NSLayoutConstraint *centerYConstrain = [NSLayoutConstraint constraintWithItem:self.logBtn
                                                                                attribute:NSLayoutAttributeCenterY
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:self.scrollView
                                                                                attribute:NSLayoutAttributeCenterY
                                                                               multiplier:1.0
                                                                                 constant:height];//
            [self.scrollView addConstraint:centerYConstrain];
            
            break;
        }
    }
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    NSLog(@"\n\n\%s\n\n", __func__);
    
    [self performSelector:@selector(showSize) withObject:nil afterDelay:0.25];
}

- (void)showSize {
    NSLog(@"\n\n");
    NSLog(@"view_size = %@", NSStringFromCGSize(self.view.size));
    NSLog(@"size = %@", NSStringFromCGSize(self.scrollView.size));
    NSLog(@"contentSize = %@", NSStringFromCGSize(self.scrollView.contentSize));

    if (self.view.width > self.view.height) {
        self.scrollView.contentSize = CGSizeMake(self.view.width, self.view.width - BarHeight - StatusBarHeight);
        CGFloat height = self.scrollView.contentSize.height*0.5 - self.logBtn.height*0.5 - 26 + _maxContentHeight - _minContentHeight;
        [self updateConstrains:height];
    }else {
        self.scrollView.contentSize = CGSizeMake(self.view.width, self.view.height - BarHeight - StatusBarHeight);
        CGFloat height = self.scrollView.contentSize.height*0.5 - self.logBtn.height*0.5 - 26;
        [self updateConstrains:height];
    }
    
    NSLog(@"\n\n");
    NSLog(@"view_size = %@", NSStringFromCGSize(self.view.size));
    NSLog(@"size = %@", NSStringFromCGSize(self.scrollView.size));
    NSLog(@"contentSize = %@", NSStringFromCGSize(self.scrollView.contentSize));
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"\n\n");
    NSLog(@"%s\n\n", __func__);
    NSLog(@"view_size = %@", NSStringFromCGSize(self.view.size));
    NSLog(@"size = %@", NSStringFromCGSize(self.scrollView.size));
    NSLog(@"contentSize = %@", NSStringFromCGSize(self.scrollView.contentSize));
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
