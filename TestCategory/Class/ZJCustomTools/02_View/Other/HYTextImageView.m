//
//  HYTextImageView.m
//  PEPlatform
//
//  Created by ZJ on 11/12/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import "HYTextImageView.h"

@interface HYTextImageView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) CGFloat textRatio;

@end

@implementation HYTextImageView


- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {

    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)image textRatio:(CGFloat)ratio {
    self = [super initWithFrame:frame];
    if (self) {
        _leftMargin = 6;
        _titleLeftMargin = 4;
        _textRatio = ratio;
        if (_textRatio < 0 || _textRatio > 1) {
            _textRatio = 0.5;
        }
        
        self.title = title;

        if (image) {
            self.imageView.image = image;
        }
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title imgName:(NSString *)imgName textRatio:(CGFloat)ratio {
    self = [super initWithFrame:frame];
    if (self) {
        _leftMargin = 6;
        _titleLeftMargin = 4;
        _textRatio = ratio;
        if (_textRatio < 0 || _textRatio > 1) {
            _textRatio = 0.5;
        }
        
        self.title = title;
        if (imgName) {
            self.imageName = imgName;
        }
    }
    
    return self;
}

#pragma mark - setter

- (void)setTitle:(NSString *)title {
    _title = title;
    
    self.titleLabel.text = _title;
//    [self.titleLabel fitFontWithPointSize:14 width:self.titleLabel.width height:21 descend:YES];
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    
    self.titleLabel.textColor = _titleColor;
}

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    
    if ([_imageName hasPrefix:@"http"]) {
//        [self.imageView sd_setImageWithURL:[NSURL URLWithString:_imageName] placeholderImage:[UIImage imageNamed:@"ic_yisheng_106x106"]];
    }else {
        UIImage *image = [UIImage imageNamed:_imageName];
        if (image) {
            self.imageView.image = image;
        }else {
            self.imageView.image = [UIImage imageNamed:@"ic_yisheng_106x106"];
        }
    }
}

- (void)setTransform:(CGAffineTransform)transform {
    self.imageView.transform = transform;
}

- (void)setNeedIVRound:(BOOL)needIVRound {
    _needIVRound = needIVRound;
    
    self.imageView.layer.cornerRadius = _needIVRound ? self.imageView.width/2 : 0;
}

- (void)setLeftMargin:(CGFloat)leftMargin {
    _leftMargin = leftMargin;
    
    CGRect frame = self.imageView.frame;
    frame.origin.x = _leftMargin;
    self.imageView.frame = frame;
}

- (void)setTitleLeftMargin:(CGFloat)titleLeftMargin {
    _titleLeftMargin = titleLeftMargin;
    
    CGRect frame = self.titleLabel.frame;
    frame.origin.x = self.imageView.right + _titleLeftMargin;
    self.titleLabel.frame = frame;
}

#pragma mark - getter

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.imageView.right+self.titleLeftMargin, 0, self.width*self.textRatio, self.height)];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.center = CGPointMake(_titleLabel.center.x, self.height/2);

        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.leftMargin, 0, self.width*(1-self.textRatio), self.width*(1-self.textRatio))];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.center = CGPointMake(_imageView.center.x, self.height/2);
        _imageView.clipsToBounds = YES;
        [self addSubview:_imageView];
    }
    return _imageView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
 [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -image.size.width, 0, image.size.width)];
 [button setImageEdgeInsets:UIEdgeInsetsMake(0, button.titleLabel.bounds.size.width, 0, -button.titleLabel.bounds.size.width)];
 
*/

@end
