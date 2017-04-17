//
//  ZJQRCodeViewController.m
//  Care
//
//  Created by ZJ on 9/6/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import "ZJQRCodeViewController.h"
#import "ZJQRView.h"

@interface ZJQRCodeViewController ()<QRViewDelegate>

@property (nonatomic, strong) ZJQRCodeCompleteHandler handler;

@end

#ifndef kScreenW

#define kScreenW    ([UIScreen mainScreen].bounds.size.width)
#define kScreenH    ([UIScreen mainScreen].bounds.size.height)

#endif

@implementation ZJQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSetting];
}

- (void)initSetting {
    self.title = @"扫一扫";
    
    self.view.backgroundColor = [UIColor whiteColor];
    ZJQRView *qrView = [[ZJQRView alloc]initWithFrame:CGRectMake(0, -64, kScreenW, kScreenH)];
    qrView.delegate = self;
    [self.view addSubview:qrView];
}

#pragma mark - QRViewDelegate

- (void)qrView:(ZJQRView *)view ScanResult:(NSString *)result {
    [view stopScan];
    
    if (self.handler) {
        self.handler(self, result);
    }
    [self performSelector:@selector(pop) withObject:nil afterDelay:0.25];
}

- (void)scanSuccessHandler:(ZJQRCodeCompleteHandler)scanSuccessHandler {
    self.handler = scanSuccessHandler;
}

- (void)pop {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
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
