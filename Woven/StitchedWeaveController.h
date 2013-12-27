//
//  StitchedWeaveController.h
//  Woven
//
//  Created by Alex Koren on 12/4/13.
//  Copyright (c) 2013 OOSE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "Networker.h"

/**
 * Controller for the StitchedWeaveView.
 */
@interface StitchedWeaveController : UIViewController

/**
 * Array of urls for the videos (original, stitched).
 */
@property (strong, nonatomic) NSArray *urls;
/**
The video to stiched
 */
@property (strong, nonatomic) NSURL* vidURL;

/**
Database object to add the new video to
 */
@property (strong, nonatomic) PFObject *weave;

/**
 The networker used by the controller.
 */
@property (strong, nonatomic) Networker *networker;

/**
Sends the stored video to be stitched to the previously saved video
 */
- (void)sendVideo;

/**
 * Method for sending user to home page (to the feed).
 */
- (void)goHome;

@end
