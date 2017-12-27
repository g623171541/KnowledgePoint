//
//  ViewController.m
//  JumpToAppStore
//
//  Created by PaddyGu on 2017/11/9.
//  Copyright © 2017年 PaddyGu. All rights reserved.
//

#import "ViewController.h"
#import <StoreKit/StoreKit.h>

@interface ViewController ()<SKStoreProductViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(100, 100, 100, 50);
    [button setTitle:@"点击跳转" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor orangeColor];
    
    [button addTarget:self action:@selector(otherWayToAppStor) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}



-(void)click
{
    //    跳转到App Store的应用详情页
    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id391945719"]];
    
    //跳转到App Store的应用详情页
    //    NSString *str = @"https://itunes.apple.com/cn/app/jie-zou-da-shi/id493901993?mt=8";
    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
    //使用 itms: 点击跳转到 iTunes Store
    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms://itunes.apple.com/gb/app/yi-dong-cai-bian/id391945719?mt=8"]];
    
    
    //    跳转到App Store的应用评价页
    NSString *urlStr = @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=391945719&pageNumber=0&sortOrdering=2&mt=8";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
    
    //ios 10 以后用下面这个方法打开
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr] options:nil completionHandler:^(BOOL success) {
//        NSLog(@"success");
//    }];
    
}


/*
    跳转到AppStore评分,有两种方法：
    ①跳转到AppStore,进行评分；
    ②另一种是在应用内,内置AppStore进行评分。
 */
-(void)otherWayToAppStor {
    //苹果提供了一个框架StoreKit.framework,导入StoreKit.framework,在需要跳转的控制器里面添加头文件#import, 实现代理方法：< SKStorePRoductViewControllerDelegate >
    // 初始化控制器
    
    SKStoreProductViewController*storeProductViewContorller = [[SKStoreProductViewController alloc]init];
    
    // 设置代理请求为当前控制器本身
    
    storeProductViewContorller.delegate = self;
    
    [storeProductViewContorller loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier:@391945719} completionBlock:^(BOOL result,NSError*error)   {
        
        if(error)  {
            NSLog(@"error %@ with userInfo %@",error,[error userInfo]);
        }else{
        // 模态弹出appstore
        [self presentViewController:storeProductViewContorller animated:YES completion:nil];
        }
        
    }];
    

}

- (void)productViewControllerDidFinish:(SKStoreProductViewController*)viewController

{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



@end
