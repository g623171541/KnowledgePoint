//
//  main.m
//  算法
//
//  Created by UBK on 2019/2/13.
//  Copyright © 2019 UBK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Paixu_maopao.h"    // 冒泡排序
#import "Paixu_xuanze.h"    // 选择排序

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSArray *array = @[@2,@3,@32,@16,@99];
        
        // 冒泡排序：核心是依次比较相邻的元素
        [Paixu_maopao maopao:array];
        
        // 选择排序：核心是找到最大或最小的元素
        [Paixu_xuanze xuanze:array];
        
        
    }
    return 0;
}
