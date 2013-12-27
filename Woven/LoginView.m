//
//  LoginView.m
//  Woven
//
//  Created by Alex Koren on 10/28/13.
//  Copyright (c) 2013 OOSE. All rights reserved.
//

#import "LoginView.h"
#import "Networker.h"

@implementation LoginView {
    BOOL isRegister;
}

- (void)toggleRegister {
    if (isRegister) {
        isRegister = NO;
        self.usernameField.hidden = YES;
        [self.registerButton setTitle:@"new user" forState:UIControlStateNormal];
        [self.loginButton setTitle:@"login" forState:UIControlStateNormal];
    } else {
        isRegister = YES;
        self.usernameField.hidden = NO;
        [self.registerButton setTitle:@"cancel" forState:UIControlStateNormal];
        [self.loginButton setTitle:@"register" forState:UIControlStateNormal];
    }
}

- (IBAction)onLogin:(id)sender {
    if (!isRegister) {
        [(LoginController*)self.nextResponder loginWithEmail:self.emailField.text password:self.passwordField.text];
    } else {
        [(LoginController*)self.nextResponder registerWithEmail:self.emailField.text password:self.passwordField.text username:self.usernameField.text];
    }
}

- (IBAction)onRegister:(id)sender {
    [self toggleRegister];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)initialize {
    isRegister = NO;
    self.usernameField.hidden = YES;
}

- (BOOL)getIsRegister {
    return isRegister;
}

- (void)setError:(NSString*)error {
    self.errorLabel.text = error;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
@end
