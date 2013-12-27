//
//  CreateWeaveView.h
//  Woven
//
//  Created by Alex Koren on 10/28/13.
//  Copyright (c) 2013 OOSE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "MovieContainerController.h"
#import "WeavePlayerController.h"

/**
 View for the interface to create a new Weave allowing for taking video, adding friends, and sending the video.
 Extends UIView and conforms to the UIImagePickerControllerDelegate and UINavigationControllerDelegate.
 */
@interface CreateWeaveView : UIView <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {}
/**
 A button to take the video.
 */
@property (strong, nonatomic) IBOutlet UIButton *takeVideoButton;

/**
 Button for sending the weave
 */
@property (strong, nonatomic) IBOutlet UIButton *sendButton;
/**
 A container which the WeavePlayerController will be presented in.
 */
@property (strong, nonatomic) IBOutlet UIView *movieContainer;

/**
 Method when going back to the feed from creating the weave.
 @param sender the sender of the action.
 */
- (IBAction)onBack:(id)sender;

/**
 Method when sending the weave.
 @param sender the sender of the action.
 */
- (IBAction)onSend:(id)sender;
/**
 Method for initializing variables when the view is presented.
 */
- (void)initialize;

/**
 Method called when the weave is sent.
 */
- (void)videoSent;

/**
 Method called when the weave fails to send.
 */
- (void)sendVideoFailed:(NSString*)error;

/**
 Method called while the weave is being uploaded to the database.
 */
- (void)sendingVideo;
/**
 Presents a WeavePlayerController within a given container.
 @param player the WeavePlayerController to be presented
 @param mContainer the container for the WeavePlayerController.
 */
- (void)presentMovieWithPlayer:(WeavePlayerController*)player inController:(MovieContainerController*)mContainer;
@end