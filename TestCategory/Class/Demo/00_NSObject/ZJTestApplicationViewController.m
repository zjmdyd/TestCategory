//
//  ZJTestApplicationViewController.m
//  TestCategory
//
//  Created by ZJ on 4/14/17.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import "ZJTestApplicationViewController.h"
#import "ZJNSObjectCategory.h"

@interface ZJTestApplicationViewController ()

@end

@implementation ZJTestApplicationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [UIApplication openSystemSettingWithType:SystemSettingTypeOfWiFi];
    NSLog(@"currentVC = %@", [UIApplication currentVC]);
    NSLog(@"currentVC = %@", [self nameWithInstance:self]);
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
