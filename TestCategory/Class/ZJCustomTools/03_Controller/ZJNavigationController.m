//
//  ZJNavigationController.m
//  SportWatch
//
//  Created by ZJ on 2/24/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import "ZJNavigationController.h"
#import "ZJUIViewCategory.h"

@interface ZJNavigationController ()

@end

@implementation ZJNavigationController

@synthesize navigationBarShadowColor = _navigationBarShadowColor;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationBarTranslucent = NO;
    self.hiddenBottomBarWhenPushed = YES;
    self.hiddenBackBarButtonItemTitle = YES;
    self.needChangeExtendedLayout = YES;
    self.navigationBar.shadowImage = [UIImage new];

    self.delegate = self;
}

- (void)setNavigationBarBgColor:(UIColor *)navigationBarBgColor {
    _navigationBarBgColor = navigationBarBgColor;
    
    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:_navigationBarBgColor] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
}

- (void)setNavigationBarTranslucent:(BOOL)navigationBarTranslucent {
    _navigationBarTranslucent = navigationBarTranslucent;
    
    self.navigationBar.translucent = _navigationBarTranslucent;
}

- (void)setNavigationBarShadowColor:(UIColor *)navigationBarShadowColor {
    _navigationBarShadowColor = navigationBarShadowColor;
    
    self.navigationBar.shadowImage = [UIImage imageWithColor:_navigationBarShadowColor];     // 分割线颜色
}

- (void)setNavigationBarTintColor:(UIColor *)navigationBarTintColor {
    _navigationBarTintColor = navigationBarTintColor;
    self.navigationBar.tintColor = _navigationBarTintColor;    // 对返回按钮颜色起作用
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:_navigationBarTintColor}];
}

- (void)setNavigationBarBgImage:(UIImage *)navigationBarBgImage {
    _navigationBarBgImage = navigationBarBgImage;
    
    [self.navigationBar setBackgroundImage:_navigationBarBgImage forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
}

- (void)setNavigationBarTitleColor:(UIColor *)navigationBarTitleColor {
    _navigationBarTitleColor = navigationBarTitleColor;
    
    UIView *contentView = (UIView *)[self.navigationBar fetchSubViewWithClassName:@"_UINavigationBarContentView"];
    if (contentView) {
        UILabel *label = (UILabel *)[contentView fetchSubViewWithClassName:@"UILabel"];
        if (label) {
            label.textColor = _navigationBarTitleColor;
        }
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.hiddenBottomBarWhenPushed) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

/**
 *  此方法会在viewDidLoad之后调用
 */
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.needChangeExtendedLayout) {
        if([viewController respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
            viewController.edgesForExtendedLayout = UIRectEdgeNone;
        }
    }

    if (!self.hiddenBackBarButtonItemTitle) return;
    
    NSArray *viewControllerArray = self.viewControllers;
    
    long previousViewControllerIndex = [viewControllerArray indexOfObject:viewController] - 1;
    UIViewController *previous;
    
    if (previousViewControllerIndex >= 0) {
        previous = [viewControllerArray objectAtIndex:previousViewControllerIndex];
        previous.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]
                                                     initWithTitle:@""
                                                     style:UIBarButtonItemStylePlain
                                                     target:self
                                                     action:nil];
    }
}

#pragma mark - getter

- (UIColor *)navigationBarShadowColor {
    if (!_navigationBarShadowColor) {
        _navigationBarShadowColor = [UIColor groupTableViewBackgroundColor];
    }
    
    return _navigationBarShadowColor;
}

@end
