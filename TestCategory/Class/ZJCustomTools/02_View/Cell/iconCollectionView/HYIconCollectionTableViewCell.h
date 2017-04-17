//
//  HYIconCollectionTableViewCell.h
//  PEPlatform
//
//  Created by ZJ on 12/14/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HYIconCollectionTableViewCell;

@protocol HYIconCollectionTableViewCellDelegate <NSObject>

- (void)iconCollectionTableViewCell:(HYIconCollectionTableViewCell *)cell didSelectAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface HYIconCollectionTableViewCell : UITableViewCell

@property (nonatomic, copy) NSString *topTitle;
@property (nonatomic, strong) NSArray<NSString *> *titles;
@property (nonatomic, strong) NSArray<NSString *> *iconPaths;

/**
 默认为YES
 */
@property (nonatomic, assign) BOOL scrollEnabled;

@property (nonatomic, weak) id<HYIconCollectionTableViewCellDelegate> delegate;

@end
