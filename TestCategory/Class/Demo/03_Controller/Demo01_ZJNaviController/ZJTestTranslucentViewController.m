//
//  ZJTestTranslucentViewController.m
//  TestCategory
//
//  Created by ZJ on 5/3/17.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import "ZJTestTranslucentViewController.h"
#import "ZJControllerCategory.h"
#import "ZJControllerHeaderFile.h"

@interface ZJTestTranslucentViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ZJTestTranslucentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView.alwaysBounceVertical = YES;
    NSLog(@"%@", self.navigationController);    // 此时的self.navigationController属性为空, 所以此时设置不起作用
}

/**
 translucent = YES, frame是由edgesForExtendedLayout的设置决定的
 translucent = NO, 那么无论edgesForExtendedLayout怎么设置，视图的frame都是以导航条处为Y值的0点。
 */
- (IBAction)nextEvent:(UIButton *)sender {
    BOOL translucent = self.navigationController.navigationBar.isTranslucent;
    self.navigationController.navigationBar.translucent = !translucent;
    
    [sender setTitle:translucent?@"OPEN Translucent":@"CLOSE Translucent" forState:UIControlStateNormal];
    
    // translucent = 0, 15-->UIRectEdgeAll
    // translucent = 1, 15-->UIRectEdgeAll
    NSLog(@"translucent = %zd, %zd", !translucent, self.edgesForExtendedLayout);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    NSLog(@"%@", self.navigationController);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.translucent = NO;
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
