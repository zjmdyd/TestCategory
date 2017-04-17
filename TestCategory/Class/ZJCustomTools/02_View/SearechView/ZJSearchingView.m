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
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) CAShapeLayer *bottomShapeLineLayer;
@property (nonatomic, strong) ZJSearchingContentsLayer *bottomLayer;
@end

@implementation ZJSearchingView

@synthesize contents = _contents;
@synthesize lineColor = _lineColor;
@synthesize font = _font;
@synthesize fontSize = _fontSize;
@synthesize bottomLineLayerColor = _bottomLineLayerColor;

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
    self.backgroundColor = [UIColor orangeColor];
    
    // 默认顺时针
    _clockwise = YES;
    _angleSpan = M_PI*0.75;
    _lineWidth = 1.0;
    _duration = 1.0;
    _hiddenBottomLineLayer = YES;

    // 底部layer显示内容
    self.bottomLayer = [ZJSearchingContentsLayer layerWithSuperLayer:self.layer];
    self.bottomLayer.frame = self.bounds;
    self.bottomLayer.contents = self.contents;
    self.bottomLayer.contentsGravity = kCAGravityResizeAspectFill;
    self.bottomLayer.backgroundColor = self.backgroundColor.CGColor;
    
    // 旋转layer
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.frame = self.layer.bounds;  // 设置frame,不能设置bounds,设置bounds位置会不正确
    self.shapeLayer.backgroundColor = [UIColor clearColor].CGColor;
    self.shapeLayer.fillColor = nil;
    self.shapeLayer.strokeColor = self.lineColor.CGColor;
    [self.layer addSublayer:self.shapeLayer];
    
    self.bottomShapeLineLayer.hidden = _hiddenBottomLineLayer;
}

#pragma mark - setter

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
    self.bottomLayer.backgroundColor = backgroundColor.CGColor;
}

- (void)setSearching:(BOOL)searching {
    if (searching) {
        [self startAnimation];
    }else {
        [self stopAnimation];
    }
    
    _searching = searching;
}

- (void)setContents:(id)contents {
    _contents = contents;
    self.bottomLayer.contents = _contents;
}

- (void)setLineWidth:(CGFloat)lineWidth {
    _lineWidth = lineWidth;
    self.shapeLayer.lineWidth = _lineWidth;
    self.bottomShapeLineLayer.lineWidth = _lineWidth;
    
    // 需要重绘界面, 因为lineWidth改变, path的radius会改变
    [self setNeedsDisplay];
}

- (void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
    
    self.shapeLayer.strokeColor = _lineColor.CGColor;
}

- (void)setHiddenLineLayer:(BOOL)hiddenLineLayer {
    _hiddenLineLayer = hiddenLineLayer;

    self.shapeLayer.hidden = _hiddenLineLayer;
}

- (void)setBottomLineLayerColor:(UIColor *)bottomLineLayerColor {
    _bottomLineLayerColor = bottomLineLayerColor;
    
    self.bottomShapeLineLayer.strokeColor = _bottomLineLayerColor.CGColor;
}

- (void)setHiddenBottomLineLayer:(BOOL)hiddenBottomLineLayer {
    _hiddenBottomLineLayer = hiddenBottomLineLayer;
    
    self.bottomShapeLineLayer.hidden = _hiddenBottomLineLayer;
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font {
    _font = font;
    
    self.bottomLayer.font = _font;
}

- (void)setFontSize:(CGFloat)fontSize {
    _fontSize = fontSize;
    
    self.bottomLayer.fontSize = _fontSize;
}

#pragma mark - getter

- (CGFloat)angleSpan {
    if (self.isClosewise) {
        return _angleSpan;
    }else {
        return -_angleSpan;
    }
}

- (id)contents {
    return _contents;
}

- (UIColor *)lineColor {
    if (!_lineColor) {
        _lineColor = [UIColor redColor];
    }
    
    return _lineColor;
}

- (UIFont *)font {
    return self.bottomLayer.font;
}

- (CGFloat)fontSize {
    return self.bottomLayer.fontSize;
}

- (UIColor *)backgroundColor {
    return [UIColor colorWithCGColor:self.bottomLayer.backgroundColor];
}

- (CAShapeLayer *)bottomShapeLineLayer {
    if (!_bottomShapeLineLayer) {
        // 旋转layer底部line
        _bottomShapeLineLayer = [CAShapeLayer layer];
        _bottomShapeLineLayer.frame = self.layer.bounds;  // 设置frame,不能设置bounds,设置bounds位置会不正确
        _bottomShapeLineLayer.backgroundColor = [UIColor clearColor].CGColor;
        _bottomShapeLineLayer.fillColor = nil;
        _bottomShapeLineLayer.strokeColor = self.bottomLineLayerColor.CGColor;
        [self.layer insertSublayer:_bottomShapeLineLayer below:self.shapeLayer];
    }
    return _bottomShapeLineLayer;
}

- (UIColor *)bottomLineLayerColor {
    if (!_bottomLineLayerColor) {
        _bottomLineLayerColor = [UIColor groupTableViewBackgroundColor];
    }
    
    return _bottomLineLayerColor;
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
        [self.shapeLayer removeAnimationForKey:@"rotationAnimation"];
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
    [self.shapeLayer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    // x轴0度角, 顺时针向下为正,逆时针向下为负
    UIBezierPath *layerPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)) radius:(self.bounds.size.width - _lineWidth) / 2 startAngle:0 endAngle:self.angleSpan clockwise:self.clockwise];
    layerPath.lineWidth = self.lineWidth;
    self.shapeLayer.path = layerPath.CGPath;
    
    if (self.hiddenBottomLineLayer == NO) {
        UIBezierPath *layerPath2 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)) radius:(self.bounds.size.width - _lineWidth) / 2 startAngle:0 endAngle:2*M_PI clockwise:self.clockwise];
        layerPath2.lineWidth = self.lineWidth;
        self.bottomShapeLineLayer.path = layerPath2.CGPath;
    }
    
    CGContextRestoreGState(context);
}

@end
