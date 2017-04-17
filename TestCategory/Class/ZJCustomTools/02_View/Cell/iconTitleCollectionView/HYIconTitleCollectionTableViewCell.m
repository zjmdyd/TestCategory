//
//  HYIconTitleCollectionTableViewCell.m
//  PEPlatform
//
//  Created by ZJ on 12/14/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import "HYIconTitleCollectionTableViewCell.h"
#import "HYIconTitleVerticalCollectionViewCell.h"

@interface HYIconTitleCollectionTableViewCell ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, assign) NSUInteger itemCount;

@end

static NSString *IconTitleCollectionViewCell = @"HYIconTitleVerticalCollectionViewCell";

#ifndef kScreenW

#define kScreenW    ([UIScreen mainScreen].bounds.size.width)
#define kScreenH    ([UIScreen mainScreen].bounds.size.height)

#endif

@implementation HYIconTitleCollectionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.collectionView registerNib:[UINib nibWithNibName:IconTitleCollectionViewCell bundle:nil] forCellWithReuseIdentifier:IconTitleCollectionViewCell];
}

- (void)setTitles:(NSArray<NSString *> *)titles {
    _titles = titles;
    
    [self.collectionView reloadData];
}

- (void)seticonPaths:(NSArray<NSString *> *)iconPaths {
    _iconPaths = iconPaths;
    
    [self.collectionView reloadData];
}

- (void)setScrollEnabled:(BOOL)scrollEnabled {
    _scrollEnabled = scrollEnabled;
    
    self.collectionView.scrollEnabled = _scrollEnabled;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.itemCount;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HYIconTitleVerticalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:IconTitleCollectionViewCell forIndexPath:indexPath];
    cell.title = self.titles[indexPath.row];
    cell.iconPath = self.iconPaths[indexPath.row];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(iconTitleCollectionTableViewCell:didSelectAtIndexPath:)]) {
        [self.delegate iconTitleCollectionTableViewCell:self didSelectAtIndexPath:indexPath];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = kScreenW/self.itemCount-1;
    
    return CGSizeMake(width, width);
}

- (NSUInteger)itemCount {
    _itemCount = self.titles.count;
    
    if (_itemCount <= 0) {
        _itemCount = 1;
    }
    
    return _itemCount;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
