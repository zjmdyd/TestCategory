//
//  ZJNSDateViewController.m
//  ZJFoundation
//
//  Created by YunTu on 15/9/6.
//  Copyright (c) 2015年 YunTu. All rights reserved.
//

#import "ZJNSDateViewController.h"

@interface ZJNSDateViewController ()

@end

@implementation ZJNSDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDate *date = [NSDate date];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSLog(@"zone = %@", zone);
    //[NSTimeZone setDefaultTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    
    NSLog(@"defaultZone = %@", [NSTimeZone defaultTimeZone]);   // defaultZone = Asia/Shanghai (GMT+8) offset 28800
    NSInteger interval = [zone secondsFromGMTForDate: date];    // 28800 = 3600 * 8
    NSLog(@"interval = %zd", interval);
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    
    NSLog(@"local = \n%@\n%@", localeDate, [NSDate date]);
    /*
     2015-01-23 14:10:51 +0000
     2015-01-23 06:10:51 +0000      // [NSDate date];得到的是格林治时间
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
