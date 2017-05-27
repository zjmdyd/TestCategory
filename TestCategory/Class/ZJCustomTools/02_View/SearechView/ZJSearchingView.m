//
//  ZJSearchingView.m
//  Test
//
//  Created by ZJ on 1/19/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import "ZJSearchingView.h"
#import "ZJSearchingContentsLayer.h"

@interface ZJSearchingView ()

@property (nonatomic, strong) UIBezierPath *layerPath;
@property (nonatomic, strong) CAShapeLayer *frontLineLayer;
@property (nonatomic, strong) CAShapeLayer *bottomLineLayer;
@property (nonatomic, strong) ZJSearchingContentsLayer *bottomContentLayer;

@end

@implementation ZJSearchingView

@synthesize frontLineColor = _frontLineColor;
@synthesize font = _font;
@synthesize fontSize = _fontSize;
@synthesize bottomLineColor = _bottomLineColor;
@synthesize angleSpan = _angleSpan;

- (nullable instancetype)initWithFrame:(CGRect)frame content:(nullable id)content {
    self = [super initWithFrame:frame];
    if (self) {
        _contents = content;
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

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self initSetting];
    }
    return self;
}

- (void)initSetting {
    // 默认顺时针
    _clockwise = YES;
    _angleSpan = M_PI*0.75;
    _lineWidth = 1.0;
    _duration = 1.0;
}

#pragma mark - setter

- (void)setLineWidth:(CGFloat)lineWidth {
    _lineWidth = lineWidth;
    self.bottomLineLayer.lineWidth = _lineWidth;
    self.frontLineLayer.lineWidth = _lineWidth;
    
    // 需要重绘界面, 因为lineWidth改变, path的radius会改变
    [self setNeedsDisplay];
}

- (void)setFrontLineColor:(UIColor *)lineColor {
    _frontLineColor = lineColor;
    
    self.frontLineLayer.strokeColor = _frontLineColor.CGColor;
}

- (void)setBottomLineColor:(UIColor *)bottomLineColor {
    _bottomLineColor = bottomLineColor;
    
    self.bottomLineLayer.strokeColor = _bottomLineColor.CGColor;
}

- (void)setHiddenFrontLineLayer:(BOOL)hiddenFrontLineLayer {
    _hiddenFrontLineLayer = hiddenFrontLineLayer;
    
    self.frontLineLayer.hidden = _hiddenFrontLineLayer;
}

- (void)setHiddenBottomLineLayer:(BOOL)hiddenBottomLineLayer {
    _hiddenBottomLineLayer = hiddenBottomLineLayer;
    
    self.bottomLineLayer.hidden = _hiddenBottomLineLayer;
}

- (void)setSearching:(BOOL)searching {
    if (searching) {
        [self startAnimation];
    }else {
        [self stopAnimation];
    }
}

- (void)setClockwise:(BOOL)clockwise {
    _clockwise = clockwise;
    
    [self setNeedsDisplay];
    [self updateLayer];
}

- (void)setDuration:(CGFloat)duration {
    _duration = duration;
    
    [self updateLayer];
}

- (void)setAngleSpan:(CGFloat)angleSpan {
    _angleSpan = angleSpan;
    
    [self setNeedsDisplay];
}

#pragma mark - getter

- (CAShapeLayer *)bottomLineLayer {
    if (!_bottomLineLayer) {
        // 旋转layer底部的lineLayer
        _bottomLineLayer = [CAShapeLayer layer];
        _bottomLineLayer.frame = self.layer.bounds;  // 设置frame,不能设置bounds,设置bounds位置会不正确
        _bottomLineLayer.backgroundColor = [UIColor clearColor].CGColor;
        _bottomLineLayer.fillColor = nil;
        _bottomLineLayer.strokeColor = self.bottomLineColor.CGColor;
        [self.layer addSublayer:_bottomLineLayer];
    }
    return _bottomLineLayer;
}

- (CAShapeLayer *)frontLineLayer {
    if (!_frontLineLayer) {
        // 旋转layer
        _frontLineLayer = [CAShapeLayer layer];
        _frontLineLayer.frame = self.layer.bounds;  // 设置frame,不能设置bounds,设置bounds位置会不正确
        _frontLineLayer.backgroundColor = [UIColor clearColor].CGColor;
        _frontLineLayer.fillColor = nil;
        _frontLineLayer.strokeColor = self.frontLineColor.CGColor;
        [self.layer addSublayer:_frontLineLayer];
    }
    
    return _frontLineLayer;
}

- (UIColor *)bottomLineColor {
    if (!_bottomLineColor) {
        _bottomLineColor = [UIColor groupTableViewBackgroundColor];
    }
    
    return _bottomLineColor;
}

- (UIColor *)frontLineColor {
    if (!_frontLineColor) {
        _frontLineColor = [UIColor redColor];
    }
    
    return _frontLineColor;
}

- (CGFloat)angleSpan {
    if (self.isClosewise) {
        return _angleSpan;
    }else {
        return -_angleSpan;
    }
}

#pragma mark - contentLayer

- (void)setContents:(id)contents {
    _contents = contents;
    self.bottomContentLayer.contents = _contents;
}

- (void)setFont:(UIFont *)font {
    _font = font;
    
    self.bottomContentLayer.font = _font;
}

- (void)setFontSize:(CGFloat)fontSize {
    _fontSize = fontSize;
    
    self.bottomContentLayer.fontSize = _fontSize;
}

- (void)setContentViewBackgroundColor:(UIColor *)contentViewBackgroundColor {
    _contentViewBackgroundColor = contentViewBackgroundColor;
    
    self.bottomContentLayer.backgroundColor = _contentViewBackgroundColor.CGColor;
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    
    self.bottomContentLayer.textColor = _textColor;
}

- (ZJSearchingContentsLayer *)bottomContentLayer {
    if (!_bottomContentLayer) {
        // 底部layer显示内容
        _bottomContentLayer = [ZJSearchingContentsLayer layerWithSuperLayer:self.layer];
        _bottomContentLayer.frame = self.bounds;
        _bottomContentLayer.contents = self.contents;
        _bottomContentLayer.contentsGravity = kCAGravityResizeAspectFill;
    }
    return _bottomContentLayer;
}

- (UIFont *)font {
    return self.bottomContentLayer.font;
}

- (CGFloat)fontSize {
    return self.bottomContentLayer.fontSize;
}

#pragma mark - public

- (void)startSearching {
    [self startAnimation];
    
    _searching = YES;
}

- (void)stopSearching {
    [self stopAnimation];
    
    _searching = NO;
}

#pragma mark - private

- (void)startAnimation {
    if (self.isSearching == NO) {
        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(updateLayer) userInfo:nil repeats:NO];
        });
    }
}

- (void)stopAnimation {
    if (self.isSearching) {
        [self.frontLineLayer removeAnimationForKey:@"rotationAnimation"];
    }
}

- (void)updateLayer {
    CABasicAnimation *rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    if (self.isClosewise) {
        rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    }else {
        rotationAnimation.toValue = [NSNumber numberWithFloat: -M_PI * 2.0 ];
    }
    rotationAnimation.duration = self.duration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = MAXFLOAT;
    [self.frontLineLayer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    if (self.hiddenBottomLineLayer == NO) {
        UIBezierPath *layerPath2 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)) radius:(self.bounds.size.width - _lineWidth) / 2 startAngle:0 endAngle:2*M_PI clockwise:self.clockwise];
        layerPath2.lineWidth = self.lineWidth;
        self.bottomLineLayer.path = layerPath2.CGPath;
    }
    
    // x轴0度角, 顺时针向下为正,逆时针向下为负
    UIBezierPath *layerPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)) radius:(self.bounds.size.width - _lineWidth) / 2 startAngle:0 endAngle:self.angleSpan clockwise:self.clockwise];
    layerPath.lineWidth = self.lineWidth;
    self.frontLineLayer.path = layerPath.CGPath;
    
    CGContextRestoreGState(context);
}

@end
