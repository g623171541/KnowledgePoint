//
//  Person.m
//  Runtime
//
//  Created by UBK on 2019/1/25.
//  Copyright © 2019 UBK. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>

@implementation Person

// OC方法的调用其实就是调用C语言中的函数
/*
 OC 的方法有哪几个部分组成？
 1. SEL：方法编号
 2. IMP：方法实现，就是函数指针（指向函数的指针）
 
 在一个类里面有一张表，记录方法编号和方法实现，
     这个表就像一本书的目录，
     左边是标题，
     右边是页码，
     内容实在页码所指向的那个区域
 
    形象图：
    https://note.youdao.com/yws/public/resource/9238329f5990bdc1d3cb2c3c85688b98/xmlnote/WEBRESOURCE409eab0eb72eec05fcde03824ccea83e/4902
 
 */

+(BOOL)resolveInstanceMethod:(SEL)sel{
    
    if (sel == @selector(eat)) {
        // 在这里添加eat方法
        class_addMethod(self, sel, eat, "v@:");
        // eat的名字就是函数指针，所以不用写()，否则会报错
        
        return YES;
    }
    
    if (sel == @selector(eatObjc:)) {
        // 添加有参数的函数
        class_addMethod(self, sel, eatObjc, "v@:@");
        return YES;
    }
    
    return [super resolveInstanceMethod:sel];
}

// 无参数
void eat(){
    NSLog(@"eat......");
}

// 有参数：OC方法调用会传递两个隐式参数
// objc_msgSend(p,@selector(eatObjc:),@"汉堡");
void eatObjc(id self, SEL _cmd,NSString * objc){
    NSLog(@"我在吃：%@",objc);
}

@end
