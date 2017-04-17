//
//  HYSubTitleTableViewCell.h
//  PEPlatform
//
//  Created by ZJ on 11/4/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJIconSubTitleObject.h"

@class HYSubTitleTableViewCell;

@protocol HYSubTitleTableViewCellDelegate <NSObject>

- (void)subTitleTableViewCell:(HYSubTitleTableViewCell *)cell didSelectDetailViewAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface HYSubTitleTableViewCell : UITableViewCell

@property (nonatomic, strong) ZJIconSubTitleObject *iconSubTitlesObj;

/**
 *  头像是否需要圆角
 */
@property (nonatomic, assign) BOOL needCornerRadius;
@property (nonatomic, assign) BOOL hiddenDetailView;

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, weak) id<HYSubTitleTableViewCellDelegate> delegate;

@end
