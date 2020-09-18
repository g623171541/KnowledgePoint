//
//  ViewController.m
//  RACDemo
//
//  Created by paddygu on 2020/9/17.
//  Copyright © 2020 paddygu. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    // 作用：多个信号发送完毕后再调用某个方法，有点类似于线程组，多个请求回来后再更新UI
//    [self demo1];
    
//    // 作用：一个网络请求的结果多个地方使用
//    [self demo2];

    // RACCommand 命令
    [self demo3];
//    [self demo4];
}

-(void)updateUIWithData1:(NSString *)data1 data2:(NSString *)data2{
    NSLog(@"收到网络请求的数据，统一更新UI：\n%@\n%@",data1,data2);
}

-(void)demo1{
    // 作用：多个信号发送完毕后再调用某个方法，有点类似于线程组，多个请求回来后再更新UI
    
    // 信号1
    RACSignal *signal1 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        // 发送请求
        NSLog(@"发送请求1");
        // 发送信号
        [subscriber sendNext:@"网络请求回来的数据 1"];
        return nil;
    }];
    
    // 信号2
    RACSignal *signal2 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        // 发送请求
        NSLog(@"发送请求2");
        // 发送信号
        [subscriber sendNext:@"网络请求回来的数据 2"];
        return nil;
    }];
    
    // 当数组中的信号都被执行完毕后才会执行selector方法
    // 数组用来存放信号，rac_liftSelector方法自动帮我们订阅了信号，这个方法任意对象都可以调用
    // !!!: selector方法的参数必须和数组的信号一一对应
    [self rac_liftSelector:@selector(updateUIWithData1:data2:) withSignalsFromArray:@[signal1,signal2]];
}

-(void)demo2{
    // 1. 创建信号：多次订阅同一个信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        // 发送请求
        NSLog(@"发送网络请求");
        // 发送信号
        [subscriber sendNext:@"json数据"];
        return nil;
    }];
    
    // 不管订阅多少次，都只会发送一次网络请求
    // RACMulticastConnection 这个类必须由信号来创建
    // 2. 将信号转成连接类：RACMulticastConnection
    RACMulticastConnection *connection = [signal publish];
    
    // 3. 订阅连接类的信号
    [connection.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"A处处理数据---网络请求下来的数据：%@",x);
    }];
    [connection.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"B处处理数据---网络请求下来的数据：%@",x);
    }];
    
    // 4. 连接
    [connection connect];
}

-(void)demo3{
    // 1. 创建命令
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSLog(@"创建命令的Block --- 命令：%@",input);
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            // 发送数据
            [subscriber sendNext:@"执行完命令之后产生的数据"];
            return nil;
        }];
    }];
    
    // 2. 执行命令
    RACSignal *signal = [command execute:@"要执行的命令数据"];
    
    // 3. 订阅信号
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}

-(void)demo4{
    // 1. 创建命令
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSLog(@"创建命令的Block --- 命令：%@",input);
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            // 发送数据
            [subscriber sendNext:@"执行完命令之后产生的数据"];
            // 如果使用命令，则需要在发送完数据后告诉命令发送完成了
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    
    // 监听事件有没有执行完毕
    [command.executing subscribeNext:^(NSNumber * _Nullable x) {
        if ([x boolValue]) {
            NSLog(@"正在执行");
        }else{
            NSLog(@"还没开始执行 || 已经执行结束了");
        }
    }];
    
    // 2. 执行命令
    RACSignal *signal = [command execute:@"要执行的命令数据"];
    
    // 3. 订阅信号
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"接收到数据：%@",x);
    }];
}




@end
