//
//  FeedCell.h
//  Woven
//
//  Created by Carlo Olcese on 11/8/13.
//  Copyright (c) 2013 OOSE. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 Cell to hold all feed information (title and date).
 */
@interface FeedCell : UITableViewCell

/**
 Label for date.
 */
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

/**
 Label for title/sender.
 */
@property (weak, nonatomic) IBOutlet UILabel *senderLabel;

/**
 * The image representing the status of the weave relative to current user.
 */
@property (strong, nonatomic) IBOutlet UIImageView *statusImage;

@end
