//
//  WWUtil.m
//  Auth0Login
//
//  Created by Weien Wang on 7/6/16.
//  Copyright © 2016 Weien Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
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

- (void) submitPOST:(NSString*)post toURL:(NSString*)url withCallback:(void (^)(BOOL success))callback {
    NSData* postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString* postLength = [@([postData length]) stringValue];
    
    NSMutableURLRequest* request = [NSMutableURLRequest new];
    request.URL = [NSURL URLWithString:url];
    request.HTTPMethod = @"POST";
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    request.HTTPBody = postData;
    
    NSURLSession* urlSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[urlSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        NSLog(@"RequestReply: %@, Response: %@, Error: %@", requestReply, response, error);
        callback(YES);
    }] resume];
}

- (UIFont*) currentMainFontWithSize:(float)size {
    return [UIFont fontWithName:@"Avenir Next" size:size];
}

- (UIFont*) currentBoldFontWithSize:(float)size {
    return [UIFont fontWithName:@"AvenirNext-DemiBold" size:size];
}

@end
