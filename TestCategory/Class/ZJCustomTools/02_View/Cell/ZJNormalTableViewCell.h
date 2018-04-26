//
//  ZJNormalTableViewCell.h
//  WeiMing
//
//  Created by ZJ on 12/04/2018.
//  Copyright © 2018 HY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJNormalTableViewCell : UITableViewCell

/**
 cell的分割线的边距,默认为YES
 */
@property (nonatomic, getter=isNeedSeparateLineMargin) BOOL needSeparateLineMargin;

/**
 隐藏分割线的边距,默认为NO
 */
@property (nonatomic, assign) BOOL hiddenSeparateLine;

@property (nonatomic, strong) NSIndexPath *indexPath;
- (void)setIVCornerRadius:(CGFloat)needCornerRadius;

@end
