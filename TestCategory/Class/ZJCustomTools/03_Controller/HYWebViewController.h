//
//  HYWebViewController.h
//  DiabetesGuard
//
//  Created by ZJ on 7/20/16.
//  Copyright © 2016 YCLZONE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYWebViewController : UIViewController

/**
 *  @param webName name or url
 */
- (instancetype)initWithWebName:(NSString *)webName title:(NSString *)title;

/**
 分享url
 */
@property (nonatomic, copy) NSString *shareUrl;
@property (nonatomic, copy) NSString *shareTitle;

@end
