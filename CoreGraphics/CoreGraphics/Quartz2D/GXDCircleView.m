//
//  GXDCircleView.m
//  CoreGraphics
//
//  Created by paddygu on 2019/3/28.
//  Copyright © 2019 paddygu. All rights reserved.
//

#import "GXDCircleView.h"

@implementation GXDCircleView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    // 获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 100 20 为圆心
    // 最后一个0代表逆时针，1代表顺时针
    CGContextAddArc(ctx, 100, 20, 10, 0, M_PI * 2, 1);
    
//    CGContextSetRGBFillColor(ctx, 1, 0, 0, 1);
//    [[UIColor whiteColor] setStroke];
    [[UIColor redColor] setFill];
    
//    CGContextStrokePath(ctx);
    
    
    // 画椭圆
//    CGContextAddEllipseInRect(ctx, CGRectMake(50, 100, 100, 230));
    
    
    CGContextFillPath(ctx); // 填充
}


@end
