//
//  StitchedWeaveView.h
//  Woven
//
//  Created by Alex Koren on 12/4/13.
//  Copyright (c) 2013 OOSE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeavePlayerController.h"
#import "MovieContainerController.h"


/**
 * View for viewing stitched weave.
 */
@interface StitchedWeaveView : UIView

/**
 * The view's navigation bar.
 */
@property (strong, nonatomic) IBOutlet UIImageView *navBarView;

/**
 * The view's background.
 */
@property (strong, nonatomic) IBOutlet UIImageView *backgroundView;

/**
Tells the controller to stitch the video
 @param sender the sender of the video
 */
- (IBAction)onSend:(id)sender;

/**
 * The view's panda animation view.
 */
@property (strong, nonatomic) IBOutlet UIImageView *pandaAnimView;


/**
 * The view's loading label.
 */
@property (strong, nonatomic) IBOutlet UILabel *loadingLabel;

/**
 * The view's WeavePlayerController for playing the weave.
 */
@property (nonatomic, retain) WeavePlayerController *weavePlayer;


/**
 * Method for when home button selected.
 * @param sender sender of the message (this)
 */
- (IBAction)onHome:(id)sender;
/**
 Presents the stitched video to the screen
 @param player the weaveplayercontroller to work
 @param inController the movie container to use on this screen
 */
- (void)presentMovieWithPlayer:(WeavePlayerController*)player inController:(MovieContainerController*)mContainer;

@end
