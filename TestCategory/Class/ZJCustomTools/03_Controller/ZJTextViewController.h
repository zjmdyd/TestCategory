//
//  ZJTextViewController.h
//  TestCategory
//
//  Created by ZJ on 5/4/17.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZJTextViewController;

@protocol ZJTextViewControllerDelegate <NSObject>

- (void)textViewController:(ZJTextViewController *)viewController didEndEditText:(NSString *)text;

@end

@interface ZJTextViewController : UIViewController

- (instancetype)initWithText:(NSString *)text;

@property (nonatomic, copy) NSString *text;
@property (nonatomic, weak) id <ZJTextViewControllerDelegate> delegate;

@end
