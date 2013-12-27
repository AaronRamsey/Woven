//
//  FriendsController.h
//  Woven
//
//  Created by Alex Koren on 11/11/13.
//  Copyright (c) 2013 OOSE. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 Controller to add friends and view current friends.
 */
@interface FriendsController : UIViewController

/**
 Method to check if user exists in database with username.
 @param the username to check for existence
 */
-(void)checkFriend:(NSString*)username;

/**
 Method to add friend with given username.
 @param the username of the friend to add
 */
-(void)addFriend:(NSString*)username;

/**
 * Method for when back button selected.
 */
-(void)onBack;

/**
 * Method for when settings button selected.
 */
- (void)onSettings;

@end
