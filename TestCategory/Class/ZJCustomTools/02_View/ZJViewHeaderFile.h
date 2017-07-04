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
#import "ZJCollectionTableViewCell.h"
#import "ZJImageTextFieldTableViewCell.h"
#import "ZJSelectSexTableViewCell.h"
#import "ZJTitleTextFieldTableViewCell.h"

static NSString *const CollectionTableViewCell = @"ZJCollectionTableViewCell";
static NSString *const ImageTextFieldTabViewCell = @"ZJImageTextFieldTableViewCell";
static NSString *const SelectSexTableViewCell = @"ZJSelectSexTableViewCell";
static NSString *const TitleTextFieldTableViewCell = @"ZJTitleTextFieldTableViewCell";


///* CollectionViewCell */
#import "ZJIconTitleNormalCollectionViewCell.h"
#import "ZJIconTitleHorizontalCollectionViewCell.h"
#import "ZJIconTitleVerticalCollectionViewCell.h"

static NSString *const IconTitleCollectionViewCell = @"ZJIconTitleNormalCollectionViewCell";
static NSString *const IconTitleVerticalCollectionCell = @"ZJIconTitleVerticalCollectionViewCell";
static NSString *const IconTitleHorizontalCollectionCell = @"ZJIconTitleHorizontalCollectionViewCell";

