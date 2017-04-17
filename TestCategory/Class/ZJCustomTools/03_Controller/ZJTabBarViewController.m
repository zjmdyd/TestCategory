//
//  ZJTabBarViewController.m
//  PhysicalDate
//
//  Created by ZJ on 4/26/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import "ZJTabBarViewController.h"
//#import "HYPullDownSelectView.h"

@interface ZJTabBarViewController ()<UIScrollViewDelegate> {
    NSMutableArray *_titles;
    UIScrollView *_topScrollView, *_mainScrollerView;
    UIView *_lineView;
    CGFloat _height;
    UIButton *_pullButton;
    HYPullDownSelectView *_pullDownView;
}

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
    vc.hiddenPullView = YES;
    
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
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 20)];
        view.backgroundColor = [UIColor mainColor];
        [self.view addSubview:view];
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.height = _height;
    [self createScrollView];
    if (self.selectIndex != 0) {
        [self btnEvent:[self buttonWithIndex:self.selectIndex]];
    }
}

- (void)createScrollView {
    _topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.offsetX, kScreenW, kToolBarH)];
    _topScrollView.showsHorizontalScrollIndicator = NO;
    _topScrollView.backgroundColor = self.topViewBgColor;
    [self.view addSubview:_topScrollView];
    
    _lineView = [[UIView alloc] initWithFrame:CGRectZero];
    if (self.titleColor) {
        _lineView.backgroundColor = self.titleColor;
    }else {
        _lineView.backgroundColor = [UIColor mainColor];
    }
    
    [_topScrollView addSubview:_lineView];
    CGFloat height = self.view.height-kNaviBarBottom-_topScrollView.height;
    if (self.hidesBottomBarWhenPushed == NO) {
        height -= kTabBarHeight;
    }
    if (self.offsetX > 0) {
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
            [btn setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
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
    
    
    if (self.hiddenPullView == NO) {
        [self createPullDownView];
    }
}

- (void)createPullDownView {
    _pullButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _pullButton.frame = CGRectMake(kScreenW-kPullButtonWidth, 5, kPullButtonWidth, kToolBarH-10);
    _pullButton.tintColor = [UIColor lightGrayColor];
    [_pullButton setImage:[UIImage imageNamed:@"ic_arrow_down_gray_32x18"] forState:UIControlStateNormal];
    [_pullButton addTarget:self action:@selector(showSelectView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_pullButton];
    _topScrollView.width -= kPullButtonWidth;
    
    //
    _pullDownView = [[HYPullDownSelectView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, self.view.height)];
    _pullDownView.titles = _titles;
    _pullDownView.topTitle = @"  点击选择您喜欢的频道";
    [self.view addSubview:_pullDownView];
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
                    [btn setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
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

- (void)showSelectView:(UIButton *)sender {
    _pullDownView.hidden = !_pullDownView.isHidden;
}

- (void)selectPullDownView:(ZJSelectButton *)sender {
    sender.select = !sender.isSelect;
    
    if (sender.isSelect) {
        sender.backgroundColor = [UIColor mainColor];
    }else {
        sender.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
}

- (void)setHiddenPullView:(BOOL)hiddenPullView {
    _hiddenPullView = hiddenPullView;
    
    if (_topScrollView) {
        _pullButton.hidden = _hiddenPullView;
        
        if (_topScrollView.width < kScreenW && _hiddenPullView) {
            _topScrollView.width += kPullButtonWidth;
        }
    }
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

- (UIColor *)topViewBgColor {
    if (!_topViewBgColor) {
        _topViewBgColor = [UIColor whiteColor];
    }
    return _topViewBgColor;
}

- (void)viewDidAppear:(BOOL)animated {
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
        _hiddenPullView = YES;
    }
    
    return self;
}

- (instancetype)initWithViewControllers:(NSArray *)viewControllers height:(CGFloat)height {
    if (self = [super init]) {
        _viewControllers = viewControllers;
        _height = height;
        _hiddenPullView = YES;
    }
    
    return self;
}

@end
