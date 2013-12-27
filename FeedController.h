//
//  FeedController.h
//  Woven
//
//  Created by Alex Koren on 11/13/13.
//  Copyright (c) 2013 OOSE. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 Controller which contains the home/feed. Allows navigation to other conrollers.
 */
@interface FeedController : UIViewController

/**
 * Method for when the Create New Weave button is clicked. Segues to CreateWeaveController.
 */
- (void)onCreate;

@end
