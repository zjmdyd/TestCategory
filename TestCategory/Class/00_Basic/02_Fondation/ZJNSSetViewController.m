//
//  ZJNSSetViewController.m
//  ZJFoundation
//
//  Created by YunTu on 15/6/13.
//  Copyright (c) 2015年 YunTu. All rights reserved.
//

#import "ZJNSSetViewController.h"

@interface ZJNSSetViewController ()

@end

@implementation ZJNSSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self testIndexSet];
    
    NSMutableSet *mSet = [NSMutableSet set];
    NSMutableArray *mAry = [NSMutableArray array];
    
    for (int i = 0; i < 3; i++) {
        NSString *str = [NSString stringWithFormat:@"%d", i-i];
        NSArray *ary = [NSArray arrayWithObjects:str, nil];
        NSLog(@"str%d = %@, %p", i, str, str);
        NSLog(@"ary%d = %@, %p", i, ary, ary);
        [mSet addObject:ary];
        [mAry addObject:ary];
    }
    NSLog(@"mSet = %@, mAry = %@", mSet, mAry);
    
    NSNumber *num1 = [NSNumber numberWithInt:1];
    for (int i = 0; i < 3; i++) {
        [mSet addObject:num1];
        [mAry addObject:num1];
    }
    NSLog(@"mSet = %@, mAry = %@\n\n", mSet, mAry);
}

- (void)testIndexSet {
    NSMutableArray *ary = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        [ary addObject:[NSString stringWithFormat:@"a%d", i]];
    }
    NSArray *ary2 = [ary objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 5)]];
    NSLog(@"ary2 = %@", ary2);
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
