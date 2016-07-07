//
//  UIViewController+Spinner.h
//  Auth0Login
//
//  Created by Weien Wang on 7/6/16.
//  Copyright © 2016 Weien Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Commonality)
- (UIActivityIndicatorView*) startSpinner:(UIActivityIndicatorView*)spinner inView:(UIView*)view;
- (void) stopSpinner:(UIActivityIndicatorView*)spinner;
@end

@interface UIViewController (Spinner)
- (UIActivityIndicatorView*) startSpinner:(UIActivityIndicatorView*)spinner inView:(UIView*)view;
- (void) stopSpinner:(UIActivityIndicatorView*)spinner;
@end
