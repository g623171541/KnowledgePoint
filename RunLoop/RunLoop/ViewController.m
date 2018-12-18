//
//  ViewController.m
//  RunLoop
//
//  Created by UBK on 2018/12/15.
//  Copyright © 2018 UBK. All rights reserved.
//

#import "ViewController.h"
#import "MyThread.h"
@interface ViewController ()

@property(nonatomic,weak)MyThread *myThread;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self runloop1];
    [self runloop2];
}

#pragma mark - 正常情况

-(void)runloop1{
    NSLog(@"%@-----当前线程。开辟子线程",[NSThread currentThread]);
    
    // 正常
    MyThread *subThread = [[MyThread alloc] initWithTarget:self selector:@selector(subThreadTodo1) object:nil];
    subThread.name = @"subThread";
    [subThread start];
}

// 子线程操作(正常)
-(void)subThreadTodo1 {
    NSLog(@"%@----开始执行子线程任务",[NSThread currentThread]);
    // 如果不加runloop，线程在执行完任务后就会自动被释放，打印出“subThread线程被释放了”
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    // 下面这一行必须加，否则RunLoop会执行run后面的内容，无法达到目的
    [runloop addPort:[NSMachPort port] forMode:NSRunLoopCommonModes];
    NSLog(@"runloop:%@",runloop);
    [runloop run];
    // RunLoop本质就是个Event Loop的do while循环，所以运行到这一行以后子线程就一直在进行接受消息->等待->处理的循环。所以不会运行[runLoop run];之后的代码(这点需要注意，在使用RunLoop的时候如果要进行一些数据处理之类的要放在这个函数之前否则写的代码不会被执行)，也就不会因为任务结束导致线程死亡进而销毁。
    NSLog(@"%@----执行子线程任务结束",[NSThread currentThread]);
    
    /*  runloop伪代码
     do {
        1.接收消息
        2.如果没有消息就休息
        3.休息直到接收到了消息，执行消息对应的任务
     } while (消息 != 退出);
     
     */
}

#pragma mark - 测试RunLoop运行的条件

-(void)runloop2{
    NSLog(@"%@-----当前线程。开辟子线程",[NSThread currentThread]);
    MyThread *subThread = [[MyThread alloc] initWithTarget:self selector:@selector(subThreadTodo2) object:nil];
    subThread.name = @"subThread";
    [subThread start];
}

-(void)subThreadTodo2{
    NSLog(@"%@-----开始执行子线程任务",[NSThread currentThread]);
    // 获取当前子线程的runloop
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    // 给runloop添加一个事件源，但是mode不是defaultMode
    //关于这里的[NSMachPort port]我的理解是，给RunLoop添加了一个占位事件源，告诉RunLoop有事可做，让RunLoop运行起来。
    //但是暂时这个事件源不会有具体的动作，而是要等RunLoop跑起来过后等有消息传递了才会有具体动作。
    [runloop addPort:[NSMachPort port] forMode:UITrackingRunLoopMode];
    [runloop run];
    
    NSLog(@"%@-----执行子线程任务结束",[NSThread currentThread]);// 这句执行了，也就是说runloop没有起作用：原因是runloop本应该运行在NSDefaultRunLoopMode下，但是写的mode是 UITrackingRunLoopMode，所以runloop就直接退出了。
    
    // 结论：(runloop运行的条件)
    //      1. 有 Mode
    //      2. mode有事件源
    //      3. 运行在有事件源的Mode下
}

/* 重要知识点
 ①.RunLoop是寄生于线程的消息循环机制，它能保证线程存活，而不是线性执行完任务就消亡。
 
 ②.RunLoop与线程是一一对应的，每个线程只有唯一与之对应的一个RunLoop。我们不能创建RunLoop，只能在当前线程当中获取线程对应的RunLoop（主线程RunLoop除外）。
 
 ③.子线程默认没有RunLoop，需要我们去主动开启，但是主线程是自动开启了RunLoop的。
 
 ④.RunLoop想要正常启用需要运行在添加了事件源的Mode下。
 
 ⑤.RunLoop有三种启动方式run、runUntilDate:(NSDate *)limitDate、runMode:(NSString *)mode beforeDate:(NSDate *)limitDate。第一种无条件永远运行RunLoop并且无法停止，线程永远存在。第二种会在时间到后退出RunLoop，同样无法主动停止RunLoop。前两种都是在NSDefaultRunLoopMode模式下运行。第三种可以选定运行模式，并且在时间到后或者触发了非Timer的事件后退出。
 */

/*
 
 RunLoop 源码
 
 // 创建字典
 CFMutableDictionaryRef dict = CFDictionaryCreateMutable(kCFAllocatorSystemDefault, 0, NULL, &kCFTypeDictionaryValueCallBacks);
 // 创建主线程 根据传入的主线程创建主线程对应的RunLoop
 CFRunLoopRef mainLoop = __CFRunLoopCreate(pthread_main_thread_np());
 // 保存主线程 将主线程-key和RunLoop-Value保存到字典中
 CFDictionarySetValue(dict, pthreadPointer(pthread_main_thread_np()), mainLoop);
 
 */



@end
