//
//  ZJTitleTextFieldTableViewCell.h
//  SportWatch
//
//  Created by ZJ on 3/14/17.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZJTitleTextFieldTableViewCell;

@protocol ZJTitleTextFieldTableViewCellDelegate <NSObject>

- (void)titleTextFieldTableViewCell:(ZJTitleTextFieldTableViewCell *)cell didEndEditWithText:(NSString *)text;

@end

@interface ZJTitleTextFieldTableViewCell : UITableViewCell

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *placehold;
@property (nonatomic, copy) NSString *value;
@property (nonatomic, assign) NSTextAlignment textAlignment;
@property (nonatomic, assign) UIKeyboardType keyboardType;
@property (nonatomic, strong) UIColor *textColor;


@property (nonatomic, weak) id<ZJTitleTextFieldTableViewCellDelegate> delegate;

@end
