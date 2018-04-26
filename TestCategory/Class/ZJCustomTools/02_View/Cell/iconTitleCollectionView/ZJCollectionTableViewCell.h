//
//  ZJCollectionTableViewCell.h
//  PEPlatform
//
//  Created by ZJ on 12/14/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZJCollectionTableViewCell;

@protocol ZJCollectionTableViewCellDataSource <NSObject>

@required
- (NSInteger)collectionTableViewCell:(ZJCollectionTableViewCell *)cell numberOfItemsInSection:(NSInteger)section;

@optional
- (NSInteger)numberOfSectionsInCollectionTableViewCell:(ZJCollectionTableViewCell *)cell;

- (NSString *)collectionTableViewCell:(ZJCollectionTableViewCell *)cell iconPathAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)collectionTableViewCell:(ZJCollectionTableViewCell *)cell titleAtIndexPath:(NSIndexPath *)indexPath;
- (UIColor *)collectionTableViewCell:(ZJCollectionTableViewCell *)cell titleColorAtIndexPath:(NSIndexPath *)indexPath;
- (UIColor *)collectionTableViewCell:(ZJCollectionTableViewCell *)cell backgroundColorAtIndexPath:(NSIndexPath *)indexPath;

// edit
- (BOOL)collectionTableViewCell:(ZJCollectionTableViewCell *)cell canEditAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol ZJCollectionTableViewCellDelegate <NSObject>

@optional

- (void)collectionTableViewCell:(ZJCollectionTableViewCell *)cell didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

// edit
- (void)collectionTableViewCell:(ZJCollectionTableViewCell *)cell didEndEditWithText:(NSString *)text indexPath:(NSIndexPath *)indexPath;

@end

typedef NS_ENUM(NSInteger, ZJCollectionCellType) {
    ZJCollectionCellTypeOfNormalIconTitle,
    ZJCollectionCellTypeOfIconTitleVertical,
    ZJCollectionCellTypeOfIconTitleHorizontal
};

@interface ZJCollectionTableViewCell : UITableViewCell

@property (nonatomic, strong) NSArray<NSString *> *titles;
@property (nonatomic, strong) NSArray<NSString *> *iconPaths;
@property (nonatomic, assign) ZJCollectionCellType cellType;
@property (nonatomic, weak) id <ZJCollectionTableViewCellDataSource> dataSource;
@property (nonatomic, weak) id <ZJCollectionTableViewCellDelegate> delegate;

@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) CGFloat minimumLineSpacing;       // 默认为10
@property (nonatomic, assign) CGFloat minimumInteritemSpacing;  // 默认为10
@property (nonatomic, assign) UIEdgeInsets sectionInset;
@property (nonatomic, assign) CGFloat margin;
@property (nonatomic, assign) UICollectionViewScrollDirection scrollDirection;

@property (nonatomic, assign) BOOL scrollEnabled;
@property (nonatomic, assign) BOOL selectEnabled;

@property (nonatomic, strong) UIColor *contentBgColor;
@property (nonatomic, copy) NSString *iconPlaceholder;
@property (nonatomic, copy) NSString *textPlaceholder;
@property (nonatomic, assign) NSTextAlignment textAlignment;

- (void)reload;

@end
