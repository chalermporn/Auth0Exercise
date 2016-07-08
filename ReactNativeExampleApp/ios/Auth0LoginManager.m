//
//  RCTLoginManager.m
//  Auth0Login
//
//  Created by Weien Wang on 7/7/16.
//  Copyright © 2016 Weien Wang. All rights reserved.
//

#import "Auth0LoginManager.h"
#import "Auth0Login.h"

@implementation Auth0LoginManager

RCT_EXPORT_MODULE()
- (UIView *)view {
    return [[Auth0Login alloc] init];
}

@end
