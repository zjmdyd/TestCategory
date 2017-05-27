//
//  ZJSwipeTableViewCell.h
//  TodayTodo
//
//  Created by ZJ on 6/22/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJSwipeTableViewCell : UITableViewCell

@property (nonatomic, copy) NSString *content;
@property (nonatomic, getter=isHiddenDeleteBtn) BOOL hiddenDeleteBtn;

@end
