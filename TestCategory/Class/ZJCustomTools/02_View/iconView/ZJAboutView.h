//
//  ZJAboutView.h
//  CanShengHealth
//
//  Created by ZJ on 26/01/2018.
//  Copyright © 2018 HY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZJAboutView;

@protocol ZJAboutViewDelegate <NSObject>

- (void)aboutView:(ZJAboutView *)view didClickButtonAtIndex:(NSInteger)index;

@end

@interface ZJAboutView : UIView

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *placeholdIconPath;
@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, assign) CGFloat widthConst;
@property (nonatomic, assign) CGFloat centerConst;
@property (nonatomic, assign) CGFloat titleTopConst;

@property (nonatomic, weak) id<ZJAboutViewDelegate> delegate;

@end
