//
//  ZJControllerCategory.h
//  ButlerSugar
//
//  Created by ZJ on 3/4/16.
//  Copyright © 2016 csj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZJControllerCategory : NSObject

@end


#pragma mark - UINavigationController

typedef NS_ENUM(NSInteger, TransitionDerection) {
    TransitionDerectionOfRght,
    TransitionDerectionOfLeft,
    TransitionDerectionOfTop,
    TransitionDerectionOfBottom,
};

@interface UINavigationController (ZJNavigationController)

- (void)pushViewControllerFromBottom:(UIViewController *)viewController;
- (void)popViewControllerFromDirection:(TransitionDerection)direction;

@end


#pragma mark - UIViewController

@interface UIViewController (ZJViewController)

/**
 *  根据控制器名字创建控制器
 */
- (UIViewController *)createVCWithName:(NSString *)name;
- (UIViewController *)createVCWithName:(NSString *)name isGroupTableVC:(BOOL)isGroup;
- (UIViewController *)createVCWithName:(NSString *)name title:(NSString *)title;
- (UIViewController *)createVCWithName:(NSString *)name title:(NSString *)title isGroupTableVC:(BOOL)isGroup;

#pragma mark - UIBarButtonItem

- (UIBarButtonItem *)barbuttonWithTitle:(NSString *)type;
- (UIBarButtonItem *)barButtonWithImageName:(NSString *)imgName;
- (UIBarButtonItem *)barbuttonWithSystemType:(UIBarButtonSystemItem)type;

/**
 *  创建多个UIBarButtonItem(系统默认)此方法效果不好,建议使用barbuttonWithCustomViewWithImageNames:
 */
- (NSArray *)barButtonWithImageNames:(NSArray *)imgNames;

/**
 *  自定义UIBarButtonItem
 *
 *  @param images 数组元素个数最多为2
 */
- (UIBarButtonItem *)barButtonItemWithCustomViewWithImageNames:(NSArray *)images;


#pragma mark - MentionView

/**
 *  在self.view上显示包含一张图片和文字的view
 *
 */
- (void)showMentionViewWithImgName:(NSString *)name text:(NSString *)text animated:(BOOL)animated;

/**
 *  在指定view上显示包含一张图片和文字的view
 */
- (void)showMentionViewWithImgName:(NSString *)name text:(NSString *)text animated:(BOOL)animated superView:(UIView *)superView;

- (void)hiddenMentionView:(BOOL)hidden animated:(BOOL)animated;
- (void)hiddenMentionView:(BOOL)hidden animated:(BOOL)animated superView:(UIView *)superView;

- (UIView *)mentionViewWithImgName:(NSString *)name text:(NSString *)text frame:(CGRect)frame;


#pragma mark - NSNotificationCenter

- (void)removeNotificationObserver;

@end
