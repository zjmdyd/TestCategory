//
//  ZJIconTitleCollectionViewCell.h
//  TestCategory
//
//  Created by ZJ on 03/07/2017.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJIconTitleCollectionViewCell : UICollectionViewCell

@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic, copy) NSString *attrText;
@property (nonatomic, copy) NSString *iconPath;
@property (nonatomic, copy) NSString *placeholder;

@end
