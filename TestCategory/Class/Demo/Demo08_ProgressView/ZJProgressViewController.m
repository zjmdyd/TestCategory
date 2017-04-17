//
//  ZJProgressViewController.m
//  TestCategory
//
//  Created by ZJ on 1/16/17.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import "ZJProgressViewController.h"
#import "ZJPreogressView.h"

@interface ZJProgressViewController () {
    ZJPreogressView *_huView;
}

@end

@implementation ZJProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //    创建自定义的仪表盘
    _huView = [[ZJPreogressView alloc] initWithFrame:CGRectMake(0, 0, kScreenW*2/3, kScreenW*2/3)];
    _huView.originValue = 80;
    _huView.center = CGPointMake(kScreenW/2, kScreenH/2-64);
    
    [self.view addSubview:_huView];
    [_huView showContentWithAnimate:NO];
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
