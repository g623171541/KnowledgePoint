//
//  Paixu_xuanze.m
//  算法
//
//  Created by UBK on 2019/2/13.
//  Copyright © 2019 UBK. All rights reserved.
//

#import "Paixu_xuanze.h"

@implementation Paixu_xuanze

+(void)xuanze:(NSArray *)array{
    NSInteger length = array.count;
    NSMutableArray *arrayM = [NSMutableArray arrayWithArray:array];
    
    // 跑一遍找到一个值最小的下标，这里i<length 效果一样，但是应该是i<length-1
    for (NSInteger i=0; i<length-1; i++) {
        // 假设下标为i的值就是最小值
        NSInteger minIndex = i;
        // 遍历i之后的值，如果有比i小的就把最小下边改为其下标
        for (NSInteger j=i+1; j<length; j++) {
            if ([arrayM[i] integerValue] > [arrayM[j] integerValue]) {
                minIndex = j;
            }
        }
        // 如果i不是最小下标，则交换
        if (minIndex != i) {
            [arrayM exchangeObjectAtIndex:minIndex withObjectAtIndex:i];
        }
    }
    NSLog(@"选择排序：%@",[arrayM componentsJoinedByString:@","]);
}

@end
