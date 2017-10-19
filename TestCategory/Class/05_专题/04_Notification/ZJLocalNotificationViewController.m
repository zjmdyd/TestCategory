//
//  ZJLocalNotificationViewController.m
//  LocalNotification
//
//  Created by YunTu on 15/1/31.
//  Copyright (c) 2015年 YunTu. All rights reserved.
//

#import "ZJLocalNotificationViewController.h"

@interface ZJLocalNotificationViewController ()

@end

@implementation ZJLocalNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self performSelector:@selector(noti) withObject:nil afterDelay:3.0];
}

- (void)noti {
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:3];
    UILocalNotification *noti = [[UILocalNotification alloc] init];
    noti.fireDate = date;
    noti.repeatInterval = NSCalendarUnitMinute; // 每分钟推送
    noti.alertBody = @"本地推送";
    
    //显示在icon上的红色圈中的数子
    
    noti.applicationIconBadgeNumber = 1;
    
    //设置userinfo 方便在之后需要撤销的时候使用
    
    NSDictionary *infoDic = [NSDictionary dictionaryWithObject:@"name" forKey:@"key"];
    
    noti.userInfo = infoDic;
    //推送声音
    noti.soundName = UILocalNotificationDefaultSoundName;
    //添加推送到uiapplication
    
    UIApplication *app = [UIApplication sharedApplication];
    
    [app scheduleLocalNotification:noti];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
