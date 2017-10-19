//
//  ZJNSExceptionViewController.m
//  ZJFoundation
//
//  Created by YunTu on 15/8/11.
//  Copyright (c) 2015年 YunTu. All rights reserved.
//

#import "ZJNSExceptionViewController.h"

@interface ZJNSExceptionViewController ()

@end

@implementation ZJNSExceptionViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    NSMutableArray *ary;
    NSLog(@"ary = %@", ary[1]);     // 程序不崩溃

    @try {
        NSLog(@"ary = %@", ary[1]);
//        NSException *exception = [NSException exceptionWithName: @"数组为空"
//                                                         reason: @"数组未初始化"
//                                                       userInfo: nil];
//        @throw exception;
    }
    @catch (NSException *exception) {
        @throw exception;
        
        NSLog(@"exception : %@, %@", exception.name, exception.reason);
    }
    @finally {
        ary = [NSMutableArray arrayWithObjects:@0, @1, nil];
        NSLog(@"ary = %@", ary);
    }
    
//    [self mode2];
}

- (void)mode2 {
    @try {
        @try {
            [self performSegueWithIdentifier:@"" sender:nil];
        }
        @catch (NSException *exception) {
            @throw exception;
        }
        @finally {
            NSLog(@"内层@finally");
        }
    }
    @catch (NSException *exception) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"功能尚未完成此项" message:@"\n继续努力" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        NSLog(@"exception : %@, %@", exception.name, exception.reason);
    }
    @finally {
        NSLog(@"外层@finally");
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
