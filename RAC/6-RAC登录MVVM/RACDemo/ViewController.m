//
//  ViewController.m
//  RACDemo
//
//  Created by paddygu on 2020/9/17.
//  Copyright © 2020 paddygu. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "LoginViewModel.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (strong,nonatomic) LoginViewModel *loginVM;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loginVM = [[LoginViewModel alloc] init];
    // 1. 给VM的model绑定信号，实时更新数据
    RAC(self.loginVM,account) = self.accountTF.rac_textSignal;
    RAC(self.loginVM,pwd) = self.passwordTF.rac_textSignal;
    
    // 2. 绑定登录按钮的enable属性
    RAC(self.loginBtn,enabled) = self.loginVM.loginBtnEnableSignal;
    
    // 3. 监听登录按钮的点击
    [[_loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"点击了登录按钮，button：%@",x);
        // 这时处理登录事件，执行登录命令
        [self.loginVM.loginCommand execute:@{@"account":self.accountTF.text,@"pwd":self.passwordTF.text}];
    }];
    
}


@end
