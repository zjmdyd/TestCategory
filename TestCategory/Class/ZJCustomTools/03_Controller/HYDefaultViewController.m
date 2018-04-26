//
//  HYDefaultViewController.m
//  XAHealthDoctor
//
//  Created by ZJ on 1/4/17.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import "HYDefaultViewController.h"

@interface HYDefaultViewController ()

@property (weak, nonatomic) IBOutlet UIView *mentionView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation HYDefaultViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initAry];
    [self initSetting];
}

- (void)initAry {
    
}

- (void)initSetting {
    self.scrollView.alwaysBounceVertical = YES;
    [self showMentionView];
}

- (void)showMentionView {
    self.mentionView.alpha = 0.0;
    [UIView animateWithDuration:0.25 animations:^{
        self.mentionView.alpha = 1.0;
    }];
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
