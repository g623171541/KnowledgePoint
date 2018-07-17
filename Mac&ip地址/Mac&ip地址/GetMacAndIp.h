//
//  GetMacAndIp.h
//  Mac&ip地址
//
//  Created by PaddyGu on 2018/7/17.
//  Copyright © 2018年 paddygu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <ifaddrs.h>
#import <resolv.h>
#import <arpa/inet.h>
#import <net/if.h>
#import <netdb.h>
#import <netinet/ip.h>
#import <net/ethernet.h>
#import <net/if_dl.h>

#define MDNS_PORT       5353
#define QUERY_NAME      "_apple-mobdev2._tcp.local"
#define DUMMY_MAC_ADDR  @"02:00:00:00:00:00"
#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

@interface GetMacAndIp : NSObject

// 获取设备当前网络IP地址
- (NSString *)getIPAddress:(BOOL)preferIPv4;
// 获取设备物理地址
- (nullable NSString *)getMacAddress;

@end
