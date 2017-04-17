//
//  ZJQRCodeViewController.h
//  Care
//
//  Created by ZJ on 9/6/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ZJQRCodeCompleteHandler)(id scanVC, NSString *result);

@interface ZJQRCodeViewController : UIViewController

- (void)scanSuccessHandler:(ZJQRCodeCompleteHandler)scanSuccessHandler;

@end
