//
//  WWUtil.m
//  Auth0Login
//
//  Created by Weien Wang on 7/6/16.
//  Copyright © 2016 Weien Wang. All rights reserved.
//

#import "WWUtil.h"

@implementation WWUtil

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken = 0;
    
    __strong static id _sharedObject = nil;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

@end
