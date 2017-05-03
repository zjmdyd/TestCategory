//
//  ZJMentionViewController.m
//  TestCategory
//
//  Created by ZJ on 1/1/17.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import "ZJMentionViewController.h"
#import "ZJControllerCategory.h"
#import "ZJViewHeaderFile.h"

@interface ZJMentionViewController ()

@end

@implementation ZJMentionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    NSLog(@"KeyWindow = %@", KeyWindow);
    [self showMentionViewWithImgName:@"ic_message_gray_160x160" text:@"哈哈" animated:YES superView:self.view];
}

/**
 
 typedef NS_OPTIONS(NSUInteger, UIRectEdge) {
 UIRectEdgeNone   = 0,      YES
 UIRectEdgeLeft   = 1 << 1, YES
 UIRectEdgeBottom = 1 << 2, YES
 UIRectEdgeRight  = 1 << 3, YES
 
 UIRectEdgeTop    = 1 << 0,  NO
 UIRectEdgeAll    =          NO
 }
 
 当不是顶部布局的时候需要调整
 */
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
