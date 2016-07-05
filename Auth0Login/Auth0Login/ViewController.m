//
//  ViewController.m
//  Auth0Login
//
//  Created by Weien Wang on 7/4/16.
//  Copyright © 2016 Weien Wang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    {{ //get token
        NSString* nonce = [[NSUUID UUID] UUIDString]; //random string
        NSString* authorizeString = [NSString stringWithFormat:@"https://weien.auth0.com/authorize/?response_type=token&client_id=tSKVxuMzRm4MfmnnXD1E85JONlnEgHW8&redirect_uri=a0tSKVxuMzRm4MfmnnXD1E85JONlnEgHW8://weien.auth0.com/authorize&state=VALUE_THAT_SURVIVES_REDIRECTS&nonce=%@&scope=openid", nonce];
        NSURL* authorizeURL = [NSURL URLWithString:authorizeString];
        
        UIWebView *webview = [[UIWebView alloc] initWithFrame:CGRectZero];
        webview.frame = self.view.frame;
        webview.delegate = self;
        [self.view addSubview:webview];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:authorizeURL];
        [webview loadRequest:request];
    }}
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSURL* url = request.URL;
    NSString *queryString = url.query ?: url.fragment;
    NSLog(@"QueryString is %@", queryString);
    
    return YES;
}

@end
