//
//  FriendsView.h
//  Woven
//
//  Created by Alex Koren on 11/11/13.
//  Copyright (c) 2013 OOSE. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 View which controls all visuals on the friends page.
 */
@interface FriendsView : UIView

/**
 Field for the name of the friend to add.
 */
@property (strong, nonatomic) IBOutlet UITextField *friendField;

/**
 Container which holds the table of friends.
 */
@property (strong, nonatomic) IBOutlet UIView *friendsContainer;

/**
 Method called when adding friend.
 @param sender sender of the method
 */
- (IBAction)onCheckFriend:(id)sender;

/**
 * Method for when back button selected
 * @param sender sender of the message.
 */
- (IBAction)onBack:(id)sender;

@end
