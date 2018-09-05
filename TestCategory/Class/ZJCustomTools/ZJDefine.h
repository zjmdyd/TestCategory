//
//  ZJDefine.h
//  TestLocal
//
//  Created by ZJ on 2018/8/10.
//  Copyright © 2018 HY. All rights reserved.
//

#ifndef ZJDefine_h
#define ZJDefine_h

#ifndef kScreenW

#define kScreenW    ([UIScreen mainScreen].bounds.size.width)
#define kScreenH    ([UIScreen mainScreen].bounds.size.height)

#endif

#ifndef DefaultMargin

#define DefaultMargin 8     // 默认边距

#endif

#ifndef SeparateHeight

#define SeparateHeight 16

#endif

#ifndef kStatusBarH

#define kStatusBarH 20

#endif

#ifndef DefaultCellHeight

#define DefaultCellHeight 44

#endif

#ifndef kNaviBarHeight

#define kNaviBarHeight 44

#endif

#ifndef kNaviBottoom

#define kNaviBottoom 64

#endif

#ifndef kTabBarHeight

#define kTabBarHeight 49

#endif

#ifndef DefaultAnimationDuration

#define DefaultAnimationDuration 0.5

#endif

#ifndef DefaultTimeoutInterval

#define DefaultTimeoutInterval 15

#endif

#ifndef ZJNaviCtrl

#define ZJNaviCtrl navigationController

#endif

#ifndef textViewPlacehold

#define textViewPlacehold textViewPlacehold

#endif

#define UIColorFromHex(s)  [UIColor colorWithRed:(((s&0xFF0000) >> 16))/255.0 green:(((s&0x00FF00) >> 8))/255.0 blue:(s&0x0000FF)/255.0 alpha:1.0]
#define UIColorFromHexAlpha(s, a)  [UIColor colorWithRed:(((s&0xFF0000) >> 16))/255.0 green:(((s&0x00FF00) >> 8))/255.0 blue:(s&0x0000FF)/255.0 alpha:a]

#define kRGBA(r, g, b, a)       [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]
#define kRGB16(value, a)         [UIColor colorWithRed:((float)((value & 0xFF0000) >> 16))/255.0 green:((float)((value & 0xFF00) >> 8))/255.0 blue:((float)(value & 0xFF))/255.0 alpha:a]

#define kIsAboveI5 (kScreenW > 320)     // 是否是iPhone5以上的手机
#define kIsIplus (kScreenW > 375)       // 是否是plus系列
#define kIsAboveiOS11 [UIDevice currentDevice].systemVersion.integerValue >= 11
#define IS_iPhoneX ([UIScreen mainScreen].bounds.size.width == 375 && [UIScreen mainScreen].bounds.size.height == 812)

#define Window [UIApplication sharedApplication].window
#define KeyWindow [UIApplication sharedApplication].keyWindow

#define DefaultSectionHeaderHeight 8
#define DefaultSectionFooterHeight 8

#endif /* ZJDefine_h */


