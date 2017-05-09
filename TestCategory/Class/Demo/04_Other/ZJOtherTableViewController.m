//
//  ZJOtherTableViewController.m
//  TestCategory
//
//  Created by ZJ on 5/4/17.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import "ZJOtherTableViewController.h"
#import "ZJTextViewController.h"
#import "ZJNSObjectCategory.h"
//#import "ZJControllerCategory.h"
//#import "ZJFondationCategory.h"

@interface ZJOtherTableViewController ()<ZJTextViewControllerDelegate> {
    NSString *_path;
    NSMutableArray *_files;
    NSMutableDictionary *_selectDic;
}

@end

@implementation ZJOtherTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initAry];
}

- (void)initAry {
    _path = [[NSBundle mainBundle] pathForResource:@"note" ofType:@"plist"];
    _files = [[NSArray arrayWithContentsOfFile:_path] mutableCopy];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _files.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    NSDictionary *dic = _files[indexPath.row];
    cell.textLabel.text = dic[@"title"];
    
    NSDictionary *value = [self readFileWithPathComponent:dic[@"title"]];
    NSDate *date;
    if (!value) {
        date = dic[@"time"];
    }else {
        date = dic[@"time"];
    }
    date = dic[@"time"];
    NSDateFormatter *format = [NSDateFormatter new];
    format.dateFormat = @"yyyy/MM/dd HH:mm";
    cell.detailTextLabel.text = [format stringFromDate:date];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    _selectDic = _files[indexPath.row];

    NSString *text = _selectDic[@"value"];
    ZJTextViewController *vc = [[ZJTextViewController alloc] initWithText:text];
    vc.delegate = self;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - ZJTextViewControllerDelegate

- (void)textViewController:(ZJTextViewController *)viewController didEndEditText:(NSString *)text {
    [_selectDic setObject:text forKey:@"value"];
    [_selectDic setObject:[NSDate date] forKey:@"time"];
    [_files writeToFile:_path atomically:YES];
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
