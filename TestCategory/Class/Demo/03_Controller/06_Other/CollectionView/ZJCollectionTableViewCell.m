//
//  ZJCollectionTableViewCell.m
//  TestCategory
//
//  Created by ZJ on 12/17/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import "ZJCollectionTableViewCell.h"
#import "ZJImageCollectionViewCell.h"
#import "ZJUIViewCategory.h"

@interface ZJCollectionTableViewCell ()<UICollectionViewDataSource,  UICollectionViewDelegate> {
    NSInteger _index;
    NSTimer *_timer;
    NSInteger _willDisRow, _endDisRow;
    BOOL _isFirstDis;
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic, strong) NSMutableArray *imgs;

@end

#define LineSpacing 8
#define MarginSpacing 10
#define ScrDuration 6

static NSString *ImageCollectionViewCell = @"ZJImageCollectionViewCell";

@implementation ZJCollectionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.collectionView.pagingEnabled = YES;
    [self.collectionView registerNib:[UINib nibWithNibName:ImageCollectionViewCell bundle:nil] forCellWithReuseIdentifier:ImageCollectionViewCell];
}

- (void)setObjs:(NSArray *)objs {
    _objs = objs;
    
    [self insertObjectAtFirst];
    [self.collectionView reloadData];
    [self performSelector:@selector(act) withObject:nil afterDelay:0.05];
}

- (void)act {
    [self.collectionView setContentOffset:CGPointMake(kScreenW, 0)];
}

/**
 willDisplayRow < EndDisplayRow 向左
 willDisplayRow > EndDisplayRow 向右
 */

//- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"willDisplayRow = %zd", indexPath.row);
//    _willDisRow = indexPath.row;
//}
//
//- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"EndDisplayRow = %zd", indexPath.row);
//    
//    _endDisRow = indexPath.row;
//    
//    if (!_isFirstDis) {
//        _isFirstDis = YES;
//    }else {
//        if (_willDisRow != _endDisRow) {
//            [self changePosition:_willDisRow > _endDisRow];
//        }
//    }
//}

- (void)changePosition:(BOOL)isMoveToRight {
    if (isMoveToRight) {
        [self insertObjectAtLast];
    }else {
        [self insertObjectAtFirst];
    }
    NSLog(@"imgs = %@", self.imgs);

    [self.collectionView reloadData];
    [self.collectionView setContentOffset:CGPointMake(kScreenW, 0) animated:NO];

    _isFirstDis = NO;

}

- (void)insertObjectAtFirst {
    [self.imgs insertObject:self.imgs.lastObject atIndex:0];
    [self.imgs removeLastObject];
}

- (void)insertObjectAtLast {
    [self.imgs addObject:self.imgs.firstObject];
    [self.imgs removeObjectAtIndex:0];
}

- (NSMutableArray *)imgs {
    if (!_imgs) {
        _imgs = [NSMutableArray arrayWithArray:self.objs];
    }
    return _imgs;
}

#pragma mark - UICollectionViewDataSource

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.bounds.size.width;
    
    int page = floor((scrollView.contentOffset.x - pageWidth - pageWidth / 2) / pageWidth) + 1; // 向下取整
    if(page > 0) {              //向左
        [self changePosition:NO];
        self.pageControl.currentPage = (++self.pageControl.currentPage)%self.imgs.count;
    } else if (page < 0) {      //向右
        
        [self changePosition:YES];
        self.pageControl.currentPage = (--self.pageControl.currentPage+self.pageControl.numberOfPages)%self.imgs.count;
    } else {}                   //不变
    
}

#pragma mark - 循环滚动

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imgs.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZJImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ImageCollectionViewCell forIndexPath:indexPath];
    cell.imgPath = self.imgs[indexPath.row];
    cell.title = [NSString stringWithFormat:@"%zd", indexPath.item];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(kScreenW, kScreenH-64-1);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

//- (void)scrollAnmation {
//    if (self.collectionView.isTracking == NO && self.collectionView.isDragging == NO) {
//        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
//    }
//}
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSInteger count = scrollView.contentOffset.x/kScreenW;
//    self.pageControl.currentPage = count;
//}

@end
