//
//  HYIconTitleCollectionTableViewCell.h
//  PEPlatform
//
//  Created by ZJ on 12/14/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HYIconTitleCollectionTableViewCell;

@protocol HYIconTitleCollectionTableViewCellDelegate <NSObject>

- (void)iconTitleCollectionTableViewCell:(HYIconTitleCollectionTableViewCell *)cell didSelectAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface HYIconTitleCollectionTableViewCell : UITableViewCell

@property (nonatomic, strong) NSArray<NSString *> *titles;
@property (nonatomic, strong) NSArray<NSString *> *iconPaths;
@property (nonatomic, assign) BOOL scrollEnabled;

@property (nonatomic, weak) id<HYIconTitleCollectionTableViewCellDelegate> delegate;

@end
