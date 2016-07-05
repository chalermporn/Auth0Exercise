//
//  AppDelegate.m
//  Auth0Login
//
//  Created by Weien Wang on 7/4/16.
//  Copyright © 2016 Weien Wang. All rights reserved.
//

#import "AppDelegate.h"
#import <Lock/Lock.h>
#import "MyApplication.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    A0Lock *lock = [[MyApplication sharedInstance] lock];
    [lock applicationLaunchedWithOptions:launchOptions];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    A0Lock *lock = [[MyApplication sharedInstance] lock];
    return [lock handleURL:url sourceApplication:sourceApplication];
}

@end
