//
//  ViewController.m
//  Auth0Login
//
//  Created by Weien Wang on 7/4/16.
//  Copyright © 2016 Weien Wang. All rights reserved.
//

#import "ViewController.h"
#import "UIColor+Custom.h"

@interface ViewController () <UITextFieldDelegate>
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

@property (strong, nonatomic) UIAlertController* alertController;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.headerContainer.backgroundColor = [UIColor grayColorDarkBackground];
    self.headerText.text = NSLocalizedString(@"Welcome! Please log in.", nil);
    self.headerText.textColor = [UIColor whiteColor];
    self.headerText.font = [self currentMainFontWithSize:14];
    self.usernameLabel.text = NSLocalizedString(@"Username", nil);
    self.usernameLabel.textColor = [UIColor blackColorText];
    self.usernameLabel.font = [self currentMainFontWithSize:14];
    self.passwordLabel.text = NSLocalizedString(@"Password", nil);
    self.passwordLabel.textColor = [UIColor blackColorText];
    self.passwordLabel.font = [self currentMainFontWithSize:14];
    self.usernameField.delegate = self;
    self.usernameField.font = [self currentMainFontWithSize:14];
    self.passwordField.delegate = self;
    self.passwordField.font = [self currentMainFontWithSize:14];
    [self.sendButton setTitle:NSLocalizedString(@"SUBMIT", nil) forState:UIControlStateNormal];
    self.sendButton.backgroundColor = [UIColor redColorSuccess];
    [self.sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.sendButton.titleLabel.font = [self currentBoldFontWithSize:14];
    self.sendButton.layer.cornerRadius = 3;
    self.footerLine.backgroundColor = [UIColor grayColorLightText];
    [self.rightFooterButton setTitle:NSLocalizedString(@"RECOLOR!", nil) forState:UIControlStateNormal];
    self.rightFooterButton.backgroundColor = [UIColor blueColorPrimary];
    [self.rightFooterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.rightFooterButton.titleLabel.font = [self currentBoldFontWithSize:14];
    self.rightFooterButton.layer.cornerRadius = 3;
    [self.leftFooterButton setTitle:NSLocalizedString(@"RESIZE!", nil) forState:UIControlStateNormal];
    self.leftFooterButton.backgroundColor = [UIColor blueColorPrimary];
    [self.leftFooterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.leftFooterButton.titleLabel.font = [self currentBoldFontWithSize:14];
    self.leftFooterButton.layer.cornerRadius = 3;


    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard:)];
    [self.view addGestureRecognizer:tap];
    
    self.alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    [self.alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil) style:UIAlertActionStyleDefault handler:NULL]];
}

- (IBAction)sendButtonTapped:(id)sender {
    if (self.usernameField.text.length == 0 || self.passwordField.text.length == 0) {
        self.alertController.message = NSLocalizedString(@"Please complete all fields before submitting.", nil);
        [self showViewController:self.alertController sender:self];
    }
    else {
        NSString* username = self.usernameField.text;
        NSString* password = self.passwordField.text;
        NSString* post = [NSString stringWithFormat:@"client_id=tSKVxuMzRm4MfmnnXD1E85JONlnEgHW8&username=%@&password=%@&connection=Username-Password-Authentication&grant_type=password&scope=openid", username, password];
        [self submitPOST:post toURL:@"https://weien.auth0.com/oauth/ro" withCallback:^(BOOL success) {
            
        }];
    }
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

- (IBAction)rightFooterButtonTapped:(id)sender {
    if (self.view.backgroundColor == [UIColor whiteColor]) {
        self.view.backgroundColor = [UIColor blueColorDarkBackground];
        self.headerContainer.backgroundColor = [UIColor grayColorMediumBackground];
        self.usernameLabel.textColor = [UIColor whiteColor];
        self.passwordLabel.textColor = [UIColor whiteColor];
        self.sendButton.backgroundColor = [UIColor orangeColorSecondary];
        self.rightFooterButton.backgroundColor = [UIColor pinkColorSecondary];
        self.leftFooterButton.backgroundColor = [UIColor pinkColorSecondary];
    }
    else {
        self.view.backgroundColor = [UIColor whiteColor];
        self.headerContainer.backgroundColor = [UIColor grayColorDarkBackground];
        self.usernameLabel.textColor = [UIColor blackColorText];
        self.passwordLabel.textColor = [UIColor blackColorText];
        self.sendButton.backgroundColor = [UIColor redColorSuccess];
        self.rightFooterButton.backgroundColor = [UIColor blueColorPrimary];
        self.leftFooterButton.backgroundColor = [UIColor blueColorPrimary];
    }
}

- (IBAction)leftFooterButtonTapped:(id)sender {
    if (self.headerText.font == [self currentMainFontWithSize:14]) {
        self.headerText.font = [self currentMainFontWithSize:12];
        self.usernameLabel.font = [self currentMainFontWithSize:12];
        self.passwordLabel.font = [self currentMainFontWithSize:12];
        self.usernameField.font = [self currentMainFontWithSize:12];
        self.passwordField.font = [self currentMainFontWithSize:12];
        self.sendButton.titleLabel.font = [self currentBoldFontWithSize:12];
        self.rightFooterButton.titleLabel.font = [self currentBoldFontWithSize:12];
        self.leftFooterButton.titleLabel.font = [self currentBoldFontWithSize:12];
    }
    else {
        self.headerText.font = [self currentMainFontWithSize:14];
        self.usernameLabel.font = [self currentMainFontWithSize:14];
        self.passwordLabel.font = [self currentMainFontWithSize:14];
        self.usernameField.font = [self currentMainFontWithSize:14];
        self.passwordField.font = [self currentMainFontWithSize:14];
        self.sendButton.titleLabel.font = [self currentBoldFontWithSize:14];
        self.rightFooterButton.titleLabel.font = [self currentBoldFontWithSize:14];
        self.leftFooterButton.titleLabel.font = [self currentBoldFontWithSize:14];
    }
}

- (UIFont*) currentMainFontWithSize:(float)size {
    return [UIFont fontWithName:@"Avenir Next" size:size];
}

- (UIFont*) currentBoldFontWithSize:(float)size {
    return [UIFont fontWithName:@"AvenirNext-DemiBold" size:size];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
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
    [self.view endEditing:YES];
}

@end
