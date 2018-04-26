//
//  ZJCollectionTableViewCell.m
//  PEPlatform
//
//  Created by ZJ on 12/14/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import "ZJCollectionTableViewCell.h"
#import "ZJViewHeaderFile.h"

@interface ZJCollectionTableViewCell ()<UICollectionViewDataSource, UICollectionViewDelegate, ZJIconTitleNormalCollectionViewCellDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *cellIDs;
@property (nonatomic, copy  ) NSString *cellID;
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *marginConstraints;

@end

#ifndef kScreenW

#define kScreenW    ([UIScreen mainScreen].bounds.size.width)
#define kScreenH    ([UIScreen mainScreen].bounds.size.height)

#endif

@implementation ZJCollectionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    ((UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout).minimumLineSpacing = 10;
    ((UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout).minimumInteritemSpacing = 10;
    [self.collectionView registerNib:[UINib nibWithNibName:self.cellID bundle:nil] forCellWithReuseIdentifier:self.cellID];
}

#pragma mark - setter

- (void)setMinimumLineSpacing:(CGFloat)minimumLineSpacing {
    _minimumLineSpacing = minimumLineSpacing;
    
    ((UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout).minimumLineSpacing = minimumLineSpacing;
}

- (void)setMinimumInteritemSpacing:(CGFloat)minimumInteritemSpacing {
    _minimumInteritemSpacing = minimumInteritemSpacing;
    
    ((UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout).minimumInteritemSpacing = _minimumInteritemSpacing;
}

- (void)setSectionInset:(UIEdgeInsets)sectionInset {
    _sectionInset = sectionInset;
    
    ((UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout).sectionInset = sectionInset;
}

- (void)setScrollDirection:(UICollectionViewScrollDirection)scrollDirection {
    _scrollDirection = scrollDirection;
    
    ((UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout).scrollDirection = _scrollDirection;
}

- (void)setMargin:(CGFloat)margin {
    _margin = margin;
    
    for (NSLayoutConstraint *cst in self.marginConstraints) {
        cst.constant = _margin;
    }
}

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

- (void)setSelectEnabled:(BOOL)selectEnabled {
    _selectEnabled = selectEnabled;
    
    self.collectionView.userInteractionEnabled = _selectEnabled;
}

- (void)setContentBgColor:(UIColor *)contentBgColor {
    _contentBgColor = contentBgColor;

    self.collectionView.backgroundColor = _contentBgColor;
}

- (void)reload {
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInCollectionTableViewCell:)]) {
        return [self.dataSource numberOfSectionsInCollectionTableViewCell:self];
    }
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([self.dataSource respondsToSelector:@selector(collectionTableViewCell:numberOfItemsInSection:)]) {
        return [self.dataSource collectionTableViewCell:self numberOfItemsInSection:section];
    }
    
    return 0;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZJIconTitleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellID forIndexPath:indexPath];
    
    if ([self.dataSource respondsToSelector:@selector(collectionTableViewCell:titleAtIndexPath:)]) {
        cell.text = [self.dataSource collectionTableViewCell:self titleAtIndexPath:indexPath];
    }else if (self.titles.count) {
        cell.text = self.titles[indexPath.row];
    }
    if ([self.dataSource respondsToSelector:@selector(collectionTableViewCell:titleColorAtIndexPath:)]) {
        cell.textColor = [self.dataSource collectionTableViewCell:self titleColorAtIndexPath:indexPath];
    }
    
    if ([self.dataSource respondsToSelector:@selector(collectionTableViewCell:iconPathAtIndexPath:)]) {
        cell.iconPath = [self.dataSource collectionTableViewCell:self iconPathAtIndexPath:indexPath];
    }else if (self.iconPaths.count) {
        cell.iconPath = self.iconPaths[indexPath.row];
    }
    if (self.iconPlaceholder) {
        cell.iconPlaceholder = self.iconPlaceholder;
    }
    if ([self.dataSource respondsToSelector:@selector(collectionTableViewCell:backgroundColorAtIndexPath:)]) {
        cell.backgroundColor = [self.dataSource collectionTableViewCell:self backgroundColorAtIndexPath:indexPath];
    }
    
    if ([cell isKindOfClass:[ZJIconTitleNormalCollectionViewCell class]]) {
        if ([self.dataSource respondsToSelector:@selector(collectionTableViewCell:canEditAtIndexPath:)]) {
            ((ZJIconTitleNormalCollectionViewCell *)cell).delegate = self;
            ((ZJIconTitleNormalCollectionViewCell *)cell).indexPath = indexPath;
            ((ZJIconTitleNormalCollectionViewCell *)cell).textPlaceholder = self.textPlaceholder;
            ((ZJIconTitleNormalCollectionViewCell *)cell).enableEdit = [self.dataSource collectionTableViewCell:self canEditAtIndexPath:indexPath];
        }else {
            ((ZJIconTitleNormalCollectionViewCell *)cell).enableEdit = NO;
        }
    }
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    if ([self.delegate respondsToSelector:@selector(collectionTableViewCell:didSelectItemAtIndexPath:)]) {
        [self.delegate collectionTableViewCell:self didSelectItemAtIndexPath:indexPath];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.itemSize;
}

#pragma mark - getter

- (NSArray *)cellIDs {
    if (!_cellIDs) {
        _cellIDs = @[IconTitleNormalCollectionViewCell, IconTitleVerticalCollectionCell, IconTitleHorizontalCollectionCell];
    }
    
    return _cellIDs;
}

- (NSString *)cellID {
    if (!_cellID) {
        _cellID = self.cellIDs[self.cellType];
    }
    
    return _cellID;
}

#pragma mark - ZJIconTitleNormalCollectionViewCell

- (void)iconTitleNormalCollectionViewCell:(ZJIconTitleNormalCollectionViewCell *)cell didEndEditWithText:(NSString *)text {
    if ([self.delegate respondsToSelector:@selector(collectionTableViewCell:didEndEditWithText:indexPath:)]) {
        [self.delegate collectionTableViewCell:self didEndEditWithText:text indexPath:cell.indexPath];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
