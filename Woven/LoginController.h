//
//  LoginController.h
//  Woven
//
//  Created by Alex Koren on 10/28/13.
//  Copyright (c) 2013 OOSE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Networker.h"

/**
 The controller for a users login and registration. Subclass of UIViewController.
 */
@interface LoginController : UIViewController

/**
 The networker used by the login controller.
 */
@property (strong, nonatomic) Networker *networker;


/**
 Method to login with a given email and password.
 @param email the email to login with
 @param pass the password to login with
 */
- (void)loginWithEmail:(NSString*)email password:(NSString*)pass;
/**
 Method to register with a given email and password and username.
 @param email the email to register with
 @param pass the password to register with
 @param username the username to register with
 */
- (void)registerWithEmail:(NSString*)email password:(NSString*)pass username:(NSString*)username;

/**
 Method for setting an error
 @param error the error to be set in the view.
 */
-(void) setError:(NSString *)error;

/**
 Method for segueing to home screen (FeedTableController
 @param notification the notification that triggered the method call
 */
- (void) segueToHome:(NSNotification *)notification;

@end
