//
//  FriendCell.h
//  Woven
//
//  Created by Alex Koren on 11/11/13.
//  Copyright (c) 2013 OOSE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Weaver.h"

/**
 Cell to handle friend in friends list.
 */
@interface FriendCell : UITableViewCell

/**
 Label to show name in
 */
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

/**
 * The weaver associated with the cell.
 */
@property (strong, nonatomic) Weaver* weaver;


@end
