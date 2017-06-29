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
    NSMutableArray *_titles;
    UIScrollView *_mainScrollerView;
    UIView *_lineView;
    CGFloat _height;
}

@property (nonatomic, strong) UIView *statusView;
@property (nonatomic, strong) UIScrollView *topScrollView;
@property (nonatomic, strong) UIView *lineView;

@end

#define kToolBarH 44
#define kLineOffsetX 15
#define kPullButtonWidth 50
#define kTabBarHeight 49
#define kNaviBarBottom 64
#define kNaviBarHeight 44

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
    
    [self initSetting];
}

- (void)initSetting {
    _titles = [NSMutableArray array];
    _selectEnable = YES;
    
    if (self.offsetX > 0) {
        [self.view addSubview:self.statusView];
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.height = _height;
    [self createScrollView];
    if (self.selectIndex != 0) {
        [self btnEvent:[self buttonWithIndex:self.selectIndex]];
    }
}

- (void)createScrollView {
    [self.view addSubview:self.topScrollView];
    [self.topScrollView addSubview:self.lineView];
    
    CGFloat height = self.view.height - kNaviBarBottom - self.topScrollView.height;
    if (self.hidesBottomBarWhenPushed == NO) {
        height -= kTabBarHeight;
    }
    if (self.offsetX < FLT_EPSILON) {
        height += kNaviBarHeight;
    }
    
    _mainScrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _topScrollView.bottom, kScreenW, height)];
    _mainScrollerView.pagingEnabled = YES;
    _mainScrollerView.delegate = self;
    _mainScrollerView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_mainScrollerView];
    
    CGFloat offsetX = 0.0;
    CGFloat totalWidth = 0.0;
    for (int i = 0; i < _viewControllers.count; i++) {
        UIViewController *vc = _viewControllers[i];
        [_titles addObject:vc.title?:@""];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.tag = i;
        [btn setTitle:vc.title forState:UIControlStateNormal];
        CGFloat width = [UILabel fitSizeWithMargin:0 text:vc.title font:[UIFont systemFontOfSize:14]].width+kLineOffsetX*2;
        btn.frame = CGRectMake(offsetX, 0, width, _topScrollView.height);
        totalWidth += btn.width;

        if (i == 0) {
            _lineView.frame = CGRectMake(btn.left+kLineOffsetX, _topScrollView.height - 3.0f, btn.width  - kLineOffsetX*2, 2);
            _currentVC = vc;
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }else {
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        if (self.titleColor) {
            [btn setTitleColor:self.titleColor forState:UIControlStateNormal];
        }
        [btn addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
        [_topScrollView addSubview:btn];
        offsetX += width;
        
        vc.view.frame = CGRectMake(i*kScreenW, 0, kScreenW, _mainScrollerView.height);
        [_mainScrollerView addSubview:vc.view];
    }
    if (totalWidth < kScreenW) {
        CGFloat offset = (kScreenW - totalWidth)/(_viewControllers.count+1);
        for (int i = 0; i < _topScrollView.subviews.count; i++) {
            UIButton *btn = _topScrollView.subviews[i];
            if ([btn isKindOfClass:[UIButton class]]) {
                btn.left += offset*(btn.tag+1);// - 5*(btn.tag-1);
                if (btn.tag == 0) _lineView.left = btn.left+kLineOffsetX;
            }
        }
    }
    _topScrollView.contentSize = CGSizeMake(offsetX, 0);
    _topScrollView.directionalLockEnabled = YES;
    _mainScrollerView.contentSize = CGSizeMake(_viewControllers.count*kScreenW, 0);
}

#pragma mark - buttonEvent

- (void)btnEvent:(UIButton *)sender {
//    if (!self.selectEnable) return;
    
    _selectIndex = sender.tag;
    _currentVC = _viewControllers[_selectIndex];

    [self adjustTopScrollerViewContentOffset:sender];

    [_mainScrollerView setContentOffset:CGPointMake(kScreenW*sender.tag, 0) animated:YES];
    [self selectButtonItem:sender];
    
    if ([self.delegate respondsToSelector:@selector(tabBarViewController:didSelectedIndex:)]) {
        [self.delegate tabBarViewController:self didSelectedIndex:sender.tag];
    }
    if ([self.delegate respondsToSelector:@selector(tabBarViewController:didSelectedViewController:)]) {
        [self.delegate tabBarViewController:self didSelectedViewController:_viewControllers[sender.tag]];
    }
}

- (void)adjustTopScrollerViewContentOffset:(UIButton *)sender {
    if (sender.left+sender.width > _topScrollView.width) {
        CGFloat offsetX = sender.left+sender.width - _topScrollView.width;
        if (sender.tag < _viewControllers.count - 1) offsetX += 40;
        [_topScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }else {
        [_topScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}

- (void)selectButtonItem:(UIButton *)sender {
    [UIView animateWithDuration:.2 animations:^{
        _lineView.frame = CGRectMake(sender.left + kLineOffsetX, _lineView.top, sender.width  - kLineOffsetX*2, _lineView.height);
    } completion:^(BOOL finished) {
        [self changeButtonTitleColor:sender];
    }];
}

- (void)changeButtonTitleColor:(UIButton *)sender {
    for (UIButton *btn in _topScrollView.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            if (self.titleColor) {
                [btn setTitleColor:self.titleColor forState:UIControlStateNormal];
            }else {
                if (btn.tag == _selectIndex) {
                    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                }else {
                    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                }
            }
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
    for (UIButton *btn in _topScrollView.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            if (btn.tag == index) {
                return btn;
            }
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

- (void)setSelectEnable:(BOOL)selectEnable {
    _selectEnable = selectEnable;
    
    _topScrollView.userInteractionEnabled = _mainScrollerView.scrollEnabled = _selectEnable;
}

#pragma mark - getter

- (UIView *)statusView {
    if (!_statusView) {
        _statusView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 20)];
        _statusView.backgroundColor = self.statusViewColor;
    }
    
    return _statusView;
}

- (UIScrollView *)topScrollView {
    if (!_topScrollView) {
        _topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.offsetX, kScreenW, kToolBarH)];
        _topScrollView.showsHorizontalScrollIndicator = NO;
        _topScrollView.backgroundColor = self.topViewBgColor;
    }
    return _topScrollView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView.backgroundColor = self.titleColor ?: [UIColor redColor];
    }
    return _lineView;
}

- (UIColor *)topViewBgColor {
    if (!_topViewBgColor) {
        _topViewBgColor = [UIColor whiteColor];
    }
    return _topViewBgColor;
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
