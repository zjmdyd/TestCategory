//
//  HYCollectionTableViewCell.h
//  PEPlatform
//
//  Created by ZJ on 12/14/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HYCollectionTableViewCell;

@protocol HYCollectionTableViewCellDelegate <NSObject>

- (void)collectionTableViewCell:(HYCollectionTableViewCell *)cell didSelectAtIndexPath:(NSIndexPath *)indexPath;

@end

typedef NS_ENUM(NSInteger, ZJCollectionCellType) {
    ZJCollectionCellTypeOfIconTitle,
    ZJCollectionCellTypeOfIconTitleVertical,
    ZJCollectionCellTypeOfIconTitleHorizontal
};

@interface HYCollectionTableViewCell : UITableViewCell

@property (nonatomic, strong) NSArray<NSString *> *titles;
@property (nonatomic, strong) NSArray<NSString *> *iconPaths;
@property (nonatomic, assign) ZJCollectionCellType cellType;
@property (nonatomic, weak) id<HYCollectionTableViewCellDelegate> delegate;
@property (nonatomic, assign) BOOL scrollEnabled;
@property (nonatomic, assign) NSInteger numberItemOfColum;
@property (nonatomic, assign) CGSize itemSize;

@end
