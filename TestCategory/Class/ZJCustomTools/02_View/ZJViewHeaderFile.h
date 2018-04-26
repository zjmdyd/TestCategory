//
//  ZJViewHeaderFile.h
//  ZJCustomTools
//
//  Created by ZJ on 6/13/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#ifndef ZJViewHeaderFile_h
#define ZJViewHeaderFile_h


#endif /* ZJViewHeaderFile_h */

#define Window [UIApplication sharedApplication].window
#define KeyWindow [UIApplication sharedApplication].keyWindow

#define kIsAboveI5 (kScreenW > 320)     // 是否是iPhone5以上的手机
#define kIsIplus (kScreenW > 375)       // 是否是plus系列
#define kIsAboveiOS11 [UIDevice currentDevice].systemVersion.integerValue >= 11
#define IS_iPhoneX ([UIScreen mainScreen].bounds.size.width == 375 && [UIScreen mainScreen].bounds.size.height == 812)

#define SeparateHeight 16

#define DefaultCellHeight 44

#ifndef kScreenW

#define kScreenW    ([UIScreen mainScreen].bounds.size.width)
#define kScreenH    ([UIScreen mainScreen].bounds.size.height)

#endif

#import "ZJFooterView.h"
#import "ZJWrapView.h"
#import "ZJAboutView.h"
#import "ZJPicker.h"
#import "ZJSelectButton.h"
#import "ZJSexView.h"

#import "ZJProgressView.h"
#import "HYErrorView.h"
#import "ZJQRCodeView.h"
#import "ZJRoundImageView.h"
#import "ZJSearchingView.h"
#import "ZJScrollView.h"

#import "ZJStarLevelView.h"

#import "ZJLoginFooterView.h"
#import "ZJRegisterView.h"
#import "ZJDoubleButonView.h"

///* TableViewCell */
#import "ZJInput.h"

#import "ZJSelectSexTableViewCell.h"
#import "ZJIconSubTitleTableViewCell.h"

static NSString *const IconSubTitleTableViewCell = @"ZJIconSubTitleTableViewCell";
static NSString *const SelectSexTableViewCell = @"ZJSelectSexTableViewCell";
static NSString *const SubTitleTableViewCell = @"ZJSubTitleTableViewCell";

///* CollectionViewCell */
#import "ZJIconTitleCollect.h"


