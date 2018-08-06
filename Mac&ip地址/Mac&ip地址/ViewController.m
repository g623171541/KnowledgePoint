//
//  ViewController.m
//  Mac&ip地址
//
//  Created by PaddyGu on 2018/7/17.
//  Copyright © 2018年 paddygu. All rights reserved.
//

#import "ViewController.h"
#import "GetMacAndIp.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 需要手动导入<libresolv.9.tbd>包
    
    GetMacAndIp *get = [[GetMacAndIp alloc] init];
    NSLog(@"%@",[get getIPAddress:YES]);
    NSLog(@"%@",[get getMacAddress]);
    
    
    #pragma mark - 连接WiFi，连接不同的WiFi，mac是一样的
//    2018-07-17 16:42:09.802625+0800 Mac&ip地址[7976:3361288] 192.168.0.208
//    2018-07-17 16:42:09.811240+0800 Mac&ip地址[7976:3361288] 20:ab:37:83:9a:81
    
    #pragma mark - 不连接WiFi
//    2018-07-17 16:43:16.456882+0800 Mac&ip地址[7981:3362737] 10.39.140.229
//    could not get current IP address of en0
//    2018-07-17 16:43:16.457360+0800 Mac&ip地址[7981:3362737] 02:00:00:00:00:00
}


@end
