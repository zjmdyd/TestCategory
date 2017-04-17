//
//  HYSexTableViewCell.m
//  XAHealthDoctor
//
//  Created by ZJ on 1/9/17.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import "HYSexTableViewCell.h"

@interface HYSexTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *sexIV;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;

@end

@implementation HYSexTableViewCell

- (void)setSexIndex:(NSInteger)sexIndex {
    if (sexIndex < 1 || sexIndex > 2) sexIndex = 1;
    _sexIndex = sexIndex;
    
    NSArray *sexImgs = @[@"ic_man_72x72", @"ic_woman_72x72"];
    self.sexIV.image = [UIImage imageNamed:sexImgs[_sexIndex-1]];
}

- (void)awakeFromNib {
    [super awakeFromNib];
//    self.sexLabel.textColor = [UIColor sysTableViewDetailTextColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
