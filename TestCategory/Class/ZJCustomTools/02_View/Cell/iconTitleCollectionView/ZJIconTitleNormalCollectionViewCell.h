//
//  ZJIconTitleNormalCollectionViewCell.h
//  PEPlatform
//
//  Created by ZJ on 12/14/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import "ZJIconTitleCollectionViewCell.h"

@class ZJIconTitleNormalCollectionViewCell;

@protocol ZJIconTitleNormalCollectionViewCellDelegate <NSObject>

- (void)iconTitleNormalCollectionViewCell:(ZJIconTitleNormalCollectionViewCell *)cell didEndEditWithText:(NSString *)text;

@end

@interface ZJIconTitleNormalCollectionViewCell : ZJIconTitleCollectionViewCell

@property (nonatomic, assign) BOOL enableEdit;
@property (nonatomic, copy) NSString *textPlaceholder;

@property (nonatomic, weak) id<ZJIconTitleNormalCollectionViewCellDelegate> delegate;

@end
