//
//  ZJTestScrollViewController.m
//  TestCategory
//
//  Created by ZJ on 5/4/17.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import "ZJTestScrollViewController.h"
#import "ZJUIViewCategory.h"

@interface ZJTestScrollViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation ZJTestScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.scrollView.backgroundColor = [UIColor clearColor];
    UIView *view = [[UIView alloc] initWithFrame:self.scrollView.bounds];
    view.backgroundColor = [UIColor pinkColor];
    [self.scrollView addSubview:view];
}

#pragma mark - UIScrollViewDelegate

/**
 contentOffset.x:往左滑为正，右滑为负
 contentOffset.y:往上滑为正，下滑为负
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"%s, contentOffset = %@", __func__, NSStringFromCGPoint(scrollView.contentOffset));
    
}                                             // any offset changes

- (void)scrollViewDidZoom:(UIScrollView *)scrollView NS_AVAILABLE_IOS(3_2) {
    NSLog(@"%s", __func__);
} // any zoom scale changes

// called on start of dragging (may require some time and or distance to move)
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSLog(@"%s", __func__);
}
// called on finger up if the user dragged. velocity is in points/millisecond. targetContentOffset may be changed to adjust where the scroll view comes to rest
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset NS_AVAILABLE_IOS(5_0) {
    NSLog(@"%s", __func__);
    NSLog(@"velocity = %@, %@", NSStringFromCGPoint(velocity), NSStringFromCGPoint(*targetContentOffset));
}
// called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSLog(@"%s", __func__);
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    NSLog(@"%s", __func__);
}   // called on finger up as we are moving
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"%s", __func__);
}
// called when scroll view grinds to a halt

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSLog(@"%s", __func__);
}

// return a view that will be scaled. if delegate returns nil, nothing happens
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view NS_AVAILABLE_IOS(3_2) {
    NSLog(@"%s", __func__);
}
// called before the scroll view begins zooming its content
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale {
    NSLog(@"%s", __func__);
}
// scale between minimum and maximum. called after any 'bounce' animations

// return a yes if you want to scroll to the top. if not defined, assumes YES
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    NSLog(@"%s", __func__);
}
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
    NSLog(@"%s", __func__);
    return YES;
}

// called when setContentOffset/scrollRectVisible:animated: finishes. not called if not animating
- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    NSLog(@"%s", __func__);
    
    return nil;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _scrollView.alwaysBounceVertical = YES;
        _scrollView.alwaysBounceHorizontal = YES;
        _scrollView.directionalLockEnabled = YES;   // 滑动的时候有一个方向固定
        _scrollView.delegate = self;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
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
