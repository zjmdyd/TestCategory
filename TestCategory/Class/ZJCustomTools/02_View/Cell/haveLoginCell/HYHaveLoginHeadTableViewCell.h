//
//  HYHaveLoginHeadTableViewCell.h
//  ButlerSugar
//
//  Created by ZJ on 2/25/16.
//  Copyright © 2016 csj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYHaveLoginHeadTableViewCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *infoDic;
/**
 *  头像是否需要圆角
 */
@property (nonatomic, assign) BOOL needCornerRadius;

@end
