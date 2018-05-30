//
//  ShadowViewController.m
//  test-OC-UI
//
//  Created by PaddyGu on 2017/11/12.
//  Copyright © 2017年 PaddyGu. All rights reserved.
//

#import "ShadowViewController.h"

@interface ShadowViewController ()

@end

@implementation ShadowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 60, 100, 50)];
    view.backgroundColor = [UIColor greenColor];
    [self createShadow:view];
    
    [self.view addSubview:view];

}

//创建阴影
-(void)createShadow:(UIView *)view {
    view.layer.shadowColor = [[UIColor darkGrayColor] CGColor];
    view.layer.shadowOffset = CGSizeMake(0, 10);
    view.layer.shadowRadius = 10.0;
    view.layer.shadowOpacity = 0.5;
    
}



@end
