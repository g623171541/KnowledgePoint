# GCD和NSOperationQueue
GCD-dispatch_async/dispatch_sync

## 串行和并行：
`主要区别在于一个任务的执行是否是以另一个任务的完成为前提。串并行主要关注多个任务之间的依赖关系。`
### 并发和串行决定了任务执行的方式。
    1. 并发：多个任务同时执行。
    2. 串行：一个任务执行完毕后，再执行下一个任务。
## 同步和异步：
`是站在当前线程的角度，考察添加任务到'新'线程后，何时返回到当前线程执行下面代码的问题，也即新添加的线程阻不阻塞当前线程。`
### 同步和异步决定了是否要开辟新线程。
    1. 同步：在当前线程中执行任务，不具备开启新线程的能力。
    2. 异步：在新的线程中执行任务，具备开启新线程的能力。
## GCD（Grand Central Dispatch）和 NSOperationQueue
`都是系统级的多线程封装，在使用时我们只需要创建任务队列即可，其他的如线程创立，任务分配等都是系统自动处理的。`
### GCD：
* GCD是基于C的API，因此比较底层
* GCD所管理的队列主要有三种： 
* * 串行队列（private dispatch queue）
* * 并行队列（global dispatch queue）
  > dispatch_get_global_queue 全局调度队列，并发，是全局共用的，每个优先级的全局调度队列只有一个实体，四中不同优先级的全局调度队列对应四中优先级的线程，同一优先级的队列可以同时拥有多条相应优先级的线程。
* * 主队列（main dispatch queue）
  > dispatch_get_main_queue 主调度队列，串行单线程队列
 
 | GCD |全局并行队列|手动创建串行队列|主队列|
 | --- | --- | --- | --- |
 | 同步|没有开启新线程，串行执行任务|没有开启新线程，串行执行任务|会死锁|
 | 异步|开辟新线程，并行执行任务|开辟新线程，串行执行任务|不开启新线程，串行执行任务|


### NSOperationQueue：
* 是对GCD的Objective-C的封装，并发队列。

## GCD的延时函数：
//延时函数：方式1          ----调用NSObject方法
[self performSelector:@selector(run) withObject:nil afterDelay:2.0];
    
//延时函数：方式2          ----调用GCD函数：异步执行
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [self run];
});


