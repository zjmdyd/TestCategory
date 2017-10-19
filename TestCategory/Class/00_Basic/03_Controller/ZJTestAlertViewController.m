//
//  ZJTestAlertViewController.m
//  TestCategory
//
//  Created by ZJ on 12/13/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import "ZJTestAlertViewController.h"
#import "HYTestContentTableViewController.h"

#import "ZJNSObjectCategory.h"

@interface ZJTestAlertViewController ()<UIPopoverPresentationControllerDelegate>

@property (nonatomic, strong) UIPopoverPresentationController *popover;
@property (nonatomic, strong) HYTestContentTableViewController *contentVC;

@end

@implementation ZJTestAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSettiing];
}

/**
 自定义返回按钮将导致侧滑返回手势失效
 */
- (void)initSettiing {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Popover" style:UIBarButtonItemStylePlain target:self action:@selector(barItemAction:)];
    
    //    self.popover = [[UIPopoverPresentationController alloc] initWithPresentedViewController:vc presentingViewController:self];
}

/**
 想在iPhone设备上实现iPad的效果,就需要实现下面1个代理方法
 */
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}

- (nullable UIViewController *)presentationController:(UIPresentationController *)controller viewControllerForAdaptivePresentationStyle:(UIModalPresentationStyle)style {
    NSLog(@"controller = %@", controller);  /// 此controller就是self.popover
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:self.contentVC];
    
    return navi;
}

- (void)barItemAction:(UIBarButtonItem *)sender {
    if (!self.popover) {
        self.contentVC = [[HYTestContentTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
        self.contentVC.modalPresentationStyle = UIModalPresentationPopover;
        self.contentVC.preferredContentSize = CGSizeMake(300, 500);
    }
    self.popover = self.contentVC.popoverPresentationController;
    // 设置代理
    self.popover.delegate = self;
    self.popover.permittedArrowDirections = UIPopoverArrowDirectionUp;
    self.popover.barButtonItem = self.navigationItem.rightBarButtonItem;
    
    NSLog(@"self.popover = %@", self.popover);  /// 每次的popover都不一样
    
    [self presentViewController:self.contentVC animated:YES completion:nil];
}

/**
 UIAlertControllerStyleAlert 当UIAlertAction大于2个的时候都是UIAlertControllerStyleActionSheet
 当style是UIAlertControllerStyleAlert时，popover效果不起作用
 
 iPad:
 当你把一个Action的ActionStyle设置为cancel的时候，iPad将不会显示这个Action。
 在iPad上，ActionSheet会被以popover的形式显示出来，它衣服在当前页面的某一个组件上，
 因为必须指定一个sourceView用于指定ActionSheet的依附点（在这个空间的周围被弹出），同时还应指定一个sourceRect用于指定他被包含在哪一片区域内
 */
- (IBAction)btnEvent:(UIButton *)sender {
    UIAlertControllerStyle style = UIAlertControllerStyleAlert;
    if (sender.tag == 1) {
        style = UIAlertControllerStyleActionSheet;
    }
    UIAlertController *ctl = [UIAlertController alertControllerWithTitle:@"一点也不简单" message:@"哈哈哈" preferredStyle:style];
    
    UIAlertAction *act1 = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"删除按钮被点击");
    }];
    [ctl addAction:act1];
    
    if (sender == 0) {
        UIAlertAction *act2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"取消按钮被点击");
        }];
        [ctl addAction:act2];
    }
    
    UIAlertAction *act3 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"OK按钮被点击");
    }];
    [ctl addAction:act3];
    
    if (sender.tag == 0) {
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            ctl.popoverPresentationController.sourceView = sender;
            ctl.popoverPresentationController.sourceRect = CGRectMake(0, 0, 100, 100);
        }
        [self presentViewController:ctl animated:YES completion:nil];
    }else {
        ctl.modalPresentationStyle = UIModalPresentationPopover;
        ctl.preferredContentSize = CGSizeMake(300, 500);
        ctl.popoverPresentationController.sourceView = sender;
        /**
         sourceRect:
         @param sender.frame.size.width/2 sende宽度的一半
         @param sender.frame.size.height sender的高度
         @param 0 水平距离为0
         @param 0 垂直距离为0
         */
        ctl.popoverPresentationController.sourceRect = CGRectMake(sender.frame.size.width/2, sender.frame.size.height, 0, 0);
        ctl.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
        ctl.popoverPresentationController.delegate = self;
        [self presentViewController:ctl animated:YES completion:nil];
    }
}

- (IBAction)click:(UIButton *)sender {
    [UIApplication showAlertViewWithTitle:@"哈哈" msg:@"" buttonTitle:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.view.backgroundColor = [UIColor purpleColor];
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
