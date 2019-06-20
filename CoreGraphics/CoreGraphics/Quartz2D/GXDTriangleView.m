//
//  GXDTriangleView.m
//  CoreGraphics
//
//  Created by paddygu on 2019/3/28.
//  Copyright © 2019 paddygu. All rights reserved.
//

#import "GXDTriangleView.h"

@implementation GXDTriangleView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    // 获取当前的图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 绘制三角形
    CGContextMoveToPoint(ctx, 100, 100);
    CGContextAddLineToPoint(ctx, 100, 200);
    CGContextAddLineToPoint(ctx, 180, 200);
    CGContextClosePath(ctx);
    
    // 关闭起点和终点
    CGContextStrokePath(ctx);
    
}


@end
