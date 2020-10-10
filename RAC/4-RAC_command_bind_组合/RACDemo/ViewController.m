//
//  ViewController.m
//  RACDemo
//
//  Created by paddygu on 2020/9/17.
//  Copyright © 2020 paddygu. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <ReactiveObjC/RACReturnSignal.h>

@interface ViewController ()

@property (strong,nonatomic) RACCommand *command;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
        // RACCommand 命令
    //    [self demo1];
        [self demo2];
        
        // 绑定
    //    [self demo3]; // bind
    //    [self demo4]; // flattenMap
        
    //    [self demo5]; // 一般用flattenMap处理信号中的信号
        
        // map映射
    //    [self demo6];
        
        // concat 组合
    //    [self demo7];
        
        // then 忽略掉第一个信号的所有值
    //    [self demo8];
        
        // merge 合并信号，多个信号无序处理
    //    [self demo9];
        
        // zip 压缩信号
    //    [self demo10];
        
        // combineLatest 信号合并
    //    [self demo11];
        
        // filter 过滤
    //    [self demo12];
        
        // ignore 忽略
    //    [self demo13];
        
        // distinctUntilChanged忽略相同的数据
    //    [self demo14];
        
        // take 从开始一共取N次的信号
    //    [self demo15];
        
        // skip 跳过几个信号,不接受
    //    [self demo16];
}

-(void)demo1{
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

-(void)demo2{
    // 1. 创建命令
    _command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
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
    [_command.executing subscribeNext:^(NSNumber * _Nullable x) {
        if ([x boolValue]) {
            NSLog(@"正在执行");
        }else{
            NSLog(@"还没开始执行 || 已经执行结束了");
        }
    }];
    
    // 2. 执行命令
    RACSignal *signal = [_command execute:@"要执行的命令数据"];
    
    // 3. 订阅信号
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"接收到数据：%@",x);
    }];
}

-(void)demo3{
    // 1. 创建信号（源信号）
    RACSubject *subject = [RACSubject subject];
    
    // 2. 绑定信号
    RACSignal *bindSignal = [subject bind:^RACSignalBindBlock {
        // bind的作用就是在这里收到数据后可以对数据进行处理，如字典转模型
        // block的调用：只要源信号发送数据，就会调用bindBlock
        // value：源信号发送的内容
        return ^RACSignal * (id value, BOOL *stop){
            NSLog(@"收到源信号的数据，可以进行处理，源数据如下：%@",value);
            NSString *returnData = [NSString stringWithFormat:@"%@ + new data",value];
            return [RACReturnSignal return:returnData];
        };
    }];
    
    // 3. 订阅信号
    [bindSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅到的信号数据：%@",x);
    }];
    
    // 4. 源信号发送数据
    [subject sendNext:@"send data"];
}

-(void)demo4{
    // 1. 创建信号（源信号）
    RACSubject *subject = [RACSubject subject];
    
    // 2. 绑定信号
    RACSignal *bindSignal = [subject flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
        // block的调用：只要源信号发送数据，就会调用
        // value：源信号发送的内容
        NSLog(@"收到源信号的数据，可以进行处理，源数据如下：%@",value);
        NSString *returnData = [NSString stringWithFormat:@"%@ + new data",value];
        // 返回信号用来包装修改过的内容
        return [RACReturnSignal return:returnData];
    }];
    
    // 3. 订阅信号
    [bindSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅到的信号数据：%@",x);
    }];
    
    // 4. 源信号发送数据
    [subject sendNext:@"send data"];
}

-(void)demo5{
    // 1. 创建信号
    RACSubject *signal = [RACSubject subject];
    RACSubject *subSignal = [RACSubject subject];
    
    // 一般用flattenMap处理信号中的信号
    
    // 2. 绑定信号
    [[signal flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
        // 此时拿到的value就是subSignal
        return value;
    }] subscribeNext:^(id  _Nullable x) {
        // 此时拿到的x就是subSignal发送的数据
        NSLog(@"拿到子信号的数据：%@",x);
    }];
    
    // 3. 信号发送数据
    [signal sendNext:subSignal];
    [subSignal sendNext:@"send data"];
}

-(void)demo6{
    // 1. 创建信号
    RACSubject *subject = [RACSubject subject];
    
    // 2. 绑定
    [[subject map:^id _Nullable(id  _Nullable value) {
        NSLog(@"接收到的数据：%@",value);
        NSString *returnStr = [NSString stringWithFormat:@"处理后的数据：%@",value];
        return returnStr;
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"收到处理后的数据---%@",x);
    }];
    
    // 3. 发送数据
    NSLog(@"发送数据");
    [subject sendNext:@"send data"];
}

-(void)demo7{
    // 组合作用：网络的请求有一个先后顺序的时候，可以先请求A，收到结果后再请求B
    // 1. 创建信号
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"发送请求A");
        // 发送数据
        [subscriber sendNext:@"数据A"];
        // 发送完需要调用发送完成或发送失败，失败后则不请求B
        [subscriber sendCompleted];
//        [subscriber sendError:nil];
        return nil;
    }];
    
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"发送请求B");
        // 发送数据
        [subscriber sendNext:@"数据B"];
        // 发送完需要调用发送完成或发送失败
        [subscriber sendCompleted];
        return nil;
    }];
    
    // 按顺序组合
//    // 组合方式1：适用于两个信号需要组合
//    [[signalA concat:signalB] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"收到数据：%@",x);
//    }];
    
    // 组合方式2：适用于多个信号需要组合
    [[RACSignal concat:@[signalA,signalB]] subscribeNext:^(id  _Nullable x) {
        NSLog(@"收到数据：%@",x);
    }];
}

-(void)demo8{
    // then作用：忽略掉第一个信号的所有值
    // 1. 创建信号
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"发送请求A");
        // 发送数据
        [subscriber sendNext:@"数据A"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"发送请求B");
        // 发送数据
        [subscriber sendNext:@"数据B"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    // then
    /*
     信号依赖：信号B依赖于信号A发送完毕，A的数据发送完毕了忽略掉A的数据，发送B接收B的数据，所以打印结果为：
     发送请求A
     发送请求B
     接收到的数据：数据B
     */
    // 如果信号A没有sendCompleted则只发送了请求A，不会处理信号B
    [[signalA then:^RACSignal * _Nonnull{
        return signalB;
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"接收到的数据：%@",x);
    }];
}

-(void)demo9{
    // merge 合并信号，多个信号无序处理
    // 1. 创建信号
    RACSubject *signalA = [RACSubject subject];
    RACSubject *signalB = [RACSubject subject];
    RACSubject *signalC = [RACSubject subject];
    
    // 2. 组合信号
    [[RACSignal merge:@[signalA,signalB,signalC]] subscribeNext:^(id  _Nullable x) {
        NSLog(@"接收数据：%@",x);
    }];
    
    // 3. 发送数据
    [signalA sendNext:@"A"];
    [signalB sendNext:@"B"];
    [signalC sendNext:@"C"];
    
}

-(void)demo10{
    // zip 压缩信号：多个信号压缩，只有当所有信号都发送出数据，订阅的信号才会接收到数据，会得到一个所有信号数据的元组
    // 1. 创建信号
    RACSubject *signalA = [RACSubject subject];
    RACSubject *signalB = [RACSubject subject];
    RACSubject *signalC = [RACSubject subject];
    
    // 2. 压缩信号
    [[RACSignal zip:@[signalA,signalB,signalC]] subscribeNext:^(id  _Nullable x) {
        // 收到的数据 RACTuple 数据的顺序是根据信号压缩的顺序，而不是发送的顺序
        NSLog(@"接收数据：%@",x);
    }];
    
    // 3. 发送数据
    NSLog(@"发送数据");
    [signalA sendNext:@"A"];
    [signalB sendNext:@"B"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [signalC sendNext:@"C"];
    });
}



-(void)demo11{
    // combineLatest 信号合并
    // 应用场景：登录页面，当输入账号密码后登录按钮才可以点击
    UITextField *accountTF = [UITextField new];
    UITextField *passwordTF = [UITextField new];
    UIButton *loginBtn = [UIButton new];
    
    RACSignal *signal = [RACSignal combineLatest:@[accountTF.rac_textSignal,passwordTF.rac_textSignal] reduce:^id _Nonnull (NSString *accountStr, NSString *pwdStr){
        // reduceBlock是有参数的：是根据组合的信号关联的，必须一一对应
        // (NSString *accountStr, NSString *pwdStr) 这两个参数是手动加上的
        NSLog(@"账号：%@ 密码：%@",accountStr,pwdStr);
        return @(accountStr.length && pwdStr.length);
    }];
    
    // 两种方式都能实现同样的效果
    // 方式1
    // 订阅组合信号
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x); // 收到 YES 或 NO
        loginBtn.enabled = [x boolValue];
    }];
    
    // 方式2
    RAC(loginBtn,enabled) = signal;
}

-(void)demo12{
    // filter 忽略
    UITextField *textFidle;
    // 监听文本框的输入,而且只有大于3个长度的时候才会打印
    [[textFidle.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        return value.length > 3;
    }] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"%@", x);
    }];
}

-(void)demo13{
    // ignore 忽略
    // 1. 创建信号
    RACSubject *signal = [RACSubject subject];
    
    // 2. 忽略一些值 再订阅
    [[signal ignore:@"AAA"] subscribeNext:^(id  _Nullable x) {
        NSLog(@"接收到的数据：%@",x);
    }];
    
    // 3. 发送数据
    [signal sendNext:@"A"];
}

-(void)demo14{
    // 当上一次的值和当前的值有明显的变化就会发出信号，否则会被忽略掉。
    // 在开发中，刷新UI经常使用，只有两次数据不一样才需要刷新
    
    //创建信号
    RACSubject*signal = [RACSubject subject];
    //调用方法后订阅信号
    [[signal distinctUntilChanged] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    [signal sendNext:@"luobo"];
    [signal sendNext:@"luobo"];
    [signal sendNext:@"luobo"];
    [signal sendNext:@"luo"];
}

-(void)demo15{
    // 从开始一共取N次的信号
    
    //创建信号
    RACSubject*subject = [RACSubject subject];
    RACSubject*signal = [RACSubject subject];
    
    // 1. take是取前面的几个值
    [[subject take:2] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    // 2. takeLast:取后面的多少个值，必须是发送完的
    //只有调用[subject sendCompleted];才会发送信号
//    [[subject takeLast:2] subscribeNext:^(id x) {
//        NSLog(@"%@",x);
//    }];
    
    // 3. takeUntil:只要是传入的信号发送完成或者是signal发送信号，就不会接收信号的内容
//    [[signal takeUntil:signal] subscribeNext:^(id x) {
//        NSLog(@"%@",x);
//    }];
    //发送数据
    [subject sendNext:@"1"];
    [subject sendNext:@"2"];
    [subject sendNext:@"3"];
    [subject sendCompleted];
    [signal sendNext:@"signal"];
}

-(void)demo16{
    //创建信号
    RACSubject*subject = [RACSubject subject];
    [[subject skip:2] subscribeNext:^(id x) {//跳跃过两个，执行下面的几个
        NSLog(@"%@", x);
    }];
    [subject sendNext:@"LUO"];
    [subject sendNext:@"1"];
    [subject sendNext:@"3"];
    [subject sendNext:@"4"];
}

@end
