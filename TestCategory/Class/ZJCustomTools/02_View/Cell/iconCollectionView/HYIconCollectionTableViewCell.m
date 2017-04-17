//
//  HYIconCollectionTableViewCell.m
//  PEPlatform
//
//  Created by ZJ on 12/14/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import "HYIconCollectionTableViewCell.h"
#import "HYIocnCollectionViewCell.h"

@interface HYIconCollectionTableViewCell ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleTopConstraint;
@property (weak, nonatomic) IBOutlet UILabel *topTitleLabel;

@end

#define LineSpacing 8
#define MarginSpacing 10
#define ColumItemCount 4

#ifndef kScreenW

#define kScreenW    ([UIScreen mainScreen].bounds.size.width)
#define kScreenH    ([UIScreen mainScreen].bounds.size.height)

#endif

static NSString *IocnCollectionViewCell = @"HYIocnCollectionViewCell";

@implementation HYIconCollectionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.collectionView registerNib:[UINib nibWithNibName:IocnCollectionViewCell bundle:nil] forCellWithReuseIdentifier:IocnCollectionViewCell];
    ((UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout).minimumLineSpacing = LineSpacing;
    
    self.titleHeightConstraint.constant = self.titleTopConstraint.constant = 0.0;
}

- (void)setTopTitle:(NSString *)topTitle {
    _topTitle = topTitle;
    self.topTitleLabel.text = _topTitle;
    
    if (_topTitle.length) {
        self.titleHeightConstraint .constant = 30.0;
        self.titleTopConstraint.constant = 8.0;
    }else {
        self.titleHeightConstraint.constant = self.titleTopConstraint.constant = 0.0;
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

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.iconPaths.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HYIocnCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:IocnCollectionViewCell forIndexPath:indexPath];
    cell.title = self.titles[indexPath.row];
    cell.iconPath = self.iconPaths[indexPath.row];
    cell.titleColor = [UIColor whiteColor];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(iconCollectionTableViewCell:didSelectAtIndexPath:)]) {
        [self.delegate iconCollectionTableViewCell:self didSelectAtIndexPath:indexPath];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (kScreenW - MarginSpacing*2 - LineSpacing*(ColumItemCount-1)) / ColumItemCount;
    
    return CGSizeMake(width, width);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
