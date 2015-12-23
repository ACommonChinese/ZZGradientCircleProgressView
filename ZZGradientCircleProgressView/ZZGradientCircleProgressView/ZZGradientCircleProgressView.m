//
//  ZZGradientCircleProgressView.m
//  ZZGradientCircleProgressView
//
//  Created by 刘威振 on 12/22/15.
//  Copyright © 2015 LiuWeiZhen. All rights reserved.
//  http://www.cocoachina.com/industry/20140705/9039.html
//  http://www.tuicool.com/articles/RZBFBn 参数解释
//  http://blog.csdn.net/zhoutao198712/article/details/20864143

/**
 * 我们先用CAGradientLayer做出渐变效果，然后把ShapeLayer作为GradientLayer的Mask来截取出需要的部分，以此达到渐变的进度条效果
 */

#import "ZZGradientCircleProgressView.h"
#import "UIColor+Mixing.h"

// #define PROGRESS_LINE_WIDTH 20 //弧线的宽度
// #define degreesToRadians(x) (M_PI*(x)/180.0) //把角度转换成PI的方式
// #define  PROGREESS_WIDTH 180 //圆直径

@interface ZZGradientCircleProgressView ()

@property (nonatomic) CAShapeLayer *trackLayer;
@property (nonatomic) CAShapeLayer *progressLayer;
@property (nonatomic) NSArray      *gradientColors;
@end

@implementation ZZGradientCircleProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addLayers];
        return self;
    }
    return nil;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self addLayers];
        return self;
    }
    return nil;
}

- (void)addLayers {
    [self addTrackLayer];    // Track Layer
    [self addProgressLayer]; // Progress Layer
    
    // Progress Width Default: 20
    self.progressWidth = 20.0;
}

- (void)addTrackLayer {
    self.trackLayer       = [[CAShapeLayer alloc] init];
    _trackLayer.fillColor = nil;
    _trackLayer.frame     = self.bounds;
    self.trackColor       = [UIColor blackColor];
    [self.layer addSublayer:_trackLayer];
}

- (void)addProgressLayer {
    /**
     CAShapeLayer *progressLayer = [CAShapeLayer layer];
     progressLayer.frame         = self.bounds;
     progressLayer.fillColor     = [[UIColor clearColor] CGColor];
     progressLayer.strokeColor   = [UIColor redColor].CGColor;
     progressLayer.lineWidth     = PROGRESS_LINE_WIDTH;
     [self.layer addSublayer:progressLayer];
     
     CGPoint center              = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));// 6
     // CGFloat radius = (PROGREESS_WIDTH-PROGRESS_LINE_WIDTH)/2;
     CGFloat radius = (CGRectGetMidX(self.bounds) - PROGRESS_LINE_WIDTH/2.0);
     UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:degreesToRadians(-90) endAngle:degreesToRadians(0) clockwise:YES];//上面说明过了用来构建圆形
     progressLayer.path =[path CGPath];
     */
    
    self.progressLayer = [CAShapeLayer layer];
    _progressLayer.frame         = self.bounds;
    _progressLayer.fillColor     = [[UIColor clearColor] CGColor];
    _progressLayer.strokeColor   = [UIColor redColor].CGColor;
    _progressLayer.lineWidth     = 20; // Initial width
    [self.layer addSublayer:_progressLayer];
}

// 更新track path
- (void)refreshTrack {
    self.trackLayer.path = [self getArcPathWithProgress:1.0].CGPath;
}

// 更新progress path
- (void)refreshProgress {
    self.progressLayer.path = [self getArcPathWithProgress:_progress].CGPath;
}

- (void)setTrackColor:(UIColor *)trackColor {
    self.trackLayer.strokeColor = trackColor.CGColor;
}

// 更新线条宽度
- (void)setProgressWidth:(CGFloat)progressWidth {
    _progressWidth = progressWidth;
    self.trackLayer.lineWidth = _progressWidth;
    self.progressLayer.lineWidth = _progressWidth;
    [self refreshTrack];
    [self refreshProgress];
}

- (void)setProgressColor:(UIColor *)progressColor {
    //self.progressLayer.strokeColor = progressColor.CGColor;
}

- (void)setProgress:(CGFloat)progress {
    NSLog(@"%f", progress);
    _progress = progress > 1.000001 ? 0.0 : progress;
    // _progress = progress;
    [self refreshProgress];
}

- (void)setProgress:(CGFloat)progress aminated:(BOOL)animated {}

/**
        | 270
        |
        |
 180 ----------> 0, 360
        |
        |
        | 90
 
 
        | -90, 270
        |
        |
 -------------> 0
180     |
        |
        | 90
 */

- (UIBezierPath *)getArcPathWithProgress:(CGFloat)progress {
    CGPoint center              = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));// 6
    // CGFloat radius = (PROGREESS_WIDTH-PROGRESS_LINE_WIDTH)/2;
    // CGFloat radius = (CGRectGetMidX(self.bounds) - PROGRESS_LINE_WIDTH/2.0);
    CGFloat radius = (CGRectGetMidX(self.bounds) - self.progressWidth/2.0);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:-M_PI_2 endAngle:2*M_PI*progress-M_PI_2 clockwise:YES];//上面说明过了用来构建圆形
    return path;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    [self refreshTrack];
    [self refreshProgress];
}

- (void)setGradientColors:(NSArray *)gradientColors {
    if (gradientColors.count != 2) {
        @throw [NSException exceptionWithName:@"数组数量异常" reason:@"gradienColors只允许有且只有两个UIColor对象" userInfo:nil];
    }
    CALayer *layer = [CALayer layer];
    
    // 曲线救国 http://blog.csdn.net/zhoutao198712/article/details/20864143
    
    // 新建两个layer加在gradientLayer上
    UIColor *colorStart  = gradientColors[0];
    UIColor *colorEnd    = gradientColors[1];
    UIColor *colorMiddle = [UIColor rgbMixForColors:@[colorStart, colorEnd]];
    // UIColor *colorMiddle = [UIColor yellowColor];
    
    // 右侧渐变层
    CAGradientLayer *gradientLayer1 = [CAGradientLayer layer];
    gradientLayer1.frame            = CGRectMake(self.bounds.size.width/2.0, 0, self.bounds.size.width/2.0, self.bounds.size.height);
    gradientLayer1.colors           = @[(__bridge id)colorStart.CGColor, (__bridge id)colorMiddle.CGColor];
//    gradientLayer1.locations        = @[@(0.0), @(1.00)];
    gradientLayer1.locations        = @[@(0.0), @(0.9), @(1.00)];
    gradientLayer1.startPoint       = CGPointMake(0.5, 0.0);
    gradientLayer1.endPoint         = CGPointMake(0.5, 1.0);
    [layer addSublayer:gradientLayer1];
    
    // 左侧渐变层
    CAGradientLayer *gradientLayer2 = [CAGradientLayer layer];
    gradientLayer2.frame            = CGRectMake(0, 0, self.bounds.size.width/2.0, self.bounds.size.height);
    gradientLayer2.colors           = @[(__bridge id)colorMiddle.CGColor, (__bridge id)colorEnd.CGColor];
    // gradientLayer2.locations        = @[@(0.0), @(1.00)];
    gradientLayer2.locations        = @[@(0.1), @(1.00)];
    gradientLayer2.startPoint       = CGPointMake(0.5, 1.0);
    gradientLayer2.endPoint         = CGPointMake(0.5, 0.0);
    [layer addSublayer:gradientLayer2];
    
    // 和_progressLayer mask, 让_progressLayer截取渐变
    layer.mask = _progressLayer;
    [self.layer addSublayer:layer];
}

- (void)setGradientColor:(UIColor *)gradientColor {
    if (_gradientColor != gradientColor) {
        _gradientColor = gradientColor;
        self.gradientColors = @[gradientColor, [gradientColor changeAlpha:0.2]];
    }
}

@end
