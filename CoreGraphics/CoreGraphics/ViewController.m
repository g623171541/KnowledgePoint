//
//  ViewController.m
//  CoreGraphics
//
//  Created by paddygu on 2019/3/28.
//  Copyright © 2019 paddygu. All rights reserved.
//

#import "ViewController.h"
#import "GXDLineView.h"
#import "GXDTriangleView.h"
#import "GXDRectangleView.h"
#import "GXDCircleView.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 画直线
    GXDLineView *lineView = [[GXDLineView alloc] initWithFrame:CGRectMake(0, 44, self.view.bounds.size.width, 28)];
    lineView.backgroundColor = [UIColor redColor];
    [self.view addSubview:lineView];
    
    // 画三角形
    GXDTriangleView *triangleView = [[GXDTriangleView alloc] initWithFrame:CGRectMake(0, 70, [UIScreen mainScreen].bounds.size.width, 28)];
    triangleView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:triangleView];
    
    // 画矩形
    GXDRectangleView *rectangleView = [[GXDRectangleView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 30)];
    rectangleView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:rectangleView];
    
    // 画圆形
    GXDCircleView *circleView = [[GXDCircleView alloc] initWithFrame:CGRectMake(0, 130, [UIScreen mainScreen].bounds.size.width, 50)];
    circleView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:circleView];
    
}


@end
