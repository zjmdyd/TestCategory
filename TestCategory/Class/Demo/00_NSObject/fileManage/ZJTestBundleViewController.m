//
//  ZJTestBundleViewController.m
//  TestCategory
//
//  Created by ZJ on 08/05/2017.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import "ZJTestBundleViewController.h"

@interface ZJTestBundleViewController ()

@end

@implementation ZJTestBundleViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self test];
}

/**
 *  此种方法只能临时修改文件，主要用于取本地文件
 */
- (void)test {
    NSBundle *bund = [NSBundle mainBundle];
    NSLog(@"resourcePath-->%@", bund.resourcePath); // resourcePath和bundlePath相同，每次运行次地址也会改变
    NSLog(@"bundlePath-->%@", bund.bundlePath);
    
    NSError *error;
    
    NSString *path = [bund pathForResource:@"TestWrite" ofType:@"txt"];
    NSLog(@"path = %@", path);
    
    NSString *value = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"value = %@", value);
    
    [@"哇哈哈" writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    if (error) {
        NSLog(@"error = %@", error);
    }
    
    NSString *path2 = [bund pathForResource:@"nimei" ofType:@"txt"];
    value = [NSString stringWithContentsOfFile:path2 encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"value2 = %@", value);
    
    NSString *path3 = [[bund resourcePath] stringByAppendingPathComponent:@"nimei.txt"];
    [@"nimei" writeToFile:path3 atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    value = [NSString stringWithContentsOfFile:path3 encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"value22 = %@", value);
}

/**
/Users/ZJ/Library/Developer/CoreSimulator/Devices/7B1C3658-9DC4-43EB-9167-4D7B4A3DCA0E/data/Containers/Bundle/Application/7653C7D8-1B08-4948-80E0-ECF84BABE6B5/TestCategory.app
/Users/ZJ/Library/Developer/CoreSimulator/Devices/7B1C3658-9DC4-43EB-9167-4D7B4A3DCA0E/data/Containers/Bundle/Application/7653C7D8-1B08-4948-80E0-ECF84BABE6B5/TestCategory.app
 
/Users/ZJ/Library/Developer/CoreSimulator/Devices/7B1C3658-9DC4-43EB-9167-4D7B4A3DCA0E/data/Containers/Bundle/Application/BB9EF35A-8A86-4753-BB51-459DB19BC67B/TestCategory.app
/Users/ZJ/Library/Developer/CoreSimulator/Devices/7B1C3658-9DC4-43EB-9167-4D7B4A3DCA0E/data/Containers/Data/Application/E8BBBAE7-B105-4912-8B80-25805ED863E9

 */
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
