//
//  main.m
//  NSPredicate
//
//  Created by PaddyGu on 2017/11/3.
//  Copyright © 2017年 PaddyGu. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        //iOS Predicate 即谓词逻辑。和数据库的SQL语句具有相似性，都是从数据堆中根据条件进行筛选。
        
        /*
            使用场景：
         
                （1）NSPredicate给我留下最深印象的是两个数组求交集的一个需求，如果按照一般写法，需要2个遍历，但NSArray提供了一个filterUsingPredicate的方法，用了NSPredicate，就可以不用遍历！
         
                （2）在存储自定义对象的数组中，可以根据条件查询数组中满足条件的对象。
         
         */
        
        
        //NSPredicate IN 的用法
        NSArray *arr1 = [NSArray arrayWithObjects:@1,@2,@3,@4,@5, nil];
        NSArray *arr2 = [NSArray arrayWithObjects:@5,@6, nil];
        
        //SELF 代表字符串本身 IN可以大写也可以小写,in后有无空格均可
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF in %@",arr2];
        //表示获取 arr2 和 arr1中的交集
        NSArray *temp = [arr1 filteredArrayUsingPredicate:predicate];//过滤器
        NSLog(@"交集为：%@",temp);
        
        //BETWEEN可以获取一定范围的值
        predicate = [NSPredicate predicateWithFormat:@"SELF BETWEEN{2,4}",arr1];
        NSLog(@"arr1里面包含范围是2-4 的元素有%@",[arr1 filteredArrayUsingPredicate:predicate]);
        
        //还有其他的比较运算符>,<,==,>=,<=,!=  以等于号==为例
        predicate = [NSPredicate predicateWithFormat:@"SELF == 5"];
        NSLog(@"arr1里面等于5的值为：%@",[arr1 filteredArrayUsingPredicate:predicate]);
        
        
        /*
         同时还有以下与字符串操作相关的关键词 ：
         BEGINSWITH     ：以某个字符串开头
         ENDSWITH       ：以某个字符串结尾
         CONTAINS       ：是否包含某个字符串
         LIKE           ：包含这个字符的字符串
         同时这四个关键词后面还可以跟上一些格式符号 如：BEGINSWITH[cd] c表示不区分大小写 d表示不区分发音符号 cd就可以表示即不区分大小写 也不区分发音符号
         */
        NSArray *array3 = [NSArray arrayWithObjects:@"jack",@"anne",@"reserved",@"control" ,@"type",@"soure",@"version",nil];
        predicate = [NSPredicate predicateWithFormat:@"self beginswith[cd] 'j'"];
        NSLog(@"开头是j的单词有：%@",[array3 filteredArrayUsingPredicate:predicate]);
        
        //  LIKE 例子：@"SELF like[cd] '*e*' "
        //  *表示通配符
        
    }
    return 0;
}
