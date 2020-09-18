//
//  ViewController.m
//  RACDemo
//
//  Created by paddygu on 2020/9/17.
//  Copyright © 2020 paddygu. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "GXDView.h"
#import "NSObject+RACKVOWrapper.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet GXDView *gxdView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 第一种用法
//    [self demo1];
    
    
    // 第二种方法 代替了代理
//    [self demo2];
    
    // 第三种方法 代替了KVO
//    [self demo3];
    
    // 第四种方法 代替了KVO
//    [self demo4];
    
    // 第五种方法 代替通知
//    [self demo5];
    
    // 第六种方法 监听文本框的输入
//    [self demo6];
    
    // 7. RAC Timer
    [self demo7];
}

-(void)demo1{
    [self.gxdView.btnClickSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"接受到的信号为：%@",x);
    }];
}

-(void)demo2{
    // 第二种用法，可以监听按钮的点击方法，也可以按钮点击后执行的方法click:
    [[self.gxdView rac_signalForSelector:@selector(clickAction:)] subscribeNext:^(RACTuple * _Nullable x) {
        // 接收到一个RACTuple 里面包含方法传递的数据
        NSLog(@"接收到的值 ：%@",x);
        /*
         接收到的值：<RACTuple: 0x6000025e8560> (
             "click something"
         )
         接收到的值 ：<RACTuple: 0x600002e7cc10> (
             "<UIButton: 0x7fac4e4084e0; frame = (89 49; 62 30); opaque = NO; autoresize = RM+BM; layer = <CALayer: 0x600002c2cf40>>"
         )
         */
    }];
}

-(void)demo3{
    // 第三种用法
    // 代替KVO
    // 需要导入 #import "NSObject+RACKVOWrapper.h"
    [self.gxdView rac_observeKeyPath:@"backgroundColor" options:NSKeyValueObservingOptionNew observer:nil block:^(id value, NSDictionary *change, BOOL causedByDealloc, BOOL affectedOnlyLastComponent) {
        NSLog(@"%@",value);
        NSLog(@"%@",change);
    }];
}

-(void)demo4{
    // 第四种用法
    // 代替KVO
    // 监听gxdView的name属性的变化
    [[self.gxdView rac_valuesForKeyPath:@"name" observer:nil] subscribeNext:^(id  _Nullable x) {
        NSLog(@"监听到的变化：%@",x);
    }];
}

-(void)demo5{
    // 第五种用法
    // 代替通知，监听键盘的弹出事件
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardDidShowNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        NSLog(@"监听到的内容：%@",x);
    }];
}

-(void)demo6{
    UITextField *textFidle = [[UITextField alloc] init];
    textFidle.frame = CGRectMake(100, 100, 200, 40);
    textFidle.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:textFidle];

    // 监听文本框的输入,而且只有大于3个长度的时候才会打印
    [[textFidle.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        return value.length > 3;
    }]
    subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"%@", x);
    }];
}

-(void)demo7{
    // RAC Timer 可以与UI同时进行，在拖动TextView时timer不会停
    [[RACSignal interval:1.0 onScheduler:[RACScheduler scheduler]] subscribeNext:^(NSDate * _Nullable x) {
        NSLog(@"%@",[NSThread currentThread]);
    }];
}

@end
