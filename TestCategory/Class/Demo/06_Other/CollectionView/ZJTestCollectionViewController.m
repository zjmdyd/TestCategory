//
//  ZJTestCollectionViewController.m
//  TestCategory
//
//  Created by ZJ on 12/17/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import "ZJTestCollectionViewController.h"
#import "ZJCollectionTableViewCell.h"
#import "ZJUIViewCategory.h"

@interface ZJTestCollectionViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

static NSString *CollectionTableViewCell = @"ZJCollectionTableViewCell";

@implementation ZJTestCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initSettiing];
}

- (void)initSettiing {
//    [self.tableView registerCellWithIDs:@[CollectionTableViewCell]];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZJCollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CollectionTableViewCell];
    cell.objs = @[@"img1", @"img2", @"img3"];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kScreenH-64;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return FLT_EPSILON;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return FLT_EPSILON;
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
