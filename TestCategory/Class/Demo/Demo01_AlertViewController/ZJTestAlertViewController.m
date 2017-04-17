//
//  ZJTestAlertViewController.m
//  TestCategory
//
//  Created by ZJ on 12/13/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import "ZJTestAlertViewController.h"
#import "ZJNSObjectCategory.h"

@interface ZJTestAlertViewController ()
@end

@implementation ZJTestAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)click:(UIButton *)sender {
    [UIApplication showAlertViewWithTitle:@"哈哈" msg:@"" ctrl:self];
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
