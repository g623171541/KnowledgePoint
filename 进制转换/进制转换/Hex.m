//
//  Hex.m
//  testCode-OC
//
//  Created by PaddyGu on 2017/11/10.
//  Copyright © 2017年 PaddyGu. All rights reserved.
//

#import "Hex.h"

@implementation Hex

// MARK: - 进制转换函数
+(void)hex{
    // !!!: 方法1：十六进制转十进制
    UInt64 mac1 =  strtoul([@"7f" UTF8String], 0, 16);
    NSLog(@"%llu",mac1);//转化为127 正确
    
    // !!!: 二进制转十进制
    NSLog(@"%lu",strtoul([@"1111" UTF8String], 0, 2));
    
    // !!!: 方法2：十六进制转为十进制
    NSScanner *redScanner = [NSScanner scannerWithString:@"FF"];
    unsigned int redIntValue;
    [redScanner  scanHexInt:&redIntValue];
    NSLog(@"redIntValue = %u",redIntValue);
    
}

@end
