//
//  WeaveView.h
//  Woven
//
//  Created by Alex Koren on 11/13/13.
//  Copyright (c) 2013 OOSE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeavePlayerController.h"
#import "MovieContainerController.h"

/**
 View which handles all presentation of elements/weave to the user.
 */
@interface WeaveView : UIView

/**
 Presents the a video on the view.
 @param player the movie player
 @param mContainer the container that the player resides in
 */
- (void)presentMovieWithPlayer:(WeavePlayerController*)player inController:(MovieContainerController*)mContainer;

/**
 Indicates to the controller that the user has skipped
 @param this weaver
 */
- (IBAction)onSkip:(id)sender;

/**
 Indicates to the controller that the user has added
 @param this weaver
 */
- (IBAction)onAdd:(id)sender;

/**
 * View's add button.
 */
@property (strong, nonatomic) IBOutlet UIButton *addButton;

/**
 * View's skip button.
 */
@property (strong, nonatomic) IBOutlet UIButton *skipButton;

/**
 * View's save button.
 */
@property (strong, nonatomic) IBOutlet UIButton *saveButton;

/**
 * View's title field.
 */
@property (strong, nonatomic) IBOutlet UITextField *titleField;

/**
 * View's description field.
 */
@property (strong, nonatomic) IBOutlet UITextField *descriptionField;

/**
 * View's facebook button.
 */
@property (strong, nonatomic) IBOutlet UIButton *fbButton;

/**
 * View's Post View.
 */
@property (strong, nonatomic) IBOutlet UIView *postView;

/**
 * Method for when save button selected.
 * @param sender sender of message (this)
 */
- (IBAction)onSave:(id)sender;

/**
 * Method for when facebook button selected.
 * @param sender sender of message (this)
 */
- (IBAction)onFacebook:(id)sender;

/**
 * Method for when post button selected.
 * @param sender sender of message (this)
 */
- (IBAction)onPost:(id)sender;

/**
 * Method for when cancel button selected.
 * @param sender sender of message (this)
 */
- (IBAction)onCancel:(id)sender;

/**
 * Method for when weave being viewed is a finished weave.
 */
- (void)finishedWeave;

/**
Changes the old video to the new one
 @param newVidURL the new vid URL to display
 */
- (void)changeVidURL:(NSURL*)newVidURL;

/**
 * Method for when back button selected.
 */
- (void)onBack;
@end
