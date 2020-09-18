//
//  GXDView.m
//  RACDemo
//
//  Created by paddygu on 2020/9/17.
//  Copyright © 2020 paddygu. All rights reserved.
//

#import "GXDView.h"

@implementation GXDView

// 懒加载
-(RACSubject *)btnClickSignal{
    if (!_btnClickSignal) {
        _btnClickSignal = [RACSubject subject];
    }
    return _btnClickSignal;
}

- (IBAction)clickAction:(id)sender {
    // 第一种用法
//    NSLog(@"点击了按钮，发送信号");
//    [self.btnClickSignal sendNext:@"信号"];
    
    // 第二种用法
//    [self click:@"click something"];
    
    // 第三种用法
//    self.backgroundColor = [UIColor redColor];
    
    // 第四种方法
    self.name = @"gxd";
}

-(void)click:(NSString *)str{
    NSLog(@"click方法执行---%@",str);
}


@end
