//
//  Person.h
//  Runtime
//
//  Created by UBK on 2019/1/25.
//  Copyright © 2019 UBK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//------------------------------------------- 动态添加方法

@interface Person : NSObject

// 无参数
-(void)eat;

// 有参数
-(void)eatObjc:(NSString *)objc;

@end

NS_ASSUME_NONNULL_END
