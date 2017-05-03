//
//  ZJControllerCategory.m
//  ButlerSugar
//
//  Created by ZJ on 3/4/16.
//  Copyright © 2016 csj. All rights reserved.
//

#import "ZJControllerCategory.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation ZJControllerCategory

@end

@implementation UINavigationController (ZJNavigationController)

- (void)pushViewControllerFromBottom:(UIViewController *)viewController {
    CATransition* transition = [CATransition animation];
    transition.duration = 0.35;
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromTop;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [self.view.layer addAnimation:transition forKey:kCATransition];
    [self pushViewController:viewController animated:NO];
}

- (void)popViewControllerFromDirection:(TransitionDerection)direction {
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionReveal;
    NSArray *types = @[kCATransitionFromRight, kCATransitionFromLeft, kCATransitionFromTop, kCATransitionFromBottom];
    transition.subtype = types[direction];
    transition.duration = 0.35;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.view.layer addAnimation:transition forKey:kCATransition];
    [self popViewControllerAnimated:NO];
}

@end

#ifndef DefaultMargin

#define DefaultMargin 8     // 默认边距

#endif

#ifndef DefaultDuration

#define DefaultDuration 0.5

#endif

#define  barItemAction @"barItemAction:"

@implementation UIViewController (ZJViewController)

- (UIViewController *)createVCWithName:(NSString *)name {
    return [self createVCWithName:name title:nil];
}

- (UIViewController *)createVCWithName:(NSString *)name isGroupTableVC:(BOOL)isGroup {
    return [self createVCWithName:name title:nil];
}

- (UIViewController *)createVCWithName:(NSString *)name title:(NSString *)title {
    return [self createVCWithName:name title:title isGroupTableVC:NO];
}

- (UIViewController *)createVCWithName:(NSString *)name title:(NSString *)title isGroupTableVC:(BOOL)isGroup {
    UIViewController *vc = [NSClassFromString(name) alloc];
    if ([vc isKindOfClass:[UITableViewController class]]) {
        vc = [((UITableViewController *)vc) initWithStyle:isGroup ? UITableViewStyleGrouped : UITableViewStylePlain];
    }else {
        vc = [vc init];
        vc.view.backgroundColor = [UIColor whiteColor];
    }
    
    if ([vc isKindOfClass:[UIViewController class]]) {
        vc.title = title;
    }
    
    return vc;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - UIBarButtonItem

- (UIBarButtonItem *)barbuttonWithTitle:(NSString *)type {
    SEL s = NSSelectorFromString(barItemAction);
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:type style:UIBarButtonItemStylePlain target:self action:s];
    
    return item;
}

- (UIBarButtonItem *)barButtonWithImageName:(NSString *)imgName {
    SEL s = NSSelectorFromString(barItemAction);
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:imgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:s];
    
    return item;
}

- (UIBarButtonItem *)barbuttonWithSystemType:(UIBarButtonSystemItem)type {
    SEL s = NSSelectorFromString(barItemAction);
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:type target:self action:s];
    
    return item;
}

- (NSArray *)barButtonWithImageNames:(NSArray *)imgNames {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < imgNames.count; i++) {
        UIBarButtonItem *item = [self barButtonWithImageName:imgNames[i]];
        item.tag = i;
        
        [array addObject:item];
    }
    
    return [array copy];
}

- (UIBarButtonItem *)barButtonItemWithCustomViewWithImageNames:(NSArray *)images {
    SEL s = NSSelectorFromString(barItemAction);
    
    CGFloat width = 30;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width*images.count+DefaultMargin, width)];
    NSInteger count = images.count;
    if (count > 2) count = 2;
    for (int i = 0; i < count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.tag = i;
        btn.frame = CGRectMake(i*(view.frame.size.width-width), 0, width, width);
        [btn setImage:[[UIImage imageNamed:images[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [btn addTarget:self action:s forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
    }
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:view];
    
    return item;
}

#pragma mark - MentionView

#define MentionViewTag 9999
#define kSuperView self.view

- (void)showMentionViewWithImgName:(NSString *)name text:(NSString *)text animated:(BOOL)animated {
    [self showMentionViewWithImgName:name text:text animated:animated superView:nil];
}

- (void)showMentionViewWithImgName:(NSString *)name text:(NSString *)text animated:(BOOL)animated superView:(UIView *)superView {
    if (!superView) superView = kSuperView;
    
    if (![superView viewWithTag:MentionViewTag]) {
        [self createMentionViewWithSuperView:superView];
    }
    
    [self showWithSuperView:superView imgName:name text:text animated:animated];
}

- (void)hiddenMentionView:(BOOL)hidden animated:(BOOL)animated {
    [self hiddenMentionView:hidden animated:animated superView:nil];
}

- (void)hiddenMentionView:(BOOL)hidden animated:(BOOL)animated superView:(UIView *)superView {
    if (!superView) superView = kSuperView;
    UIView *view = [superView viewWithTag:MentionViewTag];
    if (view) {
        [self hiddenView:view hidden:hidden animated:animated];
    }
}

- (UIView *)mentionViewWithImgName:(NSString *)name text:(NSString *)text frame:(CGRect)frame {
    UIView *view = [[UIView alloc] initWithFrame:frame];
    
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    iv.center = CGPointMake(view.center.x, view.frame.size.height/2);
    iv.contentMode = UIViewContentModeScaleAspectFit;
    iv.image = [UIImage imageNamed:name];
    [view addSubview:iv];
    
    CGFloat bottom = iv.frame.origin.y + iv.frame.size.height;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, bottom+DefaultMargin, view.frame.size.width, 21)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor lightGrayColor];
    label.text = text;
    [view addSubview:label];
    
    return view;
}

/**
 *  private method
 */
- (void)createMentionViewWithSuperView:(UIView *)superView {
    UIView *view = [self mentionViewWithImgName:nil text:nil frame:superView.bounds];
    view.tag = MentionViewTag;
    view.alpha = 0.0;
    view.hidden = YES;
    view.backgroundColor = [UIColor whiteColor];
    [superView addSubview:view];
}

- (void)showWithSuperView:(UIView *)superView imgName:(NSString *)name text:(NSString *)text animated:(BOOL)animated {
    UIView *view = [superView viewWithTag:MentionViewTag];
    
    for (UIView *v in view.subviews) {
        if ([v isMemberOfClass:[UIImageView class]]) {
            ((UIImageView *)v).image = [UIImage imageNamed:name];
            
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            BOOL b1 = self.edgesForExtendedLayout == UIRectEdgeAll || self.edgesForExtendedLayout == UIRectEdgeTop;
            BOOL b2 = [window isEqual:superView];
            if (!b1 && !b2) {
                v.center = CGPointMake(v.center.x, v.center.y-64);
            }
        }
        if ([v isMemberOfClass:[UILabel class]]) {
            ((UILabel *)v).text = text;
        }
    }
    if (view) {
        [self hiddenView:view hidden:NO animated:animated];
    }
}

- (void)hiddenView:(UIView *)view hidden:(BOOL)hidden animated:(BOOL)animated {
    if (hidden) {
        if (view.isHidden == NO) {
            if (animated) {
                [UIView animateWithDuration:DefaultDuration animations:^{
                    view.alpha = 0.0;
                } completion:^(BOOL finished) {
                    view.hidden = hidden;
                }];
            }else {
                view.alpha = 0.0;
                view.hidden = hidden;
            }
        }
    }else {
        if (view.isHidden) {
            view.hidden = hidden;
            if (animated) {
                [UIView animateWithDuration:DefaultDuration animations:^{
                    view.alpha = 1.0;
                }];
            }else {
                view.alpha = 1.0;
            }
        }
    }
}


#pragma mark - NSNotificationCenter

- (void)removeNotificationObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
