//
//  Notification.m
//  自己实现的通知Notification
//
//  Created by UBK on 2019/2/15.
//  Copyright © 2019 UBK. All rights reserved.
//

#import "Notification.h"

@implementation Notification

-(instancetype)initWithName:(NSString *)notificationName object:(nullable id)object userInfo:(nullable NSDictionary *)userInfo{
    self = [super init];
    if (self) {
        self.notificationName = notificationName;
        self.object = object;
        self.userInfo = userInfo;
    }
    return self;
}

+ (instancetype)notificationWithName:(NSString *)notificationName object:(id)object userInfo:(NSDictionary *)userInfo{
    return [[self alloc] initWithName:notificationName object:object userInfo:userInfo];
}

@end
