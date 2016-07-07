//
//  WWUtil.h
//  Auth0Login
//
//  Created by Weien Wang on 7/6/16.
//  Copyright © 2016 Weien Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WWUtil : NSObject
+ (instancetype)sharedInstance;
- (void) submitPOST:(NSString*)post toURL:(NSString*)url withCallback:(void (^)(NSString* errorText))callback;
- (UIFont*) currentMainFontWithSize:(float)size;
- (UIFont*) currentBoldFontWithSize:(float)size;
@end
