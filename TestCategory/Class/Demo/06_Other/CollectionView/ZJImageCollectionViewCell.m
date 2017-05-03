//
//  ZJImageCollectionViewCell.m
//  TestCategory
//
//  Created by ZJ on 12/17/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import "ZJImageCollectionViewCell.h"

@interface ZJImageCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ZJImageCollectionViewCell

- (void)setImgPath:(NSString *)imgPath {
    _imgPath = imgPath;
    
    self.imageView.image = [UIImage imageNamed:_imgPath];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    self.label.text = _title;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    NSLog(@"%s", __func__);
}

@end
