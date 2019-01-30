//
//  NSURL+HOOK.m
//  Runtime
//
//  Created by UBK on 2019/1/26.
//  Copyright © 2019 UBK. All rights reserved.
//

#import "NSURL+HOOK.h"
#import <objc/runtime.h>

@implementation NSURL (HOOK)

//需要在加载方法中进行方法交换
+ (void)load{
    // 获取两个method
    Method urlMehtod = class_getClassMethod(self, @selector(URLWithString:));
    Method hkMethod = class_getClassMethod(self, @selector(HK_URLWithString:));
    method_exchangeImplementations(urlMehtod, hkMethod);
}

+(instancetype)HK_URLWithString:(NSString *)URLString{
    // NSURL *url = [NSURL URLWithString:URLString];
    /*
        ⭐️如果这么写的话，造成了递归调用，内存泄漏
     */
    
    // 调用HK_URLWithString方法其实就是调用原本的URLWithString方法，因为两个方法的实现已经互换了。
    NSURL *url = [NSURL HK_URLWithString:URLString];
    
    if (url == nil) {
        NSLog(@"URL为空");
    }
    return url;
}

@end
