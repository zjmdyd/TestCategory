//
//  ZJNSTimerViewController.m
//  ZJFoundation
//
//  Created by YunTu on 15/6/6.
//  Copyright (c) 2015年 YunTu. All rights reserved.
//

#import "ZJNSTimerViewController.h"
#import "UIViewExt.h"

@interface ZJNSTimerViewController () {
    NSTimer *_timer, *_asyncTimer;
    NSInteger _num;
}

@property (strong, nonatomic) UILabel *numLabel;

@end

@implementation ZJNSTimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    
    /*
        多线程保证时间的精确性
     */
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self->_asyncTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(output) userInfo:nil repeats:YES];
    });
    
    self.numLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 150, 50)];
    self.numLabel.textAlignment = NSTextAlignmentCenter;
    self.numLabel.center = CGPointMake(self.view.center.x, self.numLabel.center.y);
    self.numLabel.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.numLabel];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, self.numLabel.bottom + 10, 100, 50)];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"invalidate" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(invalidate:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)output {
    NSLog(@"gg");
}

- (void)timerAction {
    _num++;
    self.numLabel.text = [NSString stringWithFormat:@"%zd", _num];
}

/*
    timer 执行invalidate后就不能再fire了,就变成无效了
 */
- (void)invalidate:(UIButton *)sender {
    if (_timer.isValid) {
        [_timer invalidate];
    }else {
        [_timer fire];
    }
    
    if (_timer.isValid) {
        NSLog(@"_timer isValid");
    }else {
        NSLog(@"_timer isInvalidate");
    }
    [_asyncTimer invalidate];
}

- (void)viewDidDisappear:(BOOL)animated {
    [_timer invalidate];
    [_asyncTimer invalidate];
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
