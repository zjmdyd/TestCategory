//
//  ZJPreogressView.m
//  弧形进度条
//
//  Created by clare on 15/12/8.
//  Copyright © 2015年 zhou. All rights reserved.
//

#import "ZJPreogressView.h"

@interface ZJPreogressView ()

@property (nonatomic, assign) CGFloat value;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ZJPreogressView

- (void)drawRect:(CGRect)rect {
    //    仪表盘底部
    [self drawBottomLayer];
    
    //    仪表盘进度
    [self drawFrontLayer];
}

- (void)drawBottomLayer {
    //1.获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //1.1 设置线条的宽度
    CGContextSetLineWidth(ctx, self.lineWidth);
    //1.2 设置线条的起始点样式
    CGContextSetLineCap(ctx,kCGLineCapButt);
    //1.3  虚实切换 ，
    CGFloat length[] = {2, 4};  // 绘制2个点跳过4个点
    CGContextSetLineDash(ctx, 0, length, 2);
    //1.4 设置颜色
    [self.bottomLayerColor set];
    //2.设置路径
    CGContextAddArc(ctx, self.frame.size.width/2 , self.frame.size.width/2, self.radius, -5*M_PI_4, M_PI_4, 0);
    //3.绘制
    CGContextStrokePath(ctx);
}

- (void)drawFrontLayer {
    //1.获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //1.1 设置线条的宽度
    CGContextSetLineWidth(ctx, self.lineWidth);
    //1.2 设置线条的起始点样式
    CGContextSetLineCap(ctx,kCGLineCapButt);
    //1.3  虚实切换 ，
    CGFloat length[] = {2, 4};
    CGContextSetLineDash(ctx, 0, length, 2);
    //1.4 设置颜色
    [self.frontLayerColor set];
    
    CGFloat end = -5*M_PI_4+(6*M_PI_4*self.value/self.maxValue);  // 6*M_PI_4 == 总弧度
    
    CGContextAddArc(ctx, self.frame.size.width/2 , self.frame.size.width/2, self.radius, -5*M_PI_4, end , 0);
    
    //3.绘制
    CGContextStrokePath(ctx);
}

- (void)showContent {
    if (self.originValue - self.value <= FLT_EPSILON) {
        _timer.fireDate = [NSDate distantFuture];
    }else {
        self.value += 1;
    }
    
    _textLabel.text = [NSString stringWithFormat:@"%.0f", self.value];
    [self setNeedsDisplay];
}

- (void)showContentWithAnimate:(BOOL)animated {
    if (animated) {
        if (!_timer) {
            _timer = [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(showContent) userInfo:nil repeats:YES];
        }
    }else {
        self.value = self.originValue;
        _textLabel.text = [NSString stringWithFormat:@"%.0f", self.value];
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        CGSize size = self.frame.size;
        _lineWidth = 12;
        _maxValue = 100;
        _radius = size.width/2-_lineWidth/2;
        _bottomLayerColor = [UIColor groupTableViewBackgroundColor];
        _textColor = _frontLayerColor = [UIColor redColor];
        _titleColor = [UIColor lightGrayColor];
        
        CGFloat height = 80;
        CGFloat width = sqrt(pow(size.width-_lineWidth*2, 2) - pow(height, 2));
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, height)];
        _textLabel.textAlignment  = NSTextAlignmentCenter;
        _textLabel.textColor = _textColor;
        _textLabel.font = [UIFont systemFontOfSize:60];
        _textLabel.center = self.center;
        [self addSubview:_textLabel];
        
        CGFloat r = _radius - _lineWidth;
        width = sqrt(2)*r;
        height = sqrt(pow(r, 2) - pow(width/2, 2));
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _textLabel.center.y+height, width, 21)];
        _titleLabel.center = CGPointMake(size.width/2, _titleLabel.center.y);
        _titleLabel.textColor = _titleColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        
        // _titleLabel.text = @"哈哈哈哈";
        _textLabel.layer.borderWidth = _titleLabel.layer.borderWidth = 1.0;
    }
    return self;
}

#pragma mark - setter

- (void)setOriginValue:(CGFloat)originValue {
    _originValue = originValue;
    
    if (_originValue > self.maxValue) {
        _originValue = self.maxValue;
    }
}

- (void)setText:(NSString *)text {
    _text = text;
    
    self.textLabel.text = _text;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    self.titleLabel.text = _title;
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    
    self.titleLabel.textColor = _titleColor;
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    
    self.textLabel.textColor = _textColor;
}

@end
