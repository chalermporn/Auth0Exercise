//
//  MyApplication.h
//  Auth0Login
//
//  Created by Weien Wang on 7/5/16.
//  Copyright © 2016 Weien Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class A0Lock;

@interface MyApplication : NSObject
@property (readonly, nonatomic) A0Lock *lock;
+ (MyApplication *)sharedInstance;

@end
