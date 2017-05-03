//
//  ZJPickerViewController.m
//  TestCategory
//
//  Created by ZJ on 1/1/17.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import "ZJPickerViewController.h"
#import "ZJViewHeaderFile.h"
#import "ZJPicker.h"

@interface ZJPickerViewController ()<ZJPickerViewDataSource, ZJPickerViewDelegate> {
    ZJDatePicker *_maskView;
    ZJPickerView *_pickerView;
}

@end

@implementation ZJPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    _maskView = [[ZJMaskView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    [KeyWindow addSubview:_maskView];
    
//    _maskView = [[ZJDatePicker alloc] initWithSuperView:KeyWindow datePickerMode:UIDatePickerModeDate];
    _pickerView = [[ZJPickerView alloc] initWithSuperView:KeyWindow dateSource:self delegate:self];
}

- (IBAction)btnEvent:(UIButton *)sender {
    [_pickerView setHidden:NO animated:YES completion:nil];
}

#pragma mark - ZJPickerViewDataSource

- (NSInteger)pickerView:(ZJPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 10;
}

#pragma mark - ZJPickerViewDelegate

- (NSString *)pickerView:(ZJPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"第%zd行", row];
}

- (void)pickerView:(ZJPickerView *)pickerView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        
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
