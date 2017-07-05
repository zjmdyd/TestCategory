//
//  ZJSearchDeviceTableViewController.m
//  TestCategory
//
//  Created by ZJ on 05/07/2017.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import "ZJSearchDeviceTableViewController.h"
#import "ZJViewHeaderFile.h"
#import "ZJCategoryHeaderFile.h"
#import "ZJBLETool.h"

@interface ZJSearchDeviceTableViewController ()

@end

@implementation ZJSearchDeviceTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initAry];
    [self initSettiing];
}

- (void)initAry {
    
}

- (void)initSettiing {
    self.title = @"设备列表";
    
    [ZJBLEDeviceManager shareManagerDidUpdateStateHandle:^(ZJDeviceManagerState state) {
        
    }];
}

- (void)searchDevice {
    [[ZJBLEDeviceManager shareManager] scanDeviceWithServiceUUIDs:nil prefix:nil completion:^(id obj) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSLog(@"%s", __func__);
    if (section == 0) {
        return [ZJBLEDeviceManager shareManager].discoveredBLEDevices.count;
    }else {
        return [ZJBLEDeviceManager shareManager].connectedBLEDevices.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __func__);
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SystemTableViewCell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SystemTableViewCell];
    }
    
    ZJBLEDevice *device;
    
    if (indexPath.section == 0) {
        device = [ZJBLEDeviceManager shareManager].discoveredBLEDevices[indexPath.row];
    }else {
        device = [ZJBLEDeviceManager shareManager].connectedBLEDevices[indexPath.row];
    }
    
    cell.textLabel.text = device.name;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @[@"已发现", @"已连接"][section];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ZJBLEDevice *device = [ZJBLEDeviceManager shareManager].discoveredBLEDevices[indexPath.row];
    [[ZJBLEDeviceManager shareManager] connectBLEDevices:@[device] completion:^(ZJBLEDevice *device, BOOL connected, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        if (connected) {
            [device discoverServices:nil completion:^(CBCharacteristic *obj, NSError *error) {
                
            }];
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
 
    [self searchDevice];
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
