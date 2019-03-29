//
//  GXDGraduallyView.m
//  CoreGraphics
//
//  Created by paddygu on 2019/3/29.
//  Copyright © 2019 paddygu. All rights reserved.
//

#import "GXDGraduallyView.h"

@implementation GXDGraduallyView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
#pragma mark - 放射性渐变（圆心开始到周围）
    // 创建上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 创建色彩空间对象
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    // 创建颜色数组
        // 创建起点颜色
        // CGColorRef beginColor = CGColorCreate(colorSpaceRef, (CGFloat[]){0.01f, 0.99f, 0.01f, 1.0f});
        // 创建终点颜色
        // CGColorRef endColor = CGColorCreate(colorSpaceRef, (CGFloat[]){0.99f, 0.99f, 0.01f, 1.0f});
        // CFArrayRef colorArray = CFArrayCreate(kCFAllocatorDefault, (const void*[]){beginColor, endColor}, 2, nil);
    NSArray *gradientArray = [NSArray arrayWithObjects:(id)[UIColor greenColor].CGColor,(id)[UIColor redColor].CGColor, nil];
    // 对应起点和终点颜色位置
    CGFloat gradLoactions[] = {0,1};
    
    // 创建渐变对象
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientArray, gradLoactions);
    
    CGPoint point = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    CGFloat radius = MAX(CGRectGetHeight(rect), CGRectGetWidth(rect));
    // startCenter 起点中心圆点
    // startRadius:起点的半径
    // endCenter:终点
    // endRadius:终点半径
    // CGContextDrawRadialGradient(<#CGContextRef  _Nullable c#>, <#CGGradientRef  _Nullable gradient#>, <#CGPoint startCenter#>, <#CGFloat startRadius#>, <#CGPoint endCenter#>, <#CGFloat endRadius#>, <#CGGradientDrawingOptions options#>)
    CGContextDrawRadialGradient(ctx, gradient, point, 0, point, radius, 0);
    CGGradientRelease(gradient);
    // 释放色彩空间
    CGColorSpaceRelease(colorSpace);
    
#pragma mark - 线性渐变
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    // 创建色彩空间对象
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    NSArray *gradientArray = [NSArray arrayWithObjects:(id)[UIColor greenColor].CGColor,(id)[UIColor redColor].CGColor, nil];
//    CGFloat gradLoactions[] = {0,1};
//    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientArray, gradLoactions);
//    CGContextSaveGState(ctx);
//    CGContextDrawLinearGradient(ctx, gradient, CGPointMake(0, 0), CGPointMake(100, 100), 0);
//    CGContextRestoreGState(ctx);
//    CGGradientRelease(gradient);
//    CGColorSpaceRelease(colorSpace);
    
}

#pragma mark - drawRect 和 drawLayer 的关系
// drawLayer是一个图层的代理方法。每个UIView都由自己的基层CaLayer，它会自动调用这个drawlayer方法将其事先设置好的各种属性绘制在这个基本的图层上面
// 这个方法里面会自动调用drawRect方法，这就是方便开发者，在基本图层的基础上再次自定义。
-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    [super drawLayer:layer inContext:ctx];
}


@end
