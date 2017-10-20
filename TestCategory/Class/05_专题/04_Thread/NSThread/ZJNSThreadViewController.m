//
//  ZJNSThreadViewController.m
//  ZJFoundation
//
//  Created by YunTu on 15/8/10.
//  Copyright (c) 2015年 YunTu. All rights reserved.
//

#import "ZJNSThreadViewController.h"
#import "UIViewExt.h"

@interface ZJNSThreadViewController () <UICollectionViewDataSource, UICollectionViewDelegate>{
    NSMutableArray *_colors;
    NSTimer *_addItemTimer;
    UIAlertView *_alertView;
    BOOL _isAutoControl;
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@end

const NSInteger itemCount = 12;

static NSString *CollectID = @"collectID";

@implementation ZJNSThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initAry];
    [self initSetting];
}

- (void)initAry {
    _colors = [NSMutableArray array];
}

- (void)initSetting {
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CollectID];
    
    //
    _alertView = [[UIAlertView alloc] initWithTitle:@"背景色" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    _isAutoControl = YES;
    
    /*
        create NSThread 法1:
     */
    NSThread *thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(thread1) object:nil];
    thread1.threadPriority = .5;
    [thread1 start];
    
    NSThread *thread2 = [[NSThread alloc] initWithTarget:self selector:@selector(thread2) object:nil];
    thread2.threadPriority = .6;
    [thread2 start];
}

- (void)thread1 {
    NSLog(@"thread1");
}

- (void)thread2 {
    NSLog(@"thread2");
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _colors.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectID forIndexPath:indexPath];
    cell.backgroundColor = _colors[indexPath.row];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    NSArray *strs = [cell.backgroundColor.description componentsSeparatedByString:@" "];
    _alertView.message = [NSString stringWithFormat:@"red:%@\ngreen:%@\nblue:%@\nalpha:%@", strs[1], strs[2], strs[3], strs[4]];
    [_alertView show];
}

#pragma mark -- UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((self.view.width-10)*0.5, (self.collectionView.height - 30) / 4);
}

- (IBAction)add:(UIButton *)sender {
    if (_addItemTimer.isValid) {
        [sender setTitle:@"继续...." forState:UIControlStateNormal];
        [_addItemTimer invalidate];
    }else {
        [sender setTitle:@"暂停...." forState:UIControlStateNormal];
        _addItemTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(addItem) userInfo:nil repeats:YES];
    }
}

- (void)addItem {
    float red =  arc4random() % 256 / 255.0;
    float green = arc4random() % 256 / 255.0;
    float blue = arc4random() % 256 / 255.0;
    float alpha = arc4random() % 256 / 255.0;
    
    UIColor *backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    [_colors addObject:backgroundColor];
    
    NSLog(@"test1");
    /*
        睡眠时间内, 线程被阻塞,程序不往下执行,停止1s后继续执行
     */
    [NSThread sleepForTimeInterval:1];
    NSLog(@"test2");

    [self.collectionView reloadData];
    if (self.collectionView.contentSize.height > self.collectionView.height && _isAutoControl == YES) {
        [UIView animateWithDuration:0.5 animations:^{
            [self.collectionView setContentOffset:CGPointMake(0, self.collectionView.contentSize.height - self.collectionView.height + 110)];
        }];
    }
}

- (IBAction)controlOffset:(UIButton *)sender {
    if (_isAutoControl) {
        _isAutoControl = NO;
        [sender setTitle:@"Auto" forState:UIControlStateNormal];
    }else {
        _isAutoControl = YES;
        [sender setTitle:@"Manual" forState:UIControlStateNormal];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [_addItemTimer invalidate];
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
