//
//  ZJTestWebViewController.m
//  TestCategory
//
//  Created by ZJ on 5/4/17.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import "ZJTestWebViewController.h"

@interface ZJTestWebViewController ()

@end

@implementation ZJTestWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.webView.backgroundColor = [UIColor whiteColor];
    
    self.address = @"http://www.mycodes.net/105/9281.htm";
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
