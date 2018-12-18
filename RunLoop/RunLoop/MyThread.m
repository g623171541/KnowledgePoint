//
//  MyThread.m
//  RunLoop
//
//  Created by UBK on 2018/12/15.
//  Copyright © 2018 UBK. All rights reserved.
//

#import "MyThread.h"

@implementation MyThread

-(void)dealloc{
    NSLog(@"%@线程被释放了",self.name);
}

@end
