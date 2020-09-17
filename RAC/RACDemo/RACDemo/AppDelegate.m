//
//  AppDelegate.m
//  RACDemo
//
//  Created by paddygu on 2020/9/17.
//  Copyright © 2020 paddygu. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setRootViewController:[[ViewController alloc]init]];
    [self.window makeKeyAndVisible];
    return YES;
}



@end
