//
//  Networker.h
//  Woven
//
//  Created by Alex Koren on 10/28/13.
//  Copyright (c) 2013 OOSE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

/**
 Networker class which holds singleton of networker. Subclass of NSObject.
 */
@interface Networker : NSObject

/**
 Gets the instance of the networker.
 @return the singleton.
 */
+ (id)networker;
/**
 Method to login with a username and password.
 @param email the email to login with
 @param pass the password to login with
 */
- (void) loginWithEmail:(NSString*)email password:(NSString*)pass;
/**
 Method to register with an email, password, and username.
 @param email the email to register with
 @param pass the password to register with
 @param displayName the display name to register with.
 */
- (void) registerWithEmail:(NSString*)email password:(NSString*)pass username:(NSString*)displayName;

/**
 Method to send a weave.
 @param vidURL the URL of the video
 @param targetController the controller the video is being sent from
 @param onSuccess the method called on success of send
 @param onFailuerSetError method called on failure of send
 */
- (void) sendVideo:(NSURL*)vidURL toWeaversWithNames:(NSMutableArray*)names targetController:(UIViewController*)targetController
         onSuccess:(SEL)onSuccess onFailureSetError:(SEL)onFailureSetError;

/**
 Logout of user session.
 @param targetController the controller being logged out from
 @param onSuccess the method called on success of logout
 */
- (void) logOutWithController:(UIViewController*)targetController onSuccess:(SEL)onSuccess;

/**
 Check if a user is logged on.
 @return whether there is a user session
 */
- (BOOL) isLoggedOn;

/**
 Check if a user exists in the database.
 @param username the username of the user
 @param targetController the controller the user is being checked from
 @param onSuccess the method called on success of finding the user
 @param onFailureSetError the method called on failure of finding the user
 */
- (void)checkForWeaver:(NSString*)username targetController:(UIViewController*)targetController onSuccess:(SEL)onSuccess
     onFailureSetError:(SEL)onFailureSetError;

     
/**
 * Method for skipping (passing on) the given weave.
 * @param weave The weave to be skipped.
 */
- (void)skipWeave:(PFObject*)weave;

/**
 * Method for sending given video to next user of the weave, updating in the database.
 * @param weave weave to udpate
 * @param vidURL url of the video with which to update to weave.
 */
- (void)sendVideoToNext:(PFObject *)weave withURL:(NSURL*)vidURL;
@end