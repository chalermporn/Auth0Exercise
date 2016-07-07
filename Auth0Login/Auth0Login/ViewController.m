//
//  ViewController.m
//  Auth0Login
//
//  Created by Weien Wang on 7/4/16.
//  Copyright © 2016 Weien Wang. All rights reserved.
//

#import "ViewController.h"
#import "Auth0Login.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Auth0Login* login = [[[NSBundle mainBundle] loadNibNamed:@"Auth0Login" owner:self options:nil] lastObject];
    login.frame = self.view.frame;
    login.parentVC = self;
    [self.view addSubview:login];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
