//
//  GXDHuman.m
//  CoreGraphics
//
//  Created by paddygu on 2019/7/3.
//  Copyright © 2019 paddygu. All rights reserved.
//

#import "GXDHuman.h"

#define KRadius 70
#define KTopY   200
#define KColor(r,g,b)  [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1.0]

@implementation GXDHuman

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    //1. 获取图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    drawBody(context,rect);
    drawMouse(context,rect);
    drawEyes(context,rect);
    
}

void drawBody(CGContextRef context,CGRect rect){
    // 上半圆
    CGFloat topX = rect.size.width * 0.5;
    CGFloat topY = KTopY;
    // 画圆弧 圆心：中心点右侧弧度为 0 中心点下方 弧度为 M_PI_2 中心点左侧 弧度为 M_PI 中心点上方 弧度为 -M_PI_2
    // 1为逆时针 0为顺时针
    CGContextAddArc(context, topX, topY, KRadius, 0, M_PI, 1);
    
    // 左边身体的线
    CGFloat middleX = topX - KRadius;
    CGFloat middleH = 100;
    CGFloat middleY = topY + middleH;
    CGContextAddLineToPoint(context, middleX, middleY);
    
    // 下半圆
    CGContextAddArc(context, topX, middleY, KRadius, M_PI, 0, 1);
    
    // 右边的线
    CGContextClosePath(context);
    // 设置颜色
    [KColor(252, 218, 0) set];
    // 显示在View上
    CGContextFillPath(context);
    
}

void drawMouse(CGContextRef context,CGRect rect){
    // 用贝塞尔曲线话嘴巴，设置一个控制点
    CGFloat controlX = rect.size.width * 0.5;
    CGFloat controlY = rect.size.height * 0.4;
    // 设置当前点
    CGFloat marginX = 20;
    CGFloat marginY = 10;
    CGFloat currentX = controlX - marginX;
    CGFloat currentY = controlY - marginY;
    CGContextMoveToPoint(context, currentX, currentY);
    
    // 设置结束点
    CGFloat endX = controlX + marginX;
    CGFloat endY = currentY;
    // 画贝塞尔曲线
    CGContextAddQuadCurveToPoint(context, controlX, controlY, endX, endY);
    CGContextSetLineWidth(context, 3);
    // 设置颜色
    [[UIColor blackColor] set];
    // 显示
    CGContextStrokePath(context);
}

void drawEyes(CGContextRef context,CGRect rect){
    // 绑带
    CGFloat startX = rect.size.width*0.5 - KRadius;
    CGFloat startY = KTopY;
    CGContextAddRect(context, CGRectMake(startX, startY, 2*KRadius, 15));
    [[UIColor blackColor] set];
    CGContextFillPath(context);
    
    // 镜框
    [KColor(61, 62, 66) set];
    CGFloat kuangRadius = KRadius * 0.4;
    CGFloat kuangX = rect.size.width * 0.5;
    CGFloat kuangY = startY;
    CGContextAddArc(context, kuangX, kuangY, kuangRadius, 0, M_PI * 2, 0);
    CGContextFillPath(context);
    
    // 里面的白色框
    [[UIColor whiteColor] set];
    CGFloat radius = kuangRadius * 0.7;
    CGContextAddArc(context, kuangX, kuangY, radius, 0, M_PI *2, 0);
    CGContextFillPath(context);
    
    // 画眼睛
    [[UIColor blackColor] set];
    CGContextAddArc(context, kuangX, kuangY, radius * 0.5, 0, M_PI*2, 0);
    CGContextFillPath(context);
}


@end
