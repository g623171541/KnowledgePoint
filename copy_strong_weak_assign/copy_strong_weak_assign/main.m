//
//  main.m
//  copy_strong_weak_assign
//
//  Created by UBK on 2018/11/12.
//  Copyright © 2018 UBK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Copy.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // 测试 Copy
        Copy *copy = [[Copy alloc] init];
        [copy testCopy];
    }
    return 0;
}
