//
//  ViewController.m
//  RACDemo
//
//  Created by paddygu on 2020/9/17.
//  Copyright © 2020 paddygu. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "RACReturnSignal.h"
#import "ViewController2.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"222222" object:nil];
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 100, 50);
    button.center = self.view.center;
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    RACSubject *subject = [RACSubject subject];
        RACSubject *subject2 = [RACSubject subject];
        [[subject takeUntil:subject2] subscribeNext:^(id x) {
            NSLog(@"%@", x);
        }];
        // 发送信号
        [subject sendNext:@1];
        [subject sendNext:@2];
        [subject2 sendNext:@3];  // 1
    //    [subject2 sendCompleted]; // 或2
        [subject sendNext:@4];

    
}

-(void)click{
    __block NSInteger i = 0;
    ViewController2 *vc = [[ViewController2 alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
//    [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        i++;
//        vc.index = [NSString stringWithFormat:@"%ld",(long)i];
//    }];
}


@end
