//
//  ZJTableViewController.h
//  BaoChengTong
//
//  Created by ZJ on 11/10/2017.
//  Copyright © 2017 csj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, RefreshEventType) {
    RefreshEventTypeOfHeader,
    RefreshEventTypeOfFooter,
};

@interface ZJTableViewController : UITableViewController

@property (nonatomic, assign) BOOL needRefresh;
@property (nonatomic, assign) BOOL needMJHeaderRefresh; // 是否需要下拉刷新
@property (nonatomic, assign) BOOL needMJFooterRefresh; // 是否需要上拉加载更多

@property (nonatomic, strong) NSArray *placeholds, *icons, *values, *titles, *vcNames, *cellTitles;
@property (nonatomic, strong) NSMutableArray *mutableIcons, *mutableVCNames, *mutableCellTitles, *mutableValues;
@property (nonatomic, copy) NSString *emptyMessage;
@property (nonatomic, copy) NSString *emptyImageName;

- (void)mjRefreshEventWithType:(RefreshEventType)type;
- (void)endMJRefresh;

@end
