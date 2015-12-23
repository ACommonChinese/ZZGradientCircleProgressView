//
//  ZZGradientCircleProgressView.h
//  ZZGradientCircleProgressView
//
//  Created by 刘威振 on 12/22/15.
//  Copyright © 2015 LiuWeiZhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZGradientCircleProgressView : UIView


/**
 *  线条宽
 */
@property (nonatomic) CGFloat progressWidth;

/**
 *  进度条的未渲染颜色
 */
@property (nonatomic) UIColor *trackColor;

/**
 *  进度条的渲染色
 */
// @property (nonatomic) UIColor *progressColor;

/**
 *  进度 [0.0 ~ 1.0]
 */
@property (nonatomic) CGFloat progress;

- (void)setProgress:(CGFloat)progress aminated:(BOOL)animated;

/**
 *  渐变色，目前只允许有且仅有2个UIColor对象
 */
// @property (nonatomic) NSArray *gradientColors;

@property (nonatomic) UIColor *gradientColor;

@end
