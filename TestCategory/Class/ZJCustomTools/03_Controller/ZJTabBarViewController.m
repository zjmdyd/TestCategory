//
//  ZJTabBarViewController.m
//  PhysicalDate
//
//  Created by ZJ on 4/26/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import "ZJTabBarViewController.h"
#import "UIViewExt.h"
#import "ZJUIViewCategory.h"

@interface ZJTabBarViewController ()<UIScrollViewDelegate> {
    NSMutableArray *_titles, *_scrButtons;
    UIView *_lineView;
    CGFloat _height, _mainViewH;
}

@property (nonatomic, strong) UIView *statusView;
@property (nonatomic, strong) UIScrollView *topScrollView;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) UIView *lineView;

@end

#define kToolBarH 44
#define kLineOffsetX 8
#define kTabBarHeight 49
#define kNaviBarHeight 44
#define kStatusBarH 20

@implementation ZJTabBarViewController

+ (instancetype)barViewControllerWithViewControllers:(NSArray *)viewControllers {
    ZJTabBarViewController *vc = [ZJTabBarViewController new];
    vc->_viewControllers = viewControllers;
    vc->_height = kScreenH;
    
    return vc;
}

+ (instancetype)barViewControllerWithViewControllers:(NSArray *)viewControllers height:(CGFloat)height {
    ZJTabBarViewController *vc = [ZJTabBarViewController barViewControllerWithViewControllers:viewControllers];
    vc->_height = height;
    
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initAry];
    [self initSetting];
}

- (void)initAry {
    _titles = [NSMutableArray array];
    _scrButtons = [NSMutableArray array];
}

- (void)initSetting {
    self.view.height = _height;
    self.view.backgroundColor = [UIColor whiteColor];
    _selectEnable = YES;
    
    if (self.offsetX > 0) {
        [self.view addSubview:self.statusView];
    }
    
    [self createScrollView];
    
    if (self.selectIndex != 0) {
        [self btnEvent:[self buttonWithIndex:self.selectIndex]];
    }
}

- (void)createScrollView {
    [self.view addSubview:self.topScrollView];
    [self.topScrollView addSubview:self.lineView];
    
    _mainViewH = self.view.height - self.offsetX - self.topScrollView.height;
    if (self.hidesBottomBarWhenPushed == NO) {
        _mainViewH -= kTabBarHeight;
    }
    
    if (self.offsetX < FLT_EPSILON) {
        _mainViewH -= (kNaviBarHeight + kStatusBarH);
    }
    
    [self.view addSubview:self.mainScrollView];
    
    CGFloat totalWidth = 0.0;
    for (int i = 0; i < _viewControllers.count; i++) {
        UIViewController *vc = _viewControllers[i];
        [_titles addObject:vc.title?:@""];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.tag = i;
        [btn setTitle:vc.title forState:UIControlStateNormal];
        [_scrButtons addObject:btn];
        
        CGFloat width = [UILabel fitSizeWithMargin:0 text:vc.title font:[UIFont systemFontOfSize:14]].width+kLineOffsetX*2;
        btn.frame = CGRectMake(totalWidth, 0, width, self.topScrollView.height);
        totalWidth += width;
        
        if (i == 0) {
            _currentVC = vc;
            self.lineView.frame = CGRectMake(btn.left+kLineOffsetX, self.topScrollView.height - 3.0f, btn.width  - kLineOffsetX*2, 2);
            [btn setTitleColor:self.currentTitleColor forState:UIControlStateNormal];
        }else {
            [btn setTitleColor:self.titleColor forState:UIControlStateNormal];
        }
        [btn addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.topScrollView addSubview:btn];
        
        vc.view.frame = CGRectMake(i*kScreenW, 0, kScreenW, self.mainScrollView.height);
        [self.mainScrollView addSubview:vc.view];
    }
    if (totalWidth < kScreenW) {
        CGFloat offset = (kScreenW - totalWidth) / (_viewControllers.count+1);
        for (UIButton *btn in _scrButtons) {
            btn.left += offset*(btn.tag+1);
            if (btn.tag == 0) _lineView.left = btn.left+kLineOffsetX;
        }
    }
    self.topScrollView.contentSize = CGSizeMake(totalWidth, 0);
    self.mainScrollView.contentSize = CGSizeMake(_viewControllers.count*kScreenW, 0);
}

#pragma mark - buttonEvent

- (void)btnEvent:(UIButton *)sender {
    if (_selectIndex == sender.tag) return;
    
    _selectIndex = sender.tag;
    _currentVC = _viewControllers[_selectIndex];
    
    [self adjustTopScrollViewContentOffset:sender];
    
    [self selectButtonItem:sender];
    [self.mainScrollView setContentOffset:CGPointMake(kScreenW*sender.tag, 0) animated:YES];
    
    if ([self.delegate respondsToSelector:@selector(tabBarViewController:didSelectedIndex:)]) {
        [self.delegate tabBarViewController:self didSelectedIndex:sender.tag];
    }
    
    if ([self.delegate respondsToSelector:@selector(tabBarViewController:didSelectedViewController:)]) {
        [self.delegate tabBarViewController:self didSelectedViewController:_viewControllers[sender.tag]];
    }
}

- (void)adjustTopScrollViewContentOffset:(UIButton *)sender {
    if (sender.left + sender.width > self.topScrollView.width) {
        CGFloat offsetX = sender.left + sender.width - self.topScrollView.width;
        if (sender.tag < _viewControllers.count - 1) offsetX += 40;
        [self.topScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }else {
        [self.topScrollView setContentOffset:CGPointZero animated:YES];
    }
}

- (void)selectButtonItem:(UIButton *)sender {
    [UIView animateWithDuration:.2 animations:^{
        self.lineView.frame = CGRectMake(sender.left + kLineOffsetX, self.lineView.top, sender.width - kLineOffsetX*2, self.lineView.height);
    } completion:^(BOOL finished) {
        [self changeButtonTitleColor:sender];
    }];
}

- (void)changeButtonTitleColor:(UIButton *)sender {
    for (UIButton *btn in _scrButtons) {
        if (btn.tag == _selectIndex) {
            [btn setTitleColor:self.currentTitleColor forState:UIControlStateNormal];
        }else {
            [btn setTitleColor:self.titleColor forState:UIControlStateNormal];
        }
    }
}

- (void)setSelectIndex:(NSUInteger)selectIndex {
    if (selectIndex >= _viewControllers.count) {
        selectIndex = _viewControllers.count-1;
    }
    
    if (_selectIndex != selectIndex) {
        _selectIndex = selectIndex;
        
        if (_topScrollView) {
            UIButton *btn = [self buttonWithIndex:_selectIndex];
            if (btn) {
                [self btnEvent:btn];
            }
        }
    }
}

- (UIButton *)buttonWithIndex:(NSUInteger)index {
    for (UIButton *btn in _scrButtons) {
        if (btn.tag == index) {
            return btn;
        }
    }
    
    return nil;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSUInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    UIButton *btn = [self buttonWithIndex:index];
    if (btn) {
        [self btnEvent:btn];
    }
}

#pragma mark - setter

- (void)setSelectEnable:(BOOL)selectEnable {
    _selectEnable = selectEnable;
    
    self.topScrollView.userInteractionEnabled = self.mainScrollView.scrollEnabled = _selectEnable;
}

#pragma mark - getter

- (UIView *)statusView {
    if (!_statusView) {
        _statusView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, self.offsetX)];
        _statusView.backgroundColor = self.statusViewColor;
    }
    
    return _statusView;
}

- (UIScrollView *)topScrollView {
    if (!_topScrollView) {
        _topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.offsetX, kScreenW, kToolBarH)];
        _topScrollView.directionalLockEnabled = YES;
        _topScrollView.showsHorizontalScrollIndicator = NO;
        _topScrollView.backgroundColor = self.topViewBgColor;
    }
    
    return _topScrollView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView.backgroundColor = self.currentTitleColor;
    }
    return _lineView;
}

- (UIScrollView *)mainScrollView {
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _topScrollView.bottom, kScreenW, _mainViewH)];
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.delegate = self;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
    }
    
    return _mainScrollView;
}

- (UIColor *)topViewBgColor {
    if (!_topViewBgColor) {
        _topViewBgColor = [UIColor whiteColor];
    }
    
    return _topViewBgColor;
}

- (UIColor *)currentTitleColor {
    if (!_currentTitleColor) {
        _currentTitleColor = [UIColor redColor];
    }
    
    return _currentTitleColor;
}

- (UIColor *)titleColor {
    if (!_titleColor) {
        _titleColor = [UIColor blackColor];
    }
    
    return _titleColor;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.view.height = _height;
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

- (instancetype)initWithViewControllers:(NSArray *)viewControllers {
    if (self = [super init]) {
        _viewControllers = viewControllers;
        _height = kScreenH;
    }
    
    return self;
}

- (instancetype)initWithViewControllers:(NSArray *)viewControllers height:(CGFloat)height {
    if (self = [super init]) {
        _viewControllers = viewControllers;
        _height = height;
    }
    
    return self;
}

@end
