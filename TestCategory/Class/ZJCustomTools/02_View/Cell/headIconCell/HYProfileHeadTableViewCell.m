//
//  HYProfileHeadTableViewCell.m
//  ButlerSugar
//
//  Created by ZJ on 2/26/16.
//  Copyright © 2016 csj. All rights reserved.
//

#import "HYProfileHeadTableViewCell.h"

@interface HYProfileHeadTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headIV;

@end

@implementation HYProfileHeadTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    
    self.headIV.layer.cornerRadius = 55/2;
    self.headIV.layer.masksToBounds = YES;
}

- (void)setHeadPath:(NSString *)headPath {
    _headPath = headPath;
    
    if ([self.headPath hasPrefix:@"http"]) {
//        [self.headIV sd_setImageWithURL:[NSURL URLWithString:self.headPath] placeholderImage:[UIImage imageNamed:@"ic_yisheng_106x106"]];
    }else {
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:self.headPath];
        if (image) {
            self.headIV.image = image;
        }else {
            self.headIV.image = [UIImage imageNamed:@"ic_yisheng_106x106"];
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
