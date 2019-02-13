//
//  Paixu_maopao.m
//  算法
//
//  Created by UBK on 2019/2/13.
//  Copyright © 2019 UBK. All rights reserved.
//

#import "Paixu_maopao.h"

@implementation Paixu_maopao

+ (void)maopao:(NSArray *)array{
    NSInteger length = array.count;
    NSMutableArray *arrayM = [NSMutableArray arrayWithArray:array];
    
    // 核心是依次比较相邻的元素
    
    // 比较的遍数：这个数组跑了多少遍，5个数要比较4次才能把最小或者最大的找出来
    for (NSInteger i=0; i<length-1; i++) {
        // 每一遍比较的次数
        for (NSInteger j=0; j<length-1-i; j++) {
            // 比较的是 j 和 j+1 的元素
            if ([arrayM[j] integerValue] > [arrayM[j+1] integerValue]) {
                // 交换的也是 j 和 j+1 的元素
                [arrayM exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
    
    NSLog(@"冒泡排序：%@",[arrayM componentsJoinedByString:@","]);
}

@end
