//
//  ChooseFriendsController.h
//  Woven
//
//  Created by Alex Koren on 11/16/13.
//  Copyright (c) 2013 OOSE. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
Controller for the choose friends view
 */
@interface ChooseFriendsController : UIViewController

/**
 Performs segue back to the main feed
 */
- (void)backToFeed;

/**
Performs segue back to the camera
 */
- (void)backToCamera;

@end
