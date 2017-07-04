//
//  ZJSelectSexTableViewCell.h
//  ButlerSugar
//
//  Created by ZJ on 2/26/16.
//  Copyright © 2016 csj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZJSelectSexTableViewCell;

@protocol HYSelectSexDelegate <NSObject>

- (void)ZJSelectSexTableViewCell:(ZJSelectSexTableViewCell *)cell didClickButtonAtIndex:(NSInteger)buttonIndex;

@end

@interface ZJSelectSexTableViewCell : UITableViewCell

@property (nonatomic, strong) NSArray *selectImgNames;
@property (nonatomic, strong) NSArray *unselectImgNames;
@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, weak) id <HYSelectSexDelegate>delegate;
@property (nonatomic, assign) NSInteger selectIndex;

@end
