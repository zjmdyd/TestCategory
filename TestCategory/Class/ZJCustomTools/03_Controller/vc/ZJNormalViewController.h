//
//  ZJNormalViewController.h
//  WeiMing
//
//  Created by ZJ on 13/04/2018.
//  Copyright © 2018 HY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJNormalViewController : UIViewController

@property (nonatomic, assign) BOOL needRefresh;
@property (nonatomic, strong) NSArray *placeholds, *icons, *values, *titles, *vcNames, *cellTitles, *sectionTitles, *nibs, *units;
@property (nonatomic, strong) NSMutableArray *mutablePlaceholds, *mutableIcons, *mutableValues, *mutableTitles, *mutableVCNames, *mutableCellTitles, *mutableSectionTitles, *mutableNibs, *mutableUnits;

- (void)notiRefreshEvent:(NSNotification *)noti;   // 通知
- (void)setTranslucent:(BOOL)translucent;

@end
