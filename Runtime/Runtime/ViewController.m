//
//  ViewController.m
//  Runtime
//
//  Created by UBK on 2019/1/25.
//  Copyright © 2019 UBK. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "RuntimeObject.h"
#import <objc/message.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    // 应用1：利用runtime动态添加方法
//    [self initPersonWithRuntime];
    
    // 应用2：使用runtime来实现方法欺骗（方法的交换）
//    [self hookNSURL];
    
    // 应用3：消息转发
    RuntimeObject *objc = [[RuntimeObject alloc] init];
    [objc test];    // test方法只是在.h中声明了并没实现
    
    
    
}

//应用2：使用runtime来实现方法欺骗（方法的交换）
-(void)hookNSURL{
    
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com/中文"];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    NSLog(@"%@",url);   // (null)
    NSLog(@"%@",req);   // <NSURLRequest: 0x600000271100> { URL: (null) }
    /*
     如果URL中包含中文，那创建的 url 为null，也就意味着不能发起正常请求
     怎么去校验这个URL中是否包含中文呢？
        方法1：可以使用分类为 NSURL 添加一个分类，每次使用的时候使用分类方法，需要导入分类头文件
        方法2：⭐️依然添加一个分类，利用runtime的方法欺骗，将URLWithString方法的 imp 改为自己的实现
     */
}

//应用1：利用runtimed动态添加方法
-(void)initPersonWithRuntime{
    Person * p =[[Person alloc] init];
    [p eat];    // eat 在Person.h中只声明了，并没有在.m 中实现，运行将会报错
    
    [p eatObjc:@"汉堡"];
    // 这个方法调用用runtime写就是以下方法
    // objc_msgSend(p,@selector(eatObjc:),@"汉堡");
}


@end
