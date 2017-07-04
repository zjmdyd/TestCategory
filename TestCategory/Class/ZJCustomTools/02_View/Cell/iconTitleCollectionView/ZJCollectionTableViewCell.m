//
//  ZJCollectionTableViewCell.m
//  PEPlatform
//
//  Created by ZJ on 12/14/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import "ZJCollectionTableViewCell.h"
#import "ZJViewHeaderFile.h"

@interface ZJCollectionTableViewCell ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *cellIDs;
@property (nonatomic, copy  ) NSString *cellID;

@end

#ifndef kScreenW

#define kScreenW    ([UIScreen mainScreen].bounds.size.width)
#define kScreenH    ([UIScreen mainScreen].bounds.size.height)

#endif

@implementation ZJCollectionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.collectionView registerNib:[UINib nibWithNibName:self.cellID bundle:nil] forCellWithReuseIdentifier:self.cellID];
}

#pragma mark - setter

- (void)setTitles:(NSArray<NSString *> *)titles {
    _titles = titles;
    
    [self.collectionView reloadData];
}

- (void)setIconPaths:(NSArray<NSString *> *)iconPaths {
    _iconPaths = iconPaths;
    
    [self.collectionView reloadData];
}

- (void)setScrollEnabled:(BOOL)scrollEnabled {
    _scrollEnabled = scrollEnabled;
    
    self.collectionView.scrollEnabled = _scrollEnabled;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titles.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZJIconTitleNormalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellID forIndexPath:indexPath];
    cell.text = self.titles[indexPath.row];
    cell.iconPath = self.iconPaths[indexPath.row];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(collectionTableViewCell:didSelectItemAtIndexPath:)]) {
        [self.delegate collectionTableViewCell:self didSelectItemAtIndexPath:indexPath];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (!CGSizeEqualToSize(self.itemSize, CGSizeZero)) return self.itemSize;
    
    CGFloat width = kScreenW/self.numberItemOfColum-1;
    
    return CGSizeMake(width, width);
}

- (NSArray *)cellIDs {
    if (!_cellIDs) {
        _cellIDs = @[IconTitleCollectionViewCell, IconTitleHorizontalCollectionCell, IconTitleVerticalCollectionCell];
    }
    
    return _cellIDs;
}

- (NSString *)cellID {
    if (!_cellIDs) {
        _cellID = self.cellIDs[self.cellType];
    }
    
    return _cellID;
}

- (NSInteger)numberItemOfColum {
    if (_numberItemOfColum == 0) {
        _numberItemOfColum = 1;
    }
    
    return _numberItemOfColum;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
