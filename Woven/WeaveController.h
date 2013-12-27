//
//  WeaveController.h
//  Woven
//
//  Created by Alex Koren on 11/6/13.
//  Copyright (c) 2013 OOSE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <FacebookSDK/FacebookSDK.h>

/**
 Controller to handle the viewing and downloading weave through the networker.
 */
@interface WeaveController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

/**
 The weave object to be viewed and worked on.
 */
@property (strong, nonatomic) PFObject *weave;

/**
 Indicates that this user is not adding to the video
 */
- (void) onSkip;

/**
 Method for when want to add on to weave.
 */
- (void) onAdd;

/**
 * Method for when user wants to save current weave.
 */
- (void) onSave;

/**
 * Method for posting to facebook with given title and description.
 * @param title Title of the post.
 * @param description description of the post
 */
- (void) onPostWithTitle:(NSString*)title description:(NSString*)description;


@end
