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

@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (assign,nonatomic) NSInteger time;    // 倒计时10秒
@property (strong,nonatomic) RACDisposable *disposable;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)clickBtn:(id)sender {
    // 改变按钮的状态使其不可点击
    self.btn.enabled = NO;
    // 设置倒计时
    self.time = 10;
    // 每秒更新UI
    self.disposable = [[RACSignal interval:1.0 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDate * _Nullable x) {
        self->_time --;
        NSString *text = self->_time > 0 ? [NSString stringWithFormat:@"请等待%ld秒",(long)self->_time] : @"重新发送";
        [self->_btn setTitle:text forState:self->_time>0?UIControlStateDisabled:UIControlStateNormal];
        if (self.time>0) {
            self.btn.enabled = NO;
        }else{
            self.btn.enabled = YES;
            // 取消订阅
            [self.disposable dispose];
        }
    }];
}

@end
