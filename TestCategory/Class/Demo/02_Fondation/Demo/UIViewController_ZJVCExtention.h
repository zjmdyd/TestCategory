//
//  UIViewController_ZJVCExtention.h
//  TestCategory
//
//  Created by ZJ on 12/05/2017.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController ()

- (void)addExtendMethod;

/**
 *  默认只能添加私有属性，如要添加公开属性，需要实现setter和getter方法
 */
@property (nonatomic, copy) NSString *myCustomProperty;

@end
