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

@interface ViewController ()

@property (weak, nonatomic) IBOutlet GXDView *gxdView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.gxdView.btnClickSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"接受到的信号为：%@",x);
    }];
}


@end
