//
//  AccountViewController.h
//  Woven
//
//  Created by Benjamin Glickman on 12/16/13.
//  Copyright (c) 2013 OOSE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Networker.h"

/**
 * ViewController for the Account (aka settings) page for the user.
 */
@interface AccountViewController : UIViewController

/**
 The networker used by the login controller.
 */
@property (strong, nonatomic) Networker *networker;

/**
 * Method for when logout button selected.
 */
- (void)onLogoutButton;

/**
 * Method for when back button selected.
 */
-(void)onBack;


@end
