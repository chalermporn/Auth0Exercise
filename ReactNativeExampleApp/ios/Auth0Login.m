//
//  Auth0Login.m
//  Auth0Login
//
//  Created by Weien Wang on 7/7/16.
//  Copyright © 2016 Weien Wang. All rights reserved.
//

#import "Auth0Login.h"
#import "UIColor+Custom.h"
#import "WWUtil.h"
#import "UIViewController+Spinner.h"

@interface Auth0Login() <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIView *wholeViewContainer;
@property (strong, nonatomic) IBOutlet UIView *headerContainer;
@property (strong, nonatomic) IBOutlet UIImageView *headerImage;
@property (strong, nonatomic) IBOutlet UILabel *headerText;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UILabel *passwordLabel;
@property (strong, nonatomic) IBOutlet UITextField *usernameField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UIButton *sendButton;
@property (strong, nonatomic) IBOutlet UIView *footerLine;
@property (strong, nonatomic) IBOutlet UIButton *rightFooterButton;
@property (strong, nonatomic) IBOutlet UIButton *leftFooterButton;
@property (strong, nonatomic) IBOutlet UIButton *passwordlessButton;

@property (strong, nonatomic) UIAlertController* alertController;
@property (strong, nonatomic) NSString* emailForPasswordless;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *sendButtonYConstraint;
@property (strong, nonatomic) UIActivityIndicatorView* spinner;

@end

@implementation Auth0Login

- (id)init {
  self = [super init];
  if (self) {
    WWUtil* util = [WWUtil sharedInstance];
    
    self.wholeViewContainer = [UIView new];
    self.wholeViewContainer.backgroundColor = [UIColor whiteColor];
    self.headerContainer = [UIView new];
    self.headerContainer.backgroundColor = [UIColor grayColorDarkBackground];
    self.headerImage = [UIImageView new];
    [self.headerImage setImage:[UIImage imageNamed:@"Auth0Badge"]];
    self.headerText = [UILabel new];
    self.headerText.text = NSLocalizedString(@"Welcome! Please log in.", nil);
    self.headerText.textColor = [UIColor whiteColor];
    self.headerText.font = [util currentMainFontWithSize:14];
    self.usernameLabel = [UILabel new];
    self.usernameLabel.text = NSLocalizedString(@"Username", nil);
    self.usernameLabel.textColor = [UIColor blackColorText];
    self.usernameLabel.font = [util currentMainFontWithSize:14];
    self.usernameLabel.textAlignment = NSTextAlignmentRight;
    self.passwordLabel = [UILabel new];
    self.passwordLabel.text = NSLocalizedString(@"Password", nil);
    self.passwordLabel.textColor = [UIColor blackColorText];
    self.passwordLabel.font = [util currentMainFontWithSize:14];
    self.passwordLabel.textAlignment = NSTextAlignmentRight;
    self.usernameField = [UITextField new];
    self.usernameField.delegate = self;
    self.usernameField.font = [util currentMainFontWithSize:14];
    self.usernameField.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordField = [UITextField new];
    self.passwordField.delegate = self;
    self.passwordField.font = [util currentMainFontWithSize:14];
    self.passwordField.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordField.secureTextEntry = YES;
    self.sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.sendButton setTitle:NSLocalizedString(@"SUBMIT", nil) forState:UIControlStateNormal];
    self.sendButton.backgroundColor = [UIColor redColorSuccess];
    [self.sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.sendButton.titleLabel.font = [util currentBoldFontWithSize:14];
    self.sendButton.layer.cornerRadius = 3;
    self.footerLine = [UIView new];
    self.footerLine.backgroundColor = [UIColor grayColorLightText];
    self.rightFooterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightFooterButton setTitle:NSLocalizedString(@"RECOLOR!", nil) forState:UIControlStateNormal];
    self.rightFooterButton.backgroundColor = [UIColor blueColorPrimary];
    [self.rightFooterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.rightFooterButton.titleLabel.font = [util currentBoldFontWithSize:14];
    self.rightFooterButton.layer.cornerRadius = 3;
    [self.rightFooterButton addTarget:self action:@selector(rightFooterButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    self.leftFooterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.leftFooterButton setTitle:NSLocalizedString(@"RESIZE!", nil) forState:UIControlStateNormal];
    self.leftFooterButton.backgroundColor = [UIColor blueColorPrimary];
    [self.leftFooterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.leftFooterButton.titleLabel.font = [util currentBoldFontWithSize:14];
    self.leftFooterButton.layer.cornerRadius = 3;
    [self.leftFooterButton addTarget:self action:@selector(leftFooterButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    self.passwordlessButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.passwordlessButton setTitle:NSLocalizedString(@"Or, tap here to go PASSWORDLESS -- just enter your email to sign up or log in.", nil) forState:UIControlStateNormal];
    self.passwordlessButton.backgroundColor = [UIColor redColorSuccess];
    [self.passwordlessButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.passwordlessButton.titleLabel.font = [util currentBoldFontWithSize:14];
    self.passwordlessButton.layer.cornerRadius = 3;
    [self.passwordlessButton.titleLabel setTextAlignment: NSTextAlignmentCenter];
    self.passwordlessButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.passwordlessButton addTarget:self action:@selector(passwordlessButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.wholeViewContainer];
    [self.wholeViewContainer addSubview:self.headerContainer];
    [self.headerContainer addSubview:self.headerImage];
    [self.headerContainer addSubview:self.headerText];
    [self.wholeViewContainer addSubview:self.usernameLabel];
    [self.wholeViewContainer addSubview:self.usernameField];
    [self.wholeViewContainer addSubview:self.passwordLabel];
    [self.wholeViewContainer addSubview:self.passwordField];
    [self.wholeViewContainer addSubview:self.sendButton];
    [self.wholeViewContainer addSubview:self.footerLine];
    [self.wholeViewContainer addSubview:self.rightFooterButton];
    [self.wholeViewContainer addSubview:self.leftFooterButton];
    [self.wholeViewContainer addSubview:self.passwordlessButton];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard:)];
    [self addGestureRecognizer:tap];
    
    self.alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    [self.alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil) style:UIAlertActionStyleDefault handler:NULL]];
  }
  return self;
}

- (void)layoutSubviews {
  //sure don't miss manual layouts
  self.wholeViewContainer.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
  self.headerContainer.frame = CGRectMake(0, 20, CGRectGetWidth(self.frame), 80);
  self.headerImage.frame = CGRectMake(36, 24, 28, 32);
  self.headerText.frame = CGRectMake(36+28+12, 24, 200, 32);
  self.usernameLabel.frame = CGRectMake(24, CGRectGetMaxY(self.headerContainer.frame)+24, 72, 30);
  self.passwordLabel.frame = CGRectMake(24, CGRectGetMaxY(self.usernameLabel.frame)+12, 72, 30);
  self.usernameField.frame = CGRectMake(CGRectGetMaxX(self.usernameLabel.frame)+18, CGRectGetMaxY(self.headerContainer.frame)+24, CGRectGetWidth(self.frame)-24-24-18-CGRectGetWidth(self.usernameLabel.frame), 30);
  self.passwordField.frame = CGRectMake(CGRectGetMaxX(self.usernameLabel.frame)+18, CGRectGetMaxY(self.usernameField.frame)+12, CGRectGetWidth(self.frame)-24-24-18-CGRectGetWidth(self.usernameLabel.frame), 30);
  self.sendButton.frame = CGRectMake(CGRectGetWidth(self.frame)-80-24, CGRectGetMaxY(self.passwordField.frame)+12, 80, 34);
  
  self.rightFooterButton.frame = CGRectMake(CGRectGetWidth(self.frame)-90-24, CGRectGetMaxY(self.frame)-20-34, 90, 34);
  self.leftFooterButton.frame = CGRectMake(CGRectGetWidth(self.frame)-90-24-8-90, CGRectGetMaxY(self.frame)-20-34, 90, 34);
  self.footerLine.frame = CGRectMake(24, CGRectGetMinY(self.rightFooterButton.frame)-8, CGRectGetWidth(self.frame)-24-24, 1);
  self.passwordlessButton.frame = CGRectMake((CGRectGetWidth(self.frame)-200)/2, CGRectGetMinY(self.footerLine.frame)-36-100, 200, 100);
}

- (IBAction)sendButtonTapped:(id)sender {
    if ([self.usernameLabel.text isEqualToString:NSLocalizedString(@"Email", nil)]) {
        //Passwordless Step 1
        if (self.usernameField.text.length == 0) {
            [self displayMessage:NSLocalizedString(@"Please add an email address before submitting.", nil)];
        }
        else {
            NSString* email = self.usernameField.text;
            NSString* post = [NSString stringWithFormat:@"client_id=tSKVxuMzRm4MfmnnXD1E85JONlnEgHW8&email=%@&connection=email&send=code", email];
            self.spinner = [self startSpinner:self.spinner inView:self.sendButton];
            [[WWUtil sharedInstance] submitPOST:post toURL:@"https://weien.auth0.com/passwordless/start" withCallback:^(NSString* errorText) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self stopSpinner:self.spinner];
                    if (errorText) {
                        [self displayMessage:errorText];
                    }
                    else {
                        [self displayMessage:NSLocalizedString(@"Great! We've emailed you a passcode. Enter that in now.", nil)];
                        self.usernameLabel.text = NSLocalizedString(@"Passcode", nil);
                        self.emailForPasswordless = self.usernameField.text;
                        self.usernameField.text = @"";
                    }
                });
            }];
        }
    }
    else if ([self.usernameLabel.text isEqualToString:NSLocalizedString(@"Passcode", nil)]) {
        //Passwordless Step 2
        NSString* code = self.usernameField.text;
        NSString* post = [NSString stringWithFormat:@"client_id=tSKVxuMzRm4MfmnnXD1E85JONlnEgHW8&username=%@&password=%@&connection=email&grant_type=password&scope=openid", self.emailForPasswordless, code];
        self.spinner = [self startSpinner:self.spinner inView:self.sendButton];
        [[WWUtil sharedInstance] submitPOST:post toURL:@"https://weien.auth0.com/oauth/ro" withCallback:^(NSString* errorText) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self stopSpinner:self.spinner];
                if (errorText) {
                    [self displayMessage:errorText];
                }
                else {
                    [self displayMessage:NSLocalizedString(@"SUCCESSFUL LOGIN! 🙌", nil)];
                }
            });
        }];
    }
    else {
        //Normal Login
        if (self.usernameField.text.length == 0 || self.passwordField.text.length == 0) {
            [self displayMessage:NSLocalizedString(@"Please complete all fields before submitting.", nil)];
        }
        else {
            NSString* username = self.usernameField.text;
            NSString* password = self.passwordField.text;
            NSString* post = [NSString stringWithFormat:@"client_id=tSKVxuMzRm4MfmnnXD1E85JONlnEgHW8&username=%@&password=%@&connection=Username-Password-Authentication&grant_type=password&scope=openid", username, password];
            self.spinner = [self startSpinner:self.spinner inView:self.sendButton];
            [[WWUtil sharedInstance] submitPOST:post toURL:@"https://weien.auth0.com/oauth/ro" withCallback:^(NSString* errorText) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self stopSpinner:self.spinner];
                    if (errorText) {
                        [self displayMessage:errorText];
                    }
                    else {
                        [self displayMessage:NSLocalizedString(@"SUCCESSFUL LOGIN! 🙌", nil)];
                    }
                });
            }];
        }
    }
}

- (void) displayMessage:(NSString*)message {
    self.alertController.message = message;
    [self.parentVC showViewController:self.alertController sender:self];
}

- (IBAction)passwordlessButtonTapped:(id)sender {
    self.sendButtonYConstraint.constant = 0-CGRectGetHeight(self.passwordField.frame);
    self.sendButton.frame = CGRectMake(CGRectGetWidth(self.frame)-80-24, CGRectGetMaxY(self.passwordField.frame)+12-30, 80, 34);
    
    [UIView animateWithDuration:.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^() {
        self.usernameLabel.text = NSLocalizedString(@"Email", nil);
        self.passwordLabel.alpha = 0;
        self.passwordField.alpha = 0;
        [self layoutIfNeeded];
        self.passwordlessButton.alpha = 0;
        self.headerText.text = NSLocalizedString(@"We're goin' Passwordless!", nil);
        [self.usernameField becomeFirstResponder];
        self.usernameField.returnKeyType = UIReturnKeyGo;
    } completion:NULL];
}

- (IBAction)rightFooterButtonTapped:(id)sender {
    if (self.wholeViewContainer.backgroundColor == [UIColor whiteColor]) {
        self.wholeViewContainer.backgroundColor = [UIColor blueColorDarkBackground];
        self.headerContainer.backgroundColor = [UIColor grayColorMediumBackground];
        self.usernameLabel.textColor = [UIColor whiteColor];
        self.passwordLabel.textColor = [UIColor whiteColor];
        self.sendButton.backgroundColor = [UIColor orangeColorSecondary];
        self.rightFooterButton.backgroundColor = [UIColor pinkColorSecondary];
        self.leftFooterButton.backgroundColor = [UIColor pinkColorSecondary];
        self.passwordlessButton.backgroundColor = [UIColor orangeColorSecondary];
    }
    else {
        self.wholeViewContainer.backgroundColor = [UIColor whiteColor];
        self.headerContainer.backgroundColor = [UIColor grayColorDarkBackground];
        self.usernameLabel.textColor = [UIColor blackColorText];
        self.passwordLabel.textColor = [UIColor blackColorText];
        self.sendButton.backgroundColor = [UIColor redColorSuccess];
        self.rightFooterButton.backgroundColor = [UIColor blueColorPrimary];
        self.leftFooterButton.backgroundColor = [UIColor blueColorPrimary];
        self.passwordlessButton.backgroundColor = [UIColor redColorSuccess];
    }
}

- (IBAction)leftFooterButtonTapped:(id)sender {
    WWUtil* util = [WWUtil sharedInstance];
    
    if (self.headerText.font == [util currentMainFontWithSize:14]) {
        self.headerText.font = [util currentMainFontWithSize:12];
        self.usernameLabel.font = [util currentMainFontWithSize:12];
        self.passwordLabel.font = [util currentMainFontWithSize:12];
        self.usernameField.font = [util currentMainFontWithSize:12];
        self.passwordField.font = [util currentMainFontWithSize:12];
        self.sendButton.titleLabel.font = [util currentBoldFontWithSize:12];
        self.rightFooterButton.titleLabel.font = [util currentBoldFontWithSize:12];
        self.leftFooterButton.titleLabel.font = [util currentBoldFontWithSize:12];
        self.passwordlessButton.titleLabel.font = [util currentBoldFontWithSize:12];
    }
    else {
        self.headerText.font = [util currentMainFontWithSize:14];
        self.usernameLabel.font = [util currentMainFontWithSize:14];
        self.passwordLabel.font = [util currentMainFontWithSize:14];
        self.usernameField.font = [util currentMainFontWithSize:14];
        self.passwordField.font = [util currentMainFontWithSize:14];
        self.sendButton.titleLabel.font = [util currentBoldFontWithSize:14];
        self.rightFooterButton.titleLabel.font = [util currentBoldFontWithSize:14];
        self.leftFooterButton.titleLabel.font = [util currentBoldFontWithSize:14];
        self.passwordlessButton.titleLabel.font = [util currentBoldFontWithSize:14];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:self.usernameField] && self.passwordField.alpha == 0) {
        [self sendButtonTapped:self];
    }
    if ([textField isEqual:self.usernameField] && self.passwordField.text.length == 0) {
        [self.passwordField becomeFirstResponder];
    }
    else if (([textField isEqual:self.passwordField] && self.usernameField.text.length > 0) ||
             ([textField isEqual:self.usernameField] && self.passwordField.text.length > 0)) {
        [textField resignFirstResponder];
        [self sendButtonTapped:self];
    }
    else {
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)dismissKeyboard:(UITapGestureRecognizer *) sender {
    [self endEditing:YES];
    
    if ([self.usernameLabel.text isEqualToString:NSLocalizedString(@"Email", nil)] ||
        [self.usernameLabel.text isEqualToString:NSLocalizedString(@"Passcode", nil)]) {
        //reset to normal
        self.usernameLabel.text = NSLocalizedString(@"Username", nil);
        self.passwordLabel.alpha = 1;
        self.passwordField.alpha = 1;
        self.sendButtonYConstraint.constant = 12;
        self.sendButton.frame = CGRectMake(CGRectGetWidth(self.frame)-80-24, CGRectGetMaxY(self.passwordField.frame)+12, 80, 34);
        self.passwordlessButton.alpha = 1;
        self.headerText.text = NSLocalizedString(@"Welcome! Please log in.", nil);
        self.usernameField.returnKeyType = UIReturnKeyNext;
        self.usernameField.text = @"";
        self.passwordField.text = @"";
    }
}

@end
