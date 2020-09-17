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
    NSLog(@"点击了按钮，发送信号");
    [self.btnClickSignal sendNext:@"信号"];
}


@end
