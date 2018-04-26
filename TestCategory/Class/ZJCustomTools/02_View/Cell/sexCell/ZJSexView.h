//
//  ZJSexView.h
//  WeiMing
//
//  Created by ZJ on 18/04/2018.
//  Copyright © 2018 HY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJSexView : UIView

@property (nonatomic, getter=isSelect) BOOL select;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIImage *selectImg;
@property (nonatomic, strong) UIImage *unSelectImg;
@property (nonatomic, strong) UIColor *selectTitleColor;
@property (nonatomic, strong) UIColor *unselectTitleColor;
@property (nonatomic, strong) id target;

@end
