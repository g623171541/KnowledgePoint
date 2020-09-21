//
//  LoginViewModel.h
//  RACDemo
//
//  Created by paddygu on 2020/9/21.
//  Copyright © 2020 paddygu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewModel : NSObject

// 引用model数据
@property (nonatomic,strong) NSString *account;
@property (nonatomic,strong) NSString *pwd;

/// 处理登录按钮能否点击的信号
@property (nonatomic,strong) RACSignal *loginBtnEnableSignal;
/// 登录按钮
@property (nonatomic,strong) RACCommand *loginCommand;

@end

NS_ASSUME_NONNULL_END
