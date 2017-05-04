//
//  ZJTestLabelViewController.m
//  TestCategory
//
//  Created by ZJ on 1/2/17.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import "ZJTestLabelViewController.h"
#import "ZJUIViewCategory.h"
#import "UIViewExt.h"

@interface ZJTestLabelViewController ()

@end

@implementation ZJTestLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"哈哈哈哈哈哈哈哈哈哈哈哈哈哈";
    label.numberOfLines = 3;
    label.size = CGSizeMake(150, 30);
    label.center = CGPointMake(kScreenW/2, kScreenH/2);
    label.backgroundColor = [UIColor whiteColor];
    /*
     ** font匹配Label的size，当Label能放下当前文本时，不会改变Label的font
     */
//    label.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:label];
    
    UIView *view = [[UIView alloc] initWithFrame:label.frame];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    [self.view bringSubviewToFront:label];
    
    /*
     ** size匹配Label的font，当Label能放下当前文本时，会裁剪size以得到适合Label的size
     ** 当文本超过当前的size时:
     ** 1. numberOfLines=0时, 会改变Label的height，而宽度不会超过原size的width
     ** 2. numberOfLines=1时, 会改变Label的width,高度将会适配1行的高度
     ** 3. numberOfLines>1时, 按照行数得到对应行数的高度，但不会超过numberOfLines文本的高度，宽度不会超过原size的width, 与[label fitSizeWithWidth:]得到的size一样大
     */
    [label sizeToFit];
    NSLog(@"%@", NSStringFromCGRect(label.frame));

//    [label fitFontWithPointSize:17 width:label.width height:label.height descend:NO];
    CGSize size = [label sizeThatFits:CGSizeMake(150, MAXFLOAT)];
    NSLog(@"%@", NSStringFromCGSize(size));
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
