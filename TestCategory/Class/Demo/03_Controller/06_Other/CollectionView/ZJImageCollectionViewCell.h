//
//  ZJImageCollectionViewCell.h
//  TestCategory
//
//  Created by ZJ on 12/17/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJImageCollectionViewCell : UICollectionViewCell

@property (nonatomic, copy) NSString *imgPath;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL isAddPinch;

@end
