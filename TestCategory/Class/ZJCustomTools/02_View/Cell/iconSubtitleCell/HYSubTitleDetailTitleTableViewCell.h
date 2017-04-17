//
//  HYSubTitleDetailTitleTableViewCell.h
//  XAHealthDoctor
//
//  Created by ZJ on 1/4/17.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJIconSubTitleObject.h"

@interface HYSubTitleDetailTitleTableViewCell : UITableViewCell

@property (nonatomic, strong) ZJIconSubTitleObject *iconSubTitlesObj;

/**
 *  头像是否需要圆角
 */
@property (nonatomic, assign) BOOL needCornerRadius;
@property (nonatomic, assign) BOOL hiddenDetailView;

@property (nonatomic, strong) NSIndexPath *indexPath;

@end
