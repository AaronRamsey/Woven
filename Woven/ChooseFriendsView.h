//
//  ChooseFriendsView.h
//  Woven
//
//  Created by Alex Koren on 11/16/13.
//  Copyright (c) 2013 OOSE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Weaver.h"
#import "ChosenFriendView.h"

/**
 View for the Choose Friends video
 */
@interface ChooseFriendsView : UIView

/**
Initialized the video to not sent and the send button is hidden until users are chosen
 */
- (void)initialize;

/**
 Method to send a weave out
 @param sender the sender of this weave
 */
- (IBAction)onSend:(id)sender;

/**
Send button on choose friends page, sends video out
 */
@property (strong, nonatomic) IBOutlet UIButton *sendButton;

/**
 Segues back to main feed if video is sent, otherwise back to camera
 @param sender the sender of this weave
 */
- (IBAction)onBack:(id)sender;

/**
 Adds a new user to the list of weavers this video is being sent to
 @param weaver the weaver object of the user to add
 */
- (void)addWeaver:(Weaver*)weaver;

/**
 * Method for removing given friend from list of choosen friends.
 * @param friendView the friend(View) being removed from list of frien(View)s
 */
- (void)removeFriend:(ChosenFriendView*)friendView;
@end
