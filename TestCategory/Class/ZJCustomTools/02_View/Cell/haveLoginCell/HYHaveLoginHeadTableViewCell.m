//
//  HYHaveLoginHeadTableViewCell.m
//  ButlerSugar
//
//  Created by ZJ on 2/25/16.
//  Copyright © 2016 csj. All rights reserved.
//

#import "HYHaveLoginHeadTableViewCell.h"

@interface HYHaveLoginHeadTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headIconIV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *sexBtn;

@end

@implementation HYHaveLoginHeadTableViewCell

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.needCornerRadius) {
        [self performSelector:@selector(resetFrame) withObject:nil afterDelay:0.1];
    }
}

- (void)setInfoDic:(NSDictionary *)infoDic {
    _infoDic = infoDic;
    if (!_infoDic) return;
    
    self.nameLabel.text = _infoDic[@"title"];
    self.subTitleLabel.text = [NSString stringWithFormat:@"账号: %@", _infoDic[@"doctorName"]?:@""];
//    [self.headIconIV sd_setImageWithURL:[NSURL URLWithString:_infoDic[@"smallPic"]] placeholderImage:[UIImage imageNamed:@"ic_yisheng_106x106"] options:SDWebImageRefreshCached];
    
    self.sexBtn.hidden = NO;
    NSArray *imgs = @[@"ic_man_whtie_36x36", @"ic_woman_whtie_36x36"];
    NSInteger sex = [_infoDic[@"sex"] integerValue];
    if (sex < 1 || sex > 2) sex = 1;
    [self.sexBtn setImage:[UIImage imageNamed:imgs[sex-1]] forState:UIControlStateNormal];
//    NSInteger age = [NSDate dateWithTimeIntervalSince1970:[_infoDic[@"birth"] doubleValue]/1000].age;
//    [self.sexBtn setTitle:[NSString stringWithFormat:@"%zd岁", age] forState:UIControlStateNormal];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)resetFrame {
    self.headIconIV.layer.cornerRadius = self.headIconIV.frame.size.width / 2;
    self.headIconIV.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
