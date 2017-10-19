//
//  ZJNSRangeViewController.m
//  ZJFoundation
//
//  Created by zjw on 12/28/15.
//  Copyright © 2015 YunTu. All rights reserved.
//

#import "ZJNSRangeViewController.h"

@interface ZJNSRangeViewController ()

@end

@implementation ZJNSRangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSMutableArray *ary = [NSMutableArray arrayWithObjects:@0, @1, @2, @3, @4, @5, nil];
    
    NSRange range = NSMakeRange(2, 4);
    [ary replaceObjectsInRange:range withObjectsFromArray:@[@5, @4, @3, @2]];
    NSLog(@"ary = %@", ary);
    
    NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
    NSLog(@"set = %@", set);
    NSLog(@"%zd, %zd", set.firstIndex, set.lastIndex);
    
    const NSUInteger *i, j = 10;
    i = &j;
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:i length:10];
    NSLog(@"indexPath = %zd", indexPath.length);
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
