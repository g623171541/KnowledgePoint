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

-(void)updateUIWithData1:(NSString *)data1 data2:(NSString *)data2{
    NSLog(@"收到网络请求的数据，统一更新UI：\n%@\n%@",data1,data2);
}


@end
