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

#define KeyWindow [UIApplication sharedApplication].keyWindow
#define Window [UIApplication sharedApplication].window

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
#import "HYTextImageView.h"
//

///* TableViewCell */
//#import "ZJSystemSubTitleTableViewCell.h"
#import "HYImageTextFieldTableViewCell.h"
#import "HYSubTitleTableViewCell.h"
#import "HYSubTitleRectangleIconTableViewCell.h"
#import "HYSubTitleDetailTitleTableViewCell.h"
#import "HYHaveLoginHeadTableViewCell.h"
#import "HYIconCollectionTableViewCell.h"
#import "HYProfileHeadTableViewCell.h"
#import "HYPureTextTableViewCell.h"
#import "HYSelectSexTableViewCell.h"
#import "HYSexTableViewCell.h"
#import "HYTitleTextFieldTableViewCell.h"

static NSString *const ImageTextFieldTabViewCell = @"HYImageTextFieldTableViewCell";
static NSString *const SubTitleTableViewCell = @"HYSubTitleTableViewCell";
static NSString *const SubTitleRectangleIconTableViewCell = @"HYSubTitleRectangleIconTableViewCell";
static NSString *const SubTitleDetailTitleTableViewCell = @"HYSubTitleDetailTitleTableViewCell";
static NSString *const HaveLoginHeadTableViewCell = @"HYHaveLoginHeadTableViewCell";
static NSString *const ProfileHeadTableViewCell = @"HYProfileHeadTableViewCell";
static NSString *const IconCollectionTableViewCell = @"HYIconCollectionTableViewCell";
static NSString *const PureTextTableViewCell = @"HYPureTextTableViewCell";
static NSString *const SexTableViewCell = @"HYSexTableViewCell";
static NSString *const SelectSexTableViewCell = @"HYSelectSexTableViewCell";
static NSString *const TitleTextFieldTableViewCell = @"HYTitleTextFieldTableViewCell";


///* CollectionViewCell */
#import "HYIconSubTitleHorizontalCollectionViewCell.h"
#import "HYIconTitleHorizontalCollectionViewCell.h"
#import "HYIconTitleVerticalCollectionViewCell.h"

static NSString *const IconSubTitleHorizontalCollectionCell = @"HYIconSubTitleHorizontalCollectionViewCell";
static NSString *const IconTitleHorizontalCollectionCell = @"HYIconTitleHorizontalCollectionViewCell";
static NSString *const IconTitleVerticalCollectionCell = @"HYIconTitleVerticalCollectionViewCell";

