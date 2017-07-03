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

#define SeparateHeight 16

#define DefaultCellHeight 44

#import "HYErrorView.h"
#import "ZJFooterView.h"
#import "ZJPicker.h"
#import "ZJProgressView.h"
#import "ZJQRCodeView.h"
#import "ZJRoundImageView.h"
#import "ZJSearchingView.h"
#import "ZJScrollView.h"
#import "ZJSelectButton.h"
#import "ZJStarLevelView.h"


///* TableViewCell */
#import "HYImageTextFieldTableViewCell.h"
#import "HYSelectSexTableViewCell.h"
#import "HYTitleTextFieldTableViewCell.h"
#import "HYCollectionTableViewCell.h"

static NSString *const CollectionTableViewCell = @"HYCollectionTableViewCell";
static NSString *const ImageTextFieldTabViewCell = @"HYImageTextFieldTableViewCell";
static NSString *const SelectSexTableViewCell = @"HYSelectSexTableViewCell";
static NSString *const TitleTextFieldTableViewCell = @"HYTitleTextFieldTableViewCell";


///* CollectionViewCell */
#import "HYIconTitleCollectionViewCell.h"
#import "HYIconTitleHorizontalCollectionViewCell.h"
#import "HYIconTitleVerticalCollectionViewCell.h"

static NSString *const IconTitleCollectionViewCell = @"HYIconTitleCollectionViewCell";
static NSString *const IconTitleVerticalCollectionCell = @"HYIconTitleVerticalCollectionViewCell";
static NSString *const IconTitleHorizontalCollectionCell = @"HYIconTitleHorizontalCollectionViewCell";

