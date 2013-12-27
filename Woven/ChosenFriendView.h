//
//  ChosenFriendView.h
//  Woven
//
//  Created by Alex Koren on 11/16/13.
//  Copyright (c) 2013 OOSE. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 View for the chosen friends
 */
@interface ChosenFriendView : UIView

/**
Label that holds the friends name in the list of weavers to send to
 */
@property (strong, nonatomic) IBOutlet UILabel *friendLabel;

/**
 * Method for when remove button (the x) is selected.
 * @param sender the sender of the message.
 */
- (IBAction)onRemove:(id)sender;

@end
