//
//  ZJTestSysDirViewController.m
//  TestCategory
//
//  Created by ZJ on 08/05/2017.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import "ZJTestSysDirViewController.h"
#import "ZJNSObjectCategory.h"

@interface ZJTestSysDirViewController ()

@end

@implementation ZJTestSysDirViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self test];
}

- (void)test2 {
    id value = [self readFileWithPathComponent:@"nimei3"];
    if (!value) {
        [@{@"title" : @"haha"} writeToFileWithPathComponent:@"nimei3"];
    }else {
        NSLog(@"value = %@", value);
    }
}

- (void)test {
    NSString *homePath = NSHomeDirectory();
    NSLog(@"homePath = %@", homePath);  // 每次运行地址都不一样，但里面都包含了Documents、Library、tmp文件夹
    
    NSArray *ary = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); // YES 用省略NSHomeDirectory()，用波浪线代替
    NSLog(@"ary = %@", ary);
    
    NSError *error;
    NSString *docPath = ary.firstObject;
    NSString *path = [docPath stringByAppendingPathComponent:@"nimei"]; // 虽然每次NSHomeDirectory()不一样，但是根据NSDocumentDirectory相对路径可以实现数据的持久化操作
    NSString *value = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        NSLog(@"error1 = %@", error);
        
        NSError *error;
        [@"nimei" writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&error];
        NSLog(@"error2 = %@", error);
    }else {
        NSLog(@"value = %@", value);
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
