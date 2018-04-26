//
//  ZJTestViewController.m
//  TestCategory
//
//  Created by ZJ on 4/14/17.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import "ZJTestViewController.h"
#import "ZJControllerCategory.h"

@interface ZJTestViewController ()

@end

@implementation ZJTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.layer.borderWidth = 10.0;
    self.view.layer.borderColor = [UIColor redColor].CGColor;
}

- (IBAction)popEvent:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
//    [self.navigationController popViewControllerFromDirection:TransitionDerectionOfBottom];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
