//
//  ZJProgressView.m
//  弧形进度条
//
//  Created by clare on 15/12/8.
//  Copyright © 2015年 zhou. All rights reserved.
//

#import "ZJProgressView.h"

@interface NSString (ZJProgressString)

- (BOOL)isPureInt;
- (BOOL)isPureFloat;

@end

@implementation NSString (ZJProgressString)

// 1. 整形判断
- (BOOL)isPureInt {
    NSScanner* scan = [NSScanner scannerWithString:self];
    NSInteger val;
    return [scan scanInteger:&val] && [scan isAtEnd];
}

// 2.浮点形判断：
- (BOOL)isPureFloat {
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

@end

@interface ZJProgressView ()

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UILabel *unitLabel;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *headLabel;
@property (nonatomic, strong) UILabel *tailLabel;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) BOOL isDigit;

@property (nonatomic, assign) CGFloat ratio;

@end

#ifndef kScreenW

#define kScreenW    ([UIScreen mainScreen].bounds.size.width)
#define kScreenH    ([UIScreen mainScreen].bounds.size.height)

#endif

@implementation ZJProgressView

- (void)drawRect:(CGRect)rect {
    //    仪表盘底部
    [self drawLayerWithColor:self.bottomLayerColor endAngle:M_PI_4];
    
    //    仪表盘进度
    CGFloat end = -5*M_PI_4+(6*M_PI_4*self.ratio);  // 6*M_PI_4 == 总弧度
    [self drawLayerWithColor:self.frontLayerColor endAngle:end];
}

- (void)drawLayerWithColor:(UIColor *)color endAngle:(CGFloat)endAngle {
    //1.获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //1.1 设置线条的宽度
    CGContextSetLineWidth(ctx, self.lineWidth);
    //1.2 设置线条的起始点样式
    CGContextSetLineCap(ctx, kCGLineCapButt);
    //1.3  虚实切换 ，
    CGFloat length[] = {2, 4};  // 绘制2个点跳过4个点
    CGContextSetLineDash(ctx, 0, length, 2);
    //1.4 设置颜色
    [color set];
    //2.设置路径
    CGContextAddArc(ctx, self.frame.size.width/2 , self.frame.size.width/2, self.radius, -5*M_PI_4, endAngle, 0);
    //3.绘制
    CGContextStrokePath(ctx);
}

- (void)showContent {
    static CGFloat i = 0.0;
    if (i < self.text.floatValue) {
        NSLog(@"递增i = %.0f", i);
        i = i + self.valueDash;
        self.textLabel.text = [NSString stringWithFormat:@"%.0f", i];
        
        CGFloat times = _text.floatValue / self.valueDash;  // 次数
        CGFloat span = self.valueRatio / times;             // 增长因子
        self.ratio = span*i;
    }else {
        self.textLabel.text = self.text;
        self.ratio = self.valueRatio;
        self.timer.fireDate = [NSDate distantFuture];
    }
    [self setNeedsDisplay];
}

- (void)showContent:(NSString *)content withAnimate:(BOOL)animated {
    _text = content;
    
    if (self.isDigit && animated) {
        if (!_timer) {
            _timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(showContent) userInfo:nil repeats:YES];
        }else {
            _timer.fireDate = [NSDate distantPast];
        }
    }else {
        self.textLabel.text = _text;
        self.ratio = self.valueRatio;
        [self setNeedsDisplay];
    }
}

#pragma mark - initsSetting

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self initSetting];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSetting];
    }
    return self;
}

- (void)initSetting {
    self.backgroundColor = [UIColor whiteColor];
    
    CGSize size = self.frame.size;
    _lineWidth = 12;
    _radius = size.width/2-_lineWidth/2;
    _valueDash = 1.0;
    
    _bottomLayerColor = [UIColor groupTableViewBackgroundColor];
    
    _textColor = _unitColor = _frontLayerColor = [UIColor redColor];
    _titleColor = [UIColor lightGrayColor];
    
    CGFloat height = 42;
    CGFloat width = sqrt(pow(size.width-_lineWidth*2, 2) - pow(height, 2));
    _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    _textLabel.textAlignment  = NSTextAlignmentCenter;
    _textLabel.textColor = _textColor;
    _textLabel.font = [UIFont systemFontOfSize:36];
    _textLabel.center = CGPointMake(size.width/2, size.height/2);
    [self addSubview:_textLabel];
    
    CGFloat bottom = _textLabel.frame.size.height + _textLabel.frame.origin.y;
    _unitLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, bottom, _textLabel.frame.size.width-15, 20)];
    _unitLabel.textAlignment  = NSTextAlignmentCenter;
    _unitLabel.textColor = _textColor;
    _unitLabel.font = [UIFont systemFontOfSize:15];
    _unitLabel.center = CGPointMake(size.width/2, _unitLabel.center.y);
    [self addSubview:_unitLabel];
//    _unitLabel.layer.borderWidth = _textLabel.layer.borderWidth = 1.0;
    
    CGFloat r = _radius - _lineWidth;
    width = sqrt(2)*r;
    height = sqrt(pow(r, 2) - pow(width/2, 2));
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _textLabel.center.y+height, width, 21)];
    _titleLabel.center = CGPointMake(size.width/2, _titleLabel.center.y);
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.textColor = _titleColor;
    _titleLabel.textAlignment = NSTextAlignmentCenter;

    [self addSubview:_titleLabel];
}

#pragma mark - setter

- (void)setText:(NSString *)text {
    _text = text;
    
    self.textLabel.text = _text;
    self.ratio = self.valueRatio;
    [self setNeedsDisplay];
}

- (void)setAttributeText:(NSAttributedString *)attributeText {
    _attributeText = attributeText;
    
    self.textLabel.attributedText = _attributeText;
    self.ratio = self.valueRatio;
}

- (void)setUnit:(NSString *)unit {
    _unit = unit;
    
    self.unitLabel.text = _unit;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    self.titleLabel.text = _title;
}

- (void)setValueRatio:(CGFloat)valueRatio {
    if (valueRatio > 1) {
        valueRatio = 1;
    }else if (valueRatio < 0) {
        valueRatio = 0;
    }
    
    _valueRatio = valueRatio;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    _textAlignment = textAlignment;
    
    self.textLabel.textAlignment = _textAlignment;
}

#pragma mark - color

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    
    self.textLabel.textColor = _textColor;
}

- (void)setUnitColor:(UIColor *)unitColor {
    _unitColor = unitColor;
    
    self.unitLabel.textColor = _unitColor;
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    
    self.titleLabel.textColor = _titleColor;
}

- (void)setBottomLayerColor:(UIColor *)bottomLayerColor {
    _bottomLayerColor = bottomLayerColor;
    
    [self setNeedsDisplay];
}

- (void)setFrontLayerColor:(UIColor *)frontLayerColor {
    _frontLayerColor = frontLayerColor;
    
    [self setNeedsDisplay];
}

- (void)setNeedTailLabel:(BOOL)needTailLabel {
    _needTailLabel = needTailLabel;
    
    self.headLabel.hidden = self.tailLabel.hidden = !_needTailLabel;//
}

- (void)setHeadValue:(NSString *)headValue {
    _headValue = headValue;
    
    self.headLabel.text = _headValue;
}

- (void)setTailValue:(NSString *)tailValue {
    _tailValue = tailValue;
    
    self.tailLabel.text = _tailValue;
}

/**
 头尾Label
 */
- (UILabel *)headLabel {
    if (!_headLabel) {
        CGSize size = self.frame.size;

        CGFloat width = (size.width-2*self.lineWidth)/2*sqrt(2)/2;
        _headLabel = [[UILabel alloc] initWithFrame:CGRectMake(size.width/2-width, self.center.y+width/sqrt(2), width, 20)];
        _headLabel.hidden = YES;
        _headLabel.font = [UIFont systemFontOfSize:15];
        _headLabel.textColor = [UIColor whiteColor];
        [self addSubview:_headLabel];
    }
    
    return _headLabel;
}

- (UILabel *)tailLabel {
    if (!_tailLabel) {
        CGSize size = self.frame.size;

        _tailLabel = [[UILabel alloc] initWithFrame:CGRectMake(size.width/2+3, _headLabel.frame.origin.y, _headLabel.frame.size.width, _headLabel.frame.size.height)];
        _tailLabel.font = [UIFont systemFontOfSize:15];
        _tailLabel.textColor = _headLabel.textColor;
        _tailLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_tailLabel];
    }
    
    return _tailLabel;
}

#pragma mark - getter

- (BOOL)isDigit {
    return [self.text isPureInt] || [self.text isPureFloat];
}

@end
