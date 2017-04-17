//
//  HYSelectSexTableViewCell.h
//  ButlerSugar
//
//  Created by ZJ on 2/26/16.
//  Copyright © 2016 csj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HYSelectSexTableViewCell;

@protocol HYSelectSexDelegate <NSObject>

- (void)hySelectSexTableViewCell:(HYSelectSexTableViewCell *)cell didClickButtonAtIndex:(NSInteger)buttonIndex;

@end

@interface HYSelectSexTableViewCell : UITableViewCell

@property (nonatomic, strong) NSArray *selectImgNames;
@property (nonatomic, strong) NSArray *unselectImgNames;
@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, weak) id <HYSelectSexDelegate>delegate;
@property (nonatomic, assign) NSInteger selectIndex;

@end
