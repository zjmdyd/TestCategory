//
//  ZJBasicTableViewController.m
//  TestCategory
//
//  Created by ZJ on 5/3/17.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import "ZJBasicTableViewController.h"
#import "ZJControllerCategory.h"

@interface ZJBasicTableViewController ()<UITableViewDataSource, UITableViewDelegate> {
    NSArray *_sectionTitles, *_vcNames;
}

@end

@implementation ZJBasicTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initAry];
    [self initSettiing];
}

- (void)initAry {
    _sectionTitles = @[@"NSObject", @"UIKit", @"Foundation", @"Controller", @"Navigation", @"File", @"Category", @"Thread"];
    _vcNames = @[
                 @[
                     @"ZJTestApplicationViewController"
                     ],
                 @[
                     @"ZJTestLabelViewController", @"ZJTestScrollViewController", @"ZJSearchingViewController", @"ZJTestPureTextTableViewController",
                     @"ZJTestSubTitleTableViewController", @"ZJTestCollectionViewController", @"ZJProgressViewController"
                     ],
                 @[
                     @"ZJTestArrayViewController", @"ZJTestNumberViewController", @"ZJTestStringViewController", @"ZJTestCategoryViewController"
                     ],
                 @[
                     @"ZJTestViewController", @"ZJTestWebViewController", @"ZJTestTabBarViewController", @"ZJTestAlertViewController", @"HYTestManualViewController",
                     @"HYTestAutoRotationViewController"
                     ],
                 @[
                     @"ZJTestBackBarButtonItemViewController", @"ZJTestNavigationBarViewController", @"ZJTestNavigationItemViewController", @"ZJTestTranslucentViewController"
                     ],
                 @[
                     @"ZJTestBundleViewController", @"ZJTestFileTableViewController", @"ZJTestSysDirViewController"
                     ],
                 @[
                     @"ZJTestCategoryViewController"
                     ],
                 @[
                     @"ZJNSThreadViewController", @"ZJNSOperationViewController", @"ZJNSOperationDownLoaderDemoVC", @"ZJNSLockViewController", @"ZJGCDViewController"
                   ],
                 ];
}

- (void)initSettiing {
    self.navigationItem.title = @"Welcome";  /// 实现tabBarItem.title和navigationItem.tiltle不一样的显示
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _sectionTitles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_vcNames[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = _vcNames[indexPath.section][indexPath.row];
    
    return cell;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return _sectionTitles[section];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *name = _vcNames[indexPath.section][indexPath.row];
    UIViewController *vc = [self createVCWithName:name title:name  isGroupTableVC:YES];
    vc.hidesBottomBarWhenPushed = YES;
    [self showViewController:vc sender:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
