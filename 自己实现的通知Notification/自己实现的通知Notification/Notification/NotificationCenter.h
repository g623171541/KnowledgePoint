//
//  NotificationCenter.h
//  自己实现的通知Notification
//
//  Created by UBK on 2019/2/15.
//  Copyright © 2019 UBK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Notification.h"

NS_ASSUME_NONNULL_BEGIN

@interface NotificationCenter : NSObject

// 全局的字典用来保存通知的信息,结构如下
//  {
//    @"notificationName":@[
//                          notification1,
//                          notification2
//                          ]
//  }
@property (nonatomic,strong) NSMutableDictionary *observerDicM;
@property (nonatomic,strong) NSLock *lock;

// 单例
+(instancetype)defaultCenter;

// 发送通知
-(void)postNotification:(Notification *)notification;
-(void)postNotificationWithName:(NSString *)notificationName object:(nullable id)object userInfo:(nullable NSDictionary *)userInfo;

// 添加观察者
-(void)addObserver:(id)observer selector:(nonnull SEL)aSelector name:(nullable NSString *)aName object:(nullable id)anObject;

// 移除观察者
-(void)removeObserver:(id)observer;

@end

NS_ASSUME_NONNULL_END
