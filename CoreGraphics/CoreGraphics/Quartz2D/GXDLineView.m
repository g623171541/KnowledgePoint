//
//  GXDLineView.m
//  CoreGraphics
//
//  Created by paddygu on 2019/3/28.
//  Copyright © 2019 paddygu. All rights reserved.
//

#import "GXDLineView.h"

@implementation GXDLineView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    // 1️⃣取和当前视图向关联的图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext(); // 在drawRect方法中调用这个获取到的就是layer的上下文
    
    // 2️⃣绘制直线，保存绘制信息
    // 设置起点
    CGContextMoveToPoint(ctx, 100, 300);
    // 设置终点
    CGContextAddLineToPoint(ctx, 300, 600);
    
    // 3️⃣设置绘图的状态
    // 设置线条的颜色
    CGContextSetRGBStrokeColor(ctx, 0, 1.0, 0, 1);
    // 设置线条的宽度
    CGContextSetLineWidth(ctx, 10);
    // 设置线条的起点和终点的样式为圆角
    CGContextSetLineCap(ctx, kCGLineCapRound);
    // 设置线条的转角样式为圆角
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    
    // 4️⃣渲染，绘制出一条空心的线
    CGContextStrokePath(ctx);
    
    
    // 第二条线
    CGContextMoveToPoint(ctx, 100, 10);                 // 设置起点
    CGContextAddLineToPoint(ctx, 10, 20);               // 设置终点
//    CGContextSetRGBStrokeColor(ctx, 1, 0.8, 0, 1);      // 设置线条颜色
    [[UIColor blackColor] set];                          // 第二种设置颜色的方式
    CGContextSetLineWidth(ctx, 6);                      // 设置线宽
    CGContextSetLineCap(ctx, kCGLineCapButt);           // 设置终点和起点的样式
    CGContextStrokePath(ctx);                           // 绘制第二条线
    
    
}


@end
