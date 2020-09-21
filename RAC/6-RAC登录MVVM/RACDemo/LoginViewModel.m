//
//  LoginViewModel.m
//  RACDemo
//
//  Created by paddygu on 2020/9/21.
//  Copyright © 2020 paddygu. All rights reserved.
//

#import "LoginViewModel.h"

@implementation LoginViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup{
    // 处理登录按钮的点击信号
    _loginBtnEnableSignal = [RACSignal combineLatest:@[RACObserve(self, account), RACObserve(self, pwd)] reduce:^id _Nonnull(NSString *accountStr, NSString *pwdStr){
        return @(accountStr.length && pwdStr.length);
    }];
    
    // 创建命令来处理登录按钮的点击事件
    _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSLog(@"拿到点击事件传递的数据：%@",input);
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            // 在这里处理业务：密码加密 && 发送请求 && 获取登录结果
            NSLog(@"准备发送请求");
            // 用延时代替网络请求
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                // 拿到网络请求的数据后让订阅者发送数据
                NSDictionary *resultDataDic = @{@"login":@YES};
                [subscriber sendNext:resultDataDic];
                [subscriber sendCompleted];// 这样才能监听到命令执行完成
            });
            return nil;
        }];
    }];
    
    // 获取命令中的信号源，订阅信号
    [_loginCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅到的数据：登录请求的结果---%@",x);
    }];
    
    // 监听命令的执行过程，用于显示菊花
    // skip:1 去掉第一次监听到的0
    [[_loginCommand.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        if ([x boolValue]) {
            NSLog(@"正在执行-显示菊花");
            // 显示菊花
        } else {
            NSLog(@"执行完成-取消菊花");
            // 取消菊花
        }
    }];
}

@end
