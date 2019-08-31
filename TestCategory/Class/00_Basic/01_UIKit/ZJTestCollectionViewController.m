//
//  ZJTestCollectionViewController.m
//  TestCategory
//
//  Created by ZJ on 03/07/2017.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import "ZJTestCollectionViewController.h"
#import "ZJViewHeaderFile.h"
#import "ZJCategoryHeaderFile.h"
#import "UITextView+Placeholder.h"
#import "ZJDefine.h"

@interface ZJTestCollectionViewController () <UICollectionViewDelegateFlowLayout, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ZJTestCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerCellWithNibIDs:@[CollectionTableViewCell]];
    [self.collectionView registerCellWithNibIDs:@[IconTitleVerticalCollectionCell]];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZJIconTitleVerticalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:IconTitleVerticalCollectionCell forIndexPath:indexPath];
    cell.iconPlaceholder = @"ic_shebei_212x212";
    cell.iconPath = @"ic_shebei_212x212";
    cell.text = [NSString stringWithFormat:@"item%zd", indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZJCollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CollectionTableViewCell];
    cell.titles = @[@"item1", @"item2"];
    cell.iconPaths = @[@"ic_shebei_212x212", @"ic_shebei_212x212"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kScreenW/2;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    return CGSizeMake(150, 150);
//}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
 
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
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
