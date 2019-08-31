//
//  ZJSearchingViewController.m
//  TestCategory
//
//  Created by ZJ on 22/05/2017.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import "ZJSearchingViewController.h"
#import "ZJUIViewCategory.h"
#import "ZJSearchingView.h"
#import "ZJDefine.h"

@interface ZJSearchingViewController ()

@property (strong, nonatomic) ZJSearchingView *searchView;

@end

@implementation ZJSearchingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.searchView startSearching];
    self.searchView.contents = @"啊";
    self.searchView.font = [UIFont systemFontOfSize:22];
    self.searchView.textColor = [UIColor  redColor];
}

- (ZJSearchingView *)searchView {
    if (!_searchView) {
        CGFloat width = kScreenW/2.5;
        _searchView = [[ZJSearchingView alloc] initWithFrame:CGRectMake(0, 0, width, width) content:nil];
        _searchView.lineWidth = 2.5;
        _searchView.frontLineColor = [UIColor redColor];

        _searchView.center = CGPointMake(kScreenW/2, kScreenH/2-64);
        _searchView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_searchView];
    }
    
    return _searchView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([self.searchView.contents isKindOfClass:[NSString class]]) {
        self.searchView.contents = (__bridge id _Nullable)([UIImage imageNamed:@"ic_shebei_212x212"].CGImage);
        self.searchView.hiddenFrontLineLayer = self.searchView.hiddenBottomLineLayer = YES;
    }else {
        self.searchView.contents = @"哈哈啊";
        self.searchView.hiddenFrontLineLayer = self.searchView.hiddenBottomLineLayer = NO;
    }
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
