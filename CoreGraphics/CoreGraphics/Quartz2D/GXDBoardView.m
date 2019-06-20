//
//  GXDBoardView.m
//  CoreGraphics
//
//  Created by paddygu on 2019/6/20.
//  Copyright © 2019 paddygu. All rights reserved.
//

#import "GXDBoardView.h"

@interface GXDBoardView()
{
    CGMutablePathRef path;
}
@end

@implementation GXDBoardView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        path = CGPathCreateMutable();
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddPath(context, path);
    CGContextStrokePath(context);
    
}

// 开始点击
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [touches.anyObject locationInView:self];
    CGPathMoveToPoint(path, nil, point.x, point.y);
}

// 手指移动
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [touches.anyObject locationInView:self];
    CGPathAddLineToPoint(path,  nil, point.x, point.y);
    
    // 重绘才能重新执行drawRect
    [self setNeedsDisplay];
}


@end
