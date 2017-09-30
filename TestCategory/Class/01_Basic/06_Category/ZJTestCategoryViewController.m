//
//  ZJTestCategoryViewController.m
//  TestCategory
//
//  Created by ZJ on 12/05/2017.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import "ZJTestCategoryViewController.h"
#import "UIViewController+ZJVCCategory.h"
#import "UIViewController_ZJVCExtention.h"
#import <objc/runtime.h>

@interface ZJTestCategoryViewController ()

@end

static void * MyObjectMyCustomPorpertyKey = (void *)@"MyObjectMyCustomPorpertyKey";

@implementation ZJTestCategoryViewController


//@synthesize text;

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addMethod];       // 分类方法
    [self addExtendMethod]; // 扩展方法
    
    self.value = @"尼米";
    self.myCustomProperty = @"哈哈";
        
    NSLog(@"value --> %@", self.value);
    NSLog(@"myCustomProperty --> %@", self.myCustomProperty);
}

- (void)addExtendMethod {
    NSLog(@"扩展的方法执行了");
}

- (id)myCustomProperty {
    return objc_getAssociatedObject(self, MyObjectMyCustomPorpertyKey);
}

- (void)setMyCustomProperty:(NSString *)myCustomProperty {
    objc_setAssociatedObject(self, MyObjectMyCustomPorpertyKey, myCustomProperty, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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
