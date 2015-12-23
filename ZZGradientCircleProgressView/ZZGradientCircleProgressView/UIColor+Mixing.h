//
//  UIColor+Mixing.h
//  UIColorMixExample
//
//  Created by Damien Del Russo on 5/2/12.
//  Copyright (c) 2012. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Mixing)

+ (UIColor*)rybColorWithRed:(CGFloat)red
                     yellow:(CGFloat)yellow 
                       blue:(CGFloat)blue 
                      alpha:(CGFloat)alpha;
+ (UIColor*)cmykColorWithCyan:(CGFloat)cyan 
                      magenta:(CGFloat)magenta 
                       yellow:(CGFloat)yellow 
                        black:(CGFloat)black 
                        alpha:(CGFloat)alpha;
- (void)rybGetRed:(CGFloat*)red 
           yellow:(CGFloat*)yellow 
             blue:(CGFloat*)blue 
            alpha:(CGFloat*)alpha;
- (void)cmykGetCyan:(CGFloat*)cyan 
            magenta:(CGFloat*)magenta 
             yellow:(CGFloat*)yellow 
              black:(CGFloat*)black
              alpha:(CGFloat*)alpha;

+ (UIColor*)rgbMixForColors:(NSArray*)arrayOfColors; // mix as light, additive. fundamentally RGB doesn't mix differently than RYB

+ (UIColor*)rybMixForColors:(NSArray*)arrayOfColors; // mix as physical material, averaging brightness
+ (UIColor*)cmykMixForColors:(NSArray*)arrayOfColors;

/**
 *  根据RGB UIColor产生一个改变alpha的新的color对象
 *
 *  @param alpha 改变后的alpha
 *
 *  @return 新的UIColor对象
 */
- (UIColor *)changeAlpha:(CGFloat)alpha;

@end
