//
//  ZJTopicTableViewController.m
//  TestCategory
//
//  Created by ZJ on 05/07/2017.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import "ZJTopicTableViewController.h"
#import "ZJCategoryHeaderFile.h"

@interface ZJTopicTableViewController () {
    NSArray *_sectionTitles, *_vcNames;
}

@end

@implementation ZJTopicTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initAry];
    [self initSettiing];
}

- (void)initAry {
    _sectionTitles = @[@"RunTime", @"NSPredicate", @"DataStore", @"fileManage", @"Thread", @"BLE", @"AV"];
    _vcNames = @[
                 @[
                     @"ZJRuntimeViewController"
                   ],
                 @[
                     @"ZJNSPredicateViewController"
                     ],
                 @[
                     @"ZJCoreDataViewController", @"ZJNSKeyedArchiverViewController"
                     ],
                 @[
                     @"ZJRuntimeViewController"
                     ],
                 @[
                     @"ZJNSThreadViewController", @"ZJNSOperationViewController", @"ZJNSOperationDownLoaderDemoVC", @"ZJNSLockViewController",
                     @"ZJNSRunLoopViewController"
                     ],
                 @[
                     @"ZJSearchDeviceTableViewController", @"ZJTestBluetoothViewController"
                     ],
                 @[
                     @"ZJAudioToolboxTableViewController", @"ZJAVAudioPlayerViewController", @"ZJAVPlayerViewController", @"ZJRecorderViewController", @"ZJAVCaptureSessionTableViewController"
                     ]
                 ];
}

- (void)initSettiing {
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _sectionTitles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_vcNames[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SystemTableViewCell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SystemTableViewCell];
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
    [self showViewController:vc sender:nil];
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
