//
//  HYIconSubTitleHorizontalCollectionViewCell.h
//  XAHealthDoctor
//
//  Created by ZJ on 1/3/17.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYIconSubTitleHorizontalCollectionViewCell : UICollectionViewCell

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, copy) NSString *iconPath;

@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *subTitleColor;

@end
