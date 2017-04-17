//
//  ViewController.m
//  TestCategory
//
//  Created by ZJ on 12/9/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import "ViewController.h"

#import "ZJNSObjectCategory.h"
#import "ZJFondationCategory.h"
#import "ZJUIViewCategory.h"
#import "ZJControllerCategory.h"
#import "ZJViewHeaderFile.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate> {
    NSArray *_vcNames, *_sectionTitles;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initAry];
    [self initSettiing];
}

- (void)initAry {
    _vcNames = @[
                 @[@"ZJApplicationViewController",],
                 @[@"ZJTestLabelViewController"],
                 @[@"ZJNSArrayViewController",],
                 @[@"ZJViewController"],
                 ];
    _sectionTitles = @[@"NSObject", @"UIKit", @"Fondation", @"UIViewController"];
}

- (void)initSettiing {
    self.navigationItem.title = @"ZJCustomTools";
    [self.tableView registerCellWithSysIDs:@[SystemTableViewCell]];
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
    cell.textLabel.text = _vcNames[indexPath.section][indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *name = _vcNames[indexPath.section][indexPath.row];
    UIViewController *vc = [self createVCWithName:name title:name];
    [self.navigationController pushViewController:vc animated:YES];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString *text = _sectionTitles[section];
    NSAttributedString *attText = [text attrWithFirstLineHeadIndent:16.0];
    
    return [UIView supplementViewWithAttributeText:attText];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
