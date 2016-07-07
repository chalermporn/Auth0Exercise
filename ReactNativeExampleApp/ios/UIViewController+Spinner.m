//
//  UIViewController+Spinner.m
//  Auth0Login
//
//  Created by Weien Wang on 7/6/16.
//  Copyright © 2016 Weien Wang. All rights reserved.
//

#import "UIViewController+Spinner.h"
@implementation UIView (Spinner)
- (UIActivityIndicatorView *)startSpinner:(UIActivityIndicatorView *)spinner inView:(UIView *)view {
    if (!spinner) {
        spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        spinner.hidesWhenStopped = YES;
    }
    UIView* desiredSuperview = view;
    if (view.superview) {
        desiredSuperview = view.superview;
    }
    [desiredSuperview addSubview:spinner];
    spinner.center = CGPointMake(view.center.x, view.center.y);
    
    [spinner startAnimating];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    return spinner;
}

- (void) stopSpinner:(UIActivityIndicatorView*)spinner {
    [spinner stopAnimating];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
@end

@implementation UIViewController (Spinner)

- (UIActivityIndicatorView*) startSpinner:(UIActivityIndicatorView*)spinner inView:(UIView*)view {
    if (!spinner) {
        spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        spinner.hidesWhenStopped = YES;
    }
    UIView* desiredSuperview = view;
    if (view.superview) {
        desiredSuperview = view.superview;
    }
    [desiredSuperview addSubview:spinner];
    spinner.center = view.center;
    [spinner startAnimating];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    return spinner;
}

- (void) stopSpinner:(UIActivityIndicatorView*)spinner {
    [spinner stopAnimating];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end
