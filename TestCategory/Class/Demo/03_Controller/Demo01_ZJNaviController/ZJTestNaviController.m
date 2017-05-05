//
//  ZJTestNaviController.m
//  TestCategory
//
//  Created by ZJ on 5/3/17.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import "ZJTestNaviController.h"
#import "ZJControllerCategory.h"
#import "ZJControllerHeaderFile.h"

@interface ZJTestNaviController ()

@end

@implementation ZJTestNaviController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@", self.navigationController);    // 此时的self.navigationController属性为空, 所以此时设置不起作用
    ((ZJNavigationController *)self.navigationController).navigationBarTranslucent = YES;
}

- (IBAction)nextEvent:(UIButton *)sender {
    UIViewController *vc = [self createVCWithName:@"ZJNaviNextViewController" title:nil];
    [self.navigationController pushViewController:vc
                                         animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"%@", self.navigationController);
    ((ZJNavigationController *)self.navigationController).navigationBarTranslucent = YES;
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
