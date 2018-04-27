//
//  ZJBasicTableViewController.m
//  TestCategory
//
//  Created by ZJ on 5/3/17.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import "ZJBasicTableViewController.h"
#import "ZJFondationCategory.h"
#import "ZJControllerCategory.h"

@interface ZJBasicTableViewController ()<UITableViewDataSource, UITableViewDelegate> {
    NSArray *_sectionTitles, *_vcNames;
}

@end

@implementation ZJBasicTableViewController

- (long)valueWithLongBytes:(Byte *)bytes len:(unsigned short)len {
    int byteVal[len];
    long value = 0;
    for (int j = 0; j < len; j++) {
        int a = (bytes[j] & 0xff) << ((len-1-j)*8);    // byteLen个字节int型数据每个字节的值
        
        byteVal[j] = a;
    }
    for (int j = 0; j < len; j++) {
        value |= byteVal[j];
    }
    
    return value;
}

- (int)valueWithIntBytes:(Byte *)bytes len:(unsigned short)len {
    int byteVal[len];
    int value = 0;
    for (int j = 0; j < len; j++) {
        int a = (bytes[j] & 0xff) << ((len-1-j)*8);    // byteLen个字节int型数据每个字节的值
        
        byteVal[j] = a;
    }
    for (int j = 0; j < len; j++) {
        value |= byteVal[j];
    }
    
    return value;
}

- (int)valueWithBytes:(Byte *)bytes len:(unsigned short)len {
    int byteVal[len];
    int value = 0;
    for (int j = 0; j < len; j++) {
        int a = (bytes[j] & 0xff) << ((len-1-j)*8);    // byteLen个字节int型数据每个字节的值
        
        byteVal[j] = a;
    }
    for (int j = 0; j < len; j++) {
        value |= byteVal[j];
    }
    
    return value;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initAry];
    [self initSettiing];
    Byte bytes[] = {0x11, 0x22};
    int value = [self valueWithIntBytes:bytes len:sizeof(bytes) / sizeof(Byte)];
    
    NSLog(@"value = %d, %lu", value, sizeof(bytes) / sizeof(Byte));
}

- (void)initAry {
    _sectionTitles = @[@"NSObject", @"UIKit", @"Foundation", @"Controller"];
    _vcNames = @[
                 @[
                     @"ZJTestApplicationViewController"
                     ],
                 @[
                     @"ZJTestLabelViewController", @"ZJTestScrollViewController", @"ZJSearchingViewController", @"ZJTestPureTextTableViewController",
                     @"ZJTestSubTitleTableViewController", @"ZJTestCollectionViewController", @"ZJProgressViewController",
                     ],
                 @[
                     @"ZJTestArrayViewController", @"ZJNSSetViewController", @"ZJNSRangeViewController0", @"ZJTestNumberViewController",
                     @"ZJTestStringViewController", @"ZJNSDateViewController", @"ZJNSTimerViewController", @"ZJNSExceptionViewController"
                     ],
                 @[
                     @"ZJTestViewController", @"ZJTestWebViewController", @"ZJTestTabBarViewController", @"ZJTestAlertViewController",
                     @"HYTestManualViewController", @"HYTestAutoRotationViewController"
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

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
    label.text = [NSString stringWithFormat:@"     %@", _sectionTitles[section]];
    label.textColor = [UIColor lightGrayColor];
    label.font = [UIFont systemFontOfSize:15];
    
    return label;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *name = _vcNames[indexPath.section][indexPath.row];
    UIViewController *vc = [self createVCWithName:name title:name  isGroupTableVC:YES];
    vc.hidesBottomBarWhenPushed = YES;
    if (indexPath.section == 3 && indexPath.row == 0) {
        [self showDetailViewController:vc sender:nil];
    }else {
        [self showViewController:vc sender:nil];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
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
