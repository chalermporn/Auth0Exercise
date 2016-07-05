//
//  MyApplication.m
//  Auth0Login
//
//  Created by Weien Wang on 7/5/16.
//  Copyright © 2016 Weien Wang. All rights reserved.
//

#import "MyApplication.h"
#import <Lock/Lock.h>

@implementation MyApplication
+ (MyApplication*)sharedInstance {
    static MyApplication *sharedApplication = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedApplication = [[self alloc] init];
    });
    return sharedApplication;
}

- (id)init {
    self = [super init];
    if (self) {
        _lock = [A0Lock newLock];
    }
    return self;
}

@end
