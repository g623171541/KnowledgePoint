//
//  Notification.h
//  自己实现的通知Notification
//
//  Created by UBK on 2019/2/15.
//  Copyright © 2019 UBK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Notification : NSObject

@property(nonatomic,strong) NSString *notificationName;
@property(nonatomic,strong) id observer;
@property(nonatomic,assign) SEL selector;
@property(nonatomic,strong) id object;
@property(nonatomic,strong) NSDictionary *userInfo;

-(instancetype)initWithName:(NSString *)notificationName object:(nullable id)object userInfo:(nullable NSDictionary *)userInfo;

+(instancetype)notificationWithName:(NSString *)notificationName object:(nullable id)object userInfo:(nullable NSDictionary *)userInfo;

@end

NS_ASSUME_NONNULL_END
