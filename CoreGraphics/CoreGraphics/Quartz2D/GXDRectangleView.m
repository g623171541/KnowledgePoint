//
//  GXDRectangleView.m
//  CoreGraphics
//
//  Created by paddygu on 2019/3/28.
//  Copyright © 2019 paddygu. All rights reserved.
//

#import "GXDRectangleView.h"

@implementation GXDRectangleView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect {
    
    
    // 获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 画四边形
    CGContextAddRect(ctx, CGRectMake(60, 2, 100, 20));
    CGContextSetRGBStrokeColor(ctx, 1.0, 0, 1.0, 1.0);
    CGContextSetRGBFillColor(ctx, 1, 1, 0, 1.0);
//    [[UIColor redColor] setStroke];
//    [[UIColor greenColor] setFill];
    
    // 调用OC的方法设置绘图颜色(同时设置了实心和空心)
    //    [[UIColor greenColor] set];
    
    CGContextStrokePath(ctx);
}


@end
