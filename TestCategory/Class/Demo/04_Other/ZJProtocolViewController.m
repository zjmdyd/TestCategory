//
//  ZJProtocolViewController.m
//  TestCategory
//
//  Created by ZJ on 5/4/17.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import "ZJProtocolViewController.h"

@interface ZJProtocolViewController ()

@end

@implementation ZJProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.text = @"@property (nonatomic, assign, readwrite) id delegate;\n声明一个delegate，那么即便delegate指向的对象销毁了，delegate中依然会保存之前对象的地址\n即，delegate成为了一个野指针...\n而使用weak，则不会有上述问题，当delegate指向的对象销毁后，delegate = nil";
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
