//
//  ZJIconTitleCollectionViewCell.h
//  TestCategory
//
//  Created by ZJ on 03/07/2017.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJIconTitleCollectionViewCell : UICollectionViewCell

@property (nonatomic, copy) NSString *iconPath;

@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *contentBgColor;

@property (nonatomic, copy) NSString *iconPlaceholder;

@property (nonatomic, strong) UIFont *font;
@property (nonatomic, assign) NSTextAlignment textAlignment;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, assign) CGFloat iconWidth;
@property (nonatomic, assign) BOOL needCorner;

@end
