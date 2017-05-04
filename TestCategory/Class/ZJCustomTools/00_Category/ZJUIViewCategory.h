//
//  ZJUIViewCategory.h
//  ZJCustomTools
//
//  Created by ZJ on 6/13/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef kScreenW

#define kScreenW    ([UIScreen mainScreen].bounds.size.width)
#define kScreenH    ([UIScreen mainScreen].bounds.size.height)

#endif

#ifndef DefaultMargin

#define DefaultMargin 8     // 默认边距

#endif

#define UIColorFromHex(s)  [UIColor colorWithRed:(((s&0xFF0000) >> 16))/255.0 green:(((s&0x00FF00) >> 8))/255.0 blue:(s&0x0000FF)/255.0 alpha:1.0]
#define UIColorFromHexAlpha(s, a)  [UIColor colorWithRed:(((s&0xFF0000) >> 16))/255.0 green:(((s&0x00FF00) >> 8))/255.0 blue:(s&0x0000FF)/255.0 alpha:a]

@interface ZJUIViewCategory : NSObject

@end


#pragma mark - UIBarButtonItem

@interface UIBarButtonItem (ZJBarButtonItem)

/**
 *  根据自定义view创建一个UIBarButtonItem
 *
 */
+ (UIBarButtonItem *)barbuttonWithCustomView:(UIView *)view;

@end


#pragma mark - UIColor

@interface UIColor (ZJColor)

+ (UIColor *)sysTableViewDetailTextColor;

/**
 *  半透明遮罩层
 */
+ (UIColor *)maskViewColor;

/**
 *  粉红色
 */
+ (UIColor *)pinkColor;

@end


#pragma mark - UIImage

@interface UIImage (ZJImage)

/**
 *  根据颜色获取UIImage
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 *  根据颜色获取UIImage
 *  @param frame  特定区域着色
 */
+ (UIImage *)imageWithColor:(UIColor *)color frame:(CGRect)frame;

#pragma mark - 生成二维码

+ (UIImage *)qrImageByContent:(NSString *)content;

//pre
+ (UIImage *)qrImageWithContent:(NSString *)content size:(CGFloat)size;

/**
 *   色值 0~255
 */
+ (UIImage *)qrImageWithContent:(NSString *)content size:(CGFloat)size red:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue;

+ (UIImage *)qrImageWithContent:(NSString *)content logo:(UIImage *)logo size:(CGFloat)size red:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue;

@end


#pragma mark - UIImageView

/**
 *  二维码
 */
@interface UIImageView (ZJImageView)

- (void)setupQRCodeWithContent:(NSString *)content;

@end

#pragma mark - UILabel

@interface UILabel (ZJLabel)

/**
 *  根据文本内容适配Label高度
 */
- (CGSize)fitSizeWithWidth:(CGFloat)width;

+ (CGSize)fitSizeWithWidth:(CGFloat)width text:(NSString *)text;
+ (CGSize)fitSizeWithWidth:(CGFloat)width text:(NSString *)text font:(UIFont *)font;
+ (CGSize)fitSizeWithMargin:(CGFloat)margin text:(NSString *)text font:(UIFont *)font;

/**
 *  获取适合的font
 *
 *  @param pSize  初始fontSize
 *  @param width  label的宽度
 *  @param height label的高度, label的最大可容纳高度
 *  @param descend font是否是递减
 */
- (void)fitFontWithPointSize:(CGFloat)pSize width:(CGFloat)width height:(CGFloat)height descend:(BOOL)descend;


/**
 斜体
 */
- (void)italicFont;

@end


#pragma mark - UICollectionView

@interface UICollectionView (ZJCollectionView)

- (void)registerCellWithSysIDs:(NSArray *)sysIDs;
- (void)registerCellWithNibIDs:(NSArray *)nibIDs;
- (void)registerCellWithNibIDs:(NSArray *)nibIDs sysIDs:(NSArray *)sysIDs;

@end

#pragma mark - UITableView

static NSString *const SystemTableViewCell = @"UITableViewCell";

@interface UITableView (ZJTableView)

- (void)registerCellWithSysIDs:(NSArray *)sysIDs;
- (void)registerCellWithNibIDs:(NSArray *)nibIDs;
- (void)registerCellWithNibIDs:(NSArray *)nibIDs sysIDs:(NSArray *)sysIDs;

/**
 *  设置cell的分割线是否需要边距，在VC的viewDidLayoutSubviews方法中调用
 */
- (void)setNeedSeparatorMargin:(BOOL)needMargin;

/**
 *  设置cell的content是否需要边距
 */
- (void)setNeedLayoutMargin:(BOOL)needMargin;


- (UISwitch *)accessorySwitchWithTarget:(id)target;

@end


#pragma mark - UIView

@interface UIView (ZJUIView)

/**
 *  添加tap手势
 *
 *  @param delegate 当不需要delegate时可设为nil
 */

- (void)addTapGestureWithDelegate:(id <UIGestureRecognizerDelegate>)delegate target:(id)target;

+ (UIView *)maskViewWithFrame:(CGRect)frame;
- (UIView *)subViewWithTag:(NSInteger)tag;

#pragma mark - supplementView

/**
 普通文本
 @return 文本背景色
 */
+ (UIView *)supplementViewWithText:(NSString *)text;
+ (UIView *)supplementViewWithText:(NSString *)text supplementViewBgColor:(UIColor *)color;

/**
 带属性文本
 @return 文本背景色
 */
+ (UIView *)supplementViewWithAttributeText:(NSAttributedString *)text;
+ (UIView *)supplementViewWithAttributeText:(NSAttributedString *)text supplementViewBgColor:(UIColor *)color;

#pragma mark - iconBadge

- (void)addIconBadgeWithText:(NSString *)text;
- (void)addIconBadgeWithText:(NSString *)text bgColor:(UIColor *)color;

- (void)addIconBadgeWithAttributeText:(NSAttributedString *)text;
- (void)addIconBadgeWithAttributeText:(NSAttributedString *)text bgColor:(UIColor *)color;

@end


#pragma mark - UIGestureRecognizer

typedef NS_ENUM(NSInteger, Direction) {
    DirectionOfNoMove,
    DirectionOfUp,
    DirectionOfDown,
    DirectionOfLeft,
    DirectionOfRight,
};

@interface UIGestureRecognizer (ZJGestureRecognizer)

+ (Direction)direction:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

@end

