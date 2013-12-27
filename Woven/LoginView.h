//
//  LoginView.h
//  Woven
//
//  Created by Alex Koren on 10/28/13.
//  Copyright (c) 2013 OOSE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginController.h"
/**
 View to handle all user interaction with the login screen. Subclass of UIView.
 */
@interface LoginView : UIView

/**
 Label to show errors in.
 */
@property (strong, nonatomic) IBOutlet UILabel *errorLabel;
/**
 Field for e-mail input.
 */
@property (strong, nonatomic) IBOutlet UITextField *emailField;
/**
 Field for passwordinput.
 */
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
/**
 Field for username input.
 */
@property (strong, nonatomic) IBOutlet UITextField *usernameField;
/**
 Button which allows for login (or completion of registration).
 */
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
/**
 Button which toggles fields between registration and login.
 */
@property (strong, nonatomic) IBOutlet UIButton *registerButton;
/**
 Method for when a user logs in.
 @param sender the sender of the action.
 */
- (IBAction)onLogin:(id)sender;
/**
 Method for toggling user resgistration.
 @param sender the sender of the action.
 */
- (IBAction)onRegister:(id)sender;
/**
 Method to toggle registration away from button.
 */
- (void)toggleRegister;
/**
 Method to initialize the view when it appears.
 */
- (void)initialize;
/**
 Getter for whether the user is registering.
 */
- (BOOL)getIsRegister;
/**
 Setter for the error label.
 @param error the error to present.
 */
- (void)setError:(NSString*)error;

@end
