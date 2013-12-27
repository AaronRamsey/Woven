//
//  CreateWeaveController.h
//  Woven
//
//  Created by Alex Koren on 10/28/13.
//  Copyright (c) 2013 OOSE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Networker.h"

/**
 Controller that controls the creating of Weaves. This includes taking video, adding friends, and sending via the Networker.
 Subclass of UIViewController and conforms to UIImagePickerControllerDelegate and UINavigationControllerDelegate.
 */
@interface CreateWeaveController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {}

/**
 The networker used by the controller.
 */
@property (strong, nonatomic) Networker *networker;

/**
 * URL associated with video for current weave.
 */
@property (strong, nonatomic) NSURL *vidURL;

/**
 * Method for seguing to choosing friends.
 */
- (void)chooseFriends;

/**
 Method to send a weave.
 */
- (void)sendVideo:(NSNotification*)notification;

/**
 * Methosd for returning to feed.
 */
- (void)backToFeed;
@end
