//
//  RuntimeObject.m
//  Runtime
//
//  Created by paddygu on 2019/1/30.
//  Copyright © 2019 UBK. All rights reserved.
//

#import "RuntimeObject.h"

@implementation RuntimeObject

// 重写
// 第一步骤：解析实例方法（resolve解决 分解 解析）
+ (BOOL)resolveInstanceMethod:(SEL)sel{
    // 如果是test方法 打印日志
    if (sel == @selector(test)) {
        NSLog(@"resolveInstanceMethod");
        
        // 如果返回YES,那么总的消息转发流程就结束了，如果想继续去查找方法，就应该返回NO
//        return YES;
        
        return NO;
        
    }else{
        // 返回父类的默认调用
        return [super resolveInstanceMethod:sel];
    }
}

// 重写
// 第二步骤：（forward 推进 发送，forwarding target:转发目标）
- (id)forwardingTargetForSelector:(SEL)aSelector{
    NSLog(@"forwardingTargetForSelector");
    return nil;     // 这里返回nil，消息转发流程就能走到第三步骤
}

// 重写
// 第三步骤：1️⃣：（Signature 签名）
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    // 如果是test方法 打印日志
    if (aSelector == @selector(test)) {
        NSLog(@"methodSignatureForSelector");
        // 如果是test方法，则返回一个正确的方法签名，Runtime就会创建一个NSInvocation 对象并发送 -forwardInvocation:消息给目标对象。
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
        /*  方法签名的说明：
            v 代表返回值是void类型的；
            @ 代表第一个参数类型是id，即self
            : 代表第二个参数类型是SEL，即@selector(test)
         */
        
        // 如果此方法 return nil; 则会调用 doesNotRecognizeSelector: 程序就这样挂掉了
    }else{
        // 返回父类的默认调用
        return [super methodSignatureForSelector:aSelector];
    }
}
// 第三步骤：2️⃣
- (void)forwardInvocation:(NSInvocation *)anInvocation{
    NSLog(@"forwardInvocation");
}

@end
