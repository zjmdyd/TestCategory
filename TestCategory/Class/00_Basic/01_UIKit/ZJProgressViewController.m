//
//  ZJProgressViewController.m
//  TestCategory
//
//  Created by ZJ on 1/16/17.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import "ZJProgressViewController.h"
#import "ZJViewHeaderFile.h"
#import "ZJDefine.h"

@interface ZJProgressViewController () {
    ZJProgressView *_huView;
}

@end

@implementation ZJProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //    创建自定义的仪表盘
    _huView = [[ZJProgressView alloc] initWithFrame:CGRectMake(0, 0, kScreenW*2/3, kScreenW*2/3)];
    _huView.center = CGPointMake(kScreenW/2, kScreenH/2-64);
    _huView.valueRatio = 0.5;
    [self.view addSubview:_huView];
    [_huView showContent:@"ahhh" withAnimate:YES];
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
