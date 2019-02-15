//
//  NotificationCenter.m
//  自己实现的通知Notification
//
//  Created by UBK on 2019/2/15.
//  Copyright © 2019 UBK. All rights reserved.
//

#import "NotificationCenter.h"


@implementation NotificationCenter

#pragma mark - 单例
+ (instancetype)defaultCenter{
    static NotificationCenter *defaultCenter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultCenter = [[NotificationCenter alloc] init];
        defaultCenter.observerDicM = [NSMutableDictionary dictionary];
        defaultCenter.lock = [[NSLock alloc] init];
    });
    return defaultCenter;
}

#pragma mark - 发送通知
-(void)postNotification:(Notification *)notification{
    [self postNotificationWithName:notification.notificationName object:notification.object userInfo:notification.userInfo];
}

-(void)postNotificationWithName:(NSString *)notificationName object:(id)object userInfo:(NSDictionary *)userInfo{
    
    Notification *notification = [[Notification alloc] init];
    notification.notificationName = notificationName;
    notification.object = object;
    notification.userInfo = userInfo;
    
    // 保证线程安全
    [self.lock lock];
    if (![self.observerDicM objectForKey:notificationName]) {
        NSMutableArray *arr = [NSMutableArray arrayWithObject:notification];
        [self.observerDicM setObject:arr forKey:notificationName];
    }else{
        NSMutableArray *arrM = [self.observerDicM[notificationName] mutableCopy];
        [arrM addObject:notification];
        [self.observerDicM setObject:arrM forKey:notificationName];
    }
    [self.lock unlock];
    
}

#pragma mark - 添加观察者
-(void)addObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject{
    // 取出当前保存的通知
    NSMutableArray *observers = [self.observerDicM[aName] mutableCopy];
    // 不存在直接return
    if (!observers) {
        return;
    }
    
    [self.lock lock];
    // 遍历通知数组
    [observers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ((Notification *)obj).observer = observer;
        ((Notification *)obj).selector = aSelector;
        ((Notification *)obj).object = anObject;
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        // 对观察者的方法进行响应
        [observer performSelector:aSelector withObject:anObject];
#pragma clang diagnostic pop
        
    }];
    
    // 更新
    [self.observerDicM setObject:observers forKey:aName];
    [self.lock unlock];
    
}

#pragma mark - 移除观察者
-(void)removeObserver:(id)observer{
    NSArray *keys = [self.observerDicM allKeys];
    [self.lock lock];
    [keys enumerateObjectsUsingBlock:^(id  _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableArray *arrM = self.observerDicM[key];
        [arrM enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([(Notification *)obj observer] == observer) {
                [arrM removeObject:obj];
                [self.observerDicM setObject:arrM forKey:key];
            }
        }];
    }];
    [self.lock unlock];
}

@end
