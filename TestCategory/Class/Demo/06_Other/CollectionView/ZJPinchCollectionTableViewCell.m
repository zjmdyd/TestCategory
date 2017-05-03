//
//  ZJPinchCollectionTableViewCell.m
//  TestCategory
//
//  Created by ZJ on 12/28/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import "ZJPinchCollectionTableViewCell.h"
#import "ZJImageCollectionViewCell.h"
#import "UIViewExt.h"
#import "ZJFondationCategory.h"

@interface ZJPinchCollectionTableViewCell ()<UIScrollViewDelegate> {
    BOOL _isEnlarge;
    NSMutableArray *_transfroms, *_enlarges, *_scales;
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

#define kScreenW    ([UIScreen mainScreen].bounds.size.width)
#define kScreenH    ([UIScreen mainScreen].bounds.size.height)
static NSString *ImageCollectionViewCell = @"ZJImageCollectionViewCell";

@implementation ZJPinchCollectionTableViewCell

- (void)pinch:(UIPinchGestureRecognizer *)sender {
    CGFloat scale = sender.scale;
    CGAffineTransform trans = CGAffineTransformMakeScale(scale, scale);
    sender.view.transform = trans;
    //CGAffineTransformScale(sender.view.transform, scale, scale); //在已缩放大小基础下进行累加变化；区别于：使用 CGAffineTransformMakeScale 方法就是在原大小基础下进行变化
    
    NSLog(@"state = %zd, scale = %.2f", sender.state, scale);
    NSLog(@"size = %@", NSStringFromCGSize(sender.view.size));
    
    if (scale < 1) {
        _isEnlarge = NO;
        [_enlarges replaceObjectAtIndex:sender.view.tag withObject:@(NO)];
        [_scales replaceObjectAtIndex:sender.view.tag withObject:@(1.0)];
    }else if (scale > 1) {
        _isEnlarge = YES;
        [_enlarges replaceObjectAtIndex:sender.view.tag withObject:@(YES)];
        [_scales replaceObjectAtIndex:sender.view.tag withObject:@(scale)];
    }
    
    if (_isEnlarge == NO && sender.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.25 animations:^{
            sender.view.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [_transfroms replaceObjectAtIndex:sender.view.tag withObject:[NSValue valueWithCGAffineTransform:sender.view.transform]];
        }];
    }else {
        [_transfroms replaceObjectAtIndex:sender.view.tag withObject:[NSValue valueWithCGAffineTransform:sender.view.transform]];
    }
    if (sender.state == UIGestureRecognizerStateEnded) {
        [self.collectionView reloadData];
    }
//    sender.scale = 1.0;
    NSLog(@"transform = %@", NSStringFromCGAffineTransform(sender.view.transform));
}

- (void)pan:(UIPanGestureRecognizer *)pan {
    CGPoint point = [pan translationInView:pan.view.superview];
    pan.view.center = CGPointMake(pan.view.center.x + point.x, pan.view.center.y + point.y);
    [pan setTranslation:CGPointMake(0, 0) inView:pan.view.superview];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.objs.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZJImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ImageCollectionViewCell forIndexPath:indexPath];
    cell.imgPath = self.objs[indexPath.row];
    cell.title = [NSString stringWithFormat:@"%zd", indexPath.item];
    cell.contentView.tag = indexPath.row;
    
    NSLog(@"indexPath.row = %zd, %zd", indexPath.row, cell.isAddPinch);
    
    if (!cell.isAddPinch) {
        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
        [cell.contentView addGestureRecognizer:pinch];
        cell.isAddPinch = YES;
        
//        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
//        [cell.contentView addGestureRecognizer:pan];
//        cell.contentView.layer.borderWidth = 2.0;
//        cell.contentView.layer.borderColor = [UIColor redColor].CGColor;
    }
    
//    for (UIGestureRecognizer *ges in cell.contentView.gestureRecognizers) {
//        if ([ges isKindOfClass:[UIPanGestureRecognizer class]]) {
//            NSNumber *bl = _enlarges[indexPath.row];
//            ges.enabled = bl.boolValue;
//            break;
//        }
//    }
    
    cell.layer.borderWidth = 2.0;
    
//    cell.contentView.transform = [_transfroms[indexPath.row] CGAffineTransformValue];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    NSNumber *bl = _enlarges[indexPath.row];
    collectionView.pagingEnabled = !bl.boolValue;
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    cell.contentView.transform = CGAffineTransformIdentity;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat scale = [_scales[indexPath.row] floatValue];
    return CGSizeMake(kScreenW*scale, kScreenH-64-1);
}

- (void)setObjs:(NSArray *)objs {
    _objs = objs;
    
    for (int i = 0; i < _objs.count; i++) {
        [_transfroms addObject:[NSValue valueWithCGAffineTransform:CGAffineTransformIdentity]];
        [_enlarges addObject:@(NO)];
        [_scales addObject:@(1.0)];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _scales = [NSMutableArray array];
    _enlarges = [NSMutableArray array];
    _transfroms = [NSMutableArray array];
    self.collectionView.pagingEnabled = YES;
    [self.collectionView registerNib:[UINib nibWithNibName:ImageCollectionViewCell bundle:nil] forCellWithReuseIdentifier:ImageCollectionViewCell];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"contentOffset = %@", NSStringFromCGPoint(scrollView.contentOffset));
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
