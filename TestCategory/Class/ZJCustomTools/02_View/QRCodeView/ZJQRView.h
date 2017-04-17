//
//  ZJQRView.h
//  Care
//
//  Created by ZJ on 9/6/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZJQRView;

@protocol QRViewDelegate <NSObject>
/**
 *  代理回调扫描结果
 *
 *  @param view   扫一扫视图
 *  @param result 扫描结果
 */
- (void)qrView:(ZJQRView *)view ScanResult:(NSString *)result;

@end

@interface ZJQRView : UIView

@property(nonatomic,assign)id <QRViewDelegate> delegate;

@property(nonatomic, assign, readonly) CGRect scanViewFrame;

- (void)startScan;
- (void)stopScan;

@end
