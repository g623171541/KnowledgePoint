//
//  ViewController.m
//  Runtime
//
//  Created by UBK on 2019/1/25.
//  Copyright © 2019 UBK. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/message.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 利用runtime进行消息转发
    Person * p =[[Person alloc] init];
    [p eat];    // eat 在Person.h中只声明了，并没有在.m 中实现，运行将会报错
    
    [p eatObjc:@"汉堡"];
    // 这个方法调用用runtime写就是以下方法
    // objc_msgSend(p,@selector(eatObjc:),@"汉堡");
    
    
}


@end
