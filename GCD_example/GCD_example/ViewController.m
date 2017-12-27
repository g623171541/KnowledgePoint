//
//  ViewController.m
//  GCD_example
//
//  Created by PaddyGu on 2017/11/16.
//  Copyright © 2017年 PaddyGu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createSerialQueue];           //GCD创建同步队列
    
    [self createConcurrentQueue];       //GCD创建异步队列
    
    [self createMainQueue];             //GCD创建主队列：不管同步异步，在主队列中添加任务都不能执行
    
    [self testDispatchQueue];           //创建全局队列
    
    [self delay];                       //延时函数
    
    [self dispatchGroup];               //分组，调度组
}

-(void)testDispatchQueue{
    //全局队列本质上还是并行队列
    /*  全局队列与并发队列的区别：
     1.  全局队列没有名字，并发队列有名字
     2.  全局队列是提供给所有的应用程序使用的
     3.  在MRC中，全局队列不需要释放，而并发队列需要释放
     
     DISPATCH_QUEUE_PRIORITY_HEGH    2 高优先级
     DISPATCH_QUEUE_PRIORITY_DEFAULT  0 默认优先级
     DISPATCH_QUEUE_PRIORITY_LOW   (-2) 低优先级
     DISPATCH_QUEUE_PRIORITY_BACKGROUND    INT16_MIN 后台优先级（最低）
     */
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSLog(@"----------A-------------\n");               // 1
        
    });
    
    NSLog(@"----------B-------------\n");                   // 2
    
    while(true) { }                                         // 3
    NSLog(@"---------C-------------\n");                     // 4
    //因为3是一个死循环，4不会被执行
    
    /*
     A和D的先后顺序及分析：
     queue 是 系统全局队列，DISPATCH_QUEUE_PRIORITY_DEFAULT（优先级）为默认的；
     1是添加到系统全局队列中的任务，由于是异步（dispatch_async）的，因此任务1添加到全局队列后，会在一个新的线程上执行，不等到执行完成就返回到当前主线程来执行2及其以后代码（其中2 是在主线程上执行的）；
     结果是1和2 是在不同的线程上同时执行的，所以1和2谁先执行输出不一定；
     由于1和2 都是不耗时的简单任务，并且1需要创建新的线程而2不需要（主线程一直存在不用创建），所以一般输出结果为 B A。
     
     
     串行和并行：
     主要区别在于一个任务的执行是否是以另一个任务的完成为前提。串并行主要关注多个任务之间的依赖关系。
     
     同步和异步：
     是站在当前线程的角度，考察添加任务到'新'线程后，何时返回到当前线程执行下面代码的问题，也即新添加的线程阻不阻塞当前线程。
     
     GCD（Grand Central Dispatch）和 NSOperationQueue
     都是系统级的多线程封装，在使用时我们只需要创建任务队列即可，其他的如线程创立，任务分配等都是系统自动处理的。
     
     GCD：
     GCD是基于C的API，因此比较底层
     GCD所管理的队列主要有三种： 串行队列（private dispatch queue）
     并行队列（global dispatch queue）
     主队列（main dispatch queue）
     dispatch_get_global_queue 全局调度队列，并发，是全局共用的，每个优先级的全局调度队列只有一个实体，四中不同优先级的全局调度队列对应四中优先级的线程，同一优先级的队列可以同时拥有多条相应优先级的线程。
     dispatch_get_main_queue 主调度队列，串行单线程队列
     
     NSOperationQueue：
     是对GCD的Objective-C的封装，并发队列。
     
     */
}

-(void)createSerialQueue{
    //创建串行队列："gxd":队列标签   DISPATCH_QUEUE_SERIAL:队列属性
    dispatch_queue_t queue = dispatch_queue_create("gxd", DISPATCH_QUEUE_SERIAL);
    
    dispatch_sync(queue, ^{
        //同步执行任务，不会开辟新线程，在当前线程中执行
        NSLog(@"%@",[NSThread currentThread]);
    });
    
    for (int i=0; i<10; i++) {
        dispatch_async(queue, ^{
            //异步执行任务，在开辟的新线程中执行。开辟新线程的数量与队列模式有关，串行队列中异步执行的时候只会创建一个线程。
            NSLog(@"%d",i);
            NSLog(@"%@",[NSThread currentThread]);
        });
    }
}

-(void)createConcurrentQueue{
    //创建并行队列：
    dispatch_queue_t queue = dispatch_queue_create("gxd", DISPATCH_QUEUE_CONCURRENT);
    
    for (int i=0; i<10; i++) {
        //异步执行任务，开辟新线程，每个任务在新线程中执行，新线程开辟的数量程序无法控制
        dispatch_async(queue, ^{
            NSLog(@"%d",i);
            NSLog(@"%@",[NSThread currentThread]);
        });
    }
    
    
    for (int i=0; i<10; i++) {
        //同步执行任务，不开辟新线程，都在当前线程执行（主线程）
        dispatch_sync(queue, ^{
            NSLog(@"%@",[NSThread currentThread]);
        });
    }
}

-(void)createMainQueue{
    //创建主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    //不会被执行，
    dispatch_async(queue, ^{
        NSLog(@"%@",[NSThread currentThread]);
    });
    
    //不能在主线程上同步执行任务
    //    dispatch_sync(queue, ^{   //这个执行直接崩溃EXC_BAD_INSTRUCTION 内存泄漏
    //        NSLog(@"%@",[NSThread currentThread]);
    //    });
    
}

-(void)delay{
    //延时函数：方式1          ----调用NSObject方法
    [self performSelector:@selector(run) withObject:nil afterDelay:2.0];
    
    //延时函数：方式2          ----调用GCD函数：异步执行
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self run];
    });
}
-(void)run{}

//分组，调度组
-(void)dispatchGroup{
    //创建一个调度组
    dispatch_group_t group = dispatch_group_create();
    //创建一个队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //将任务添加到队列
    dispatch_async(queue, ^{
        NSLog(@"A %@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"B %@",[NSThread currentThread]);
    });
    //获得调度组里面的异步任务完成的通知，在这个通知里可以跨队列通信
    dispatch_group_notify(group, queue, ^{
        NSLog(@"完成了");
    });
}


@end
