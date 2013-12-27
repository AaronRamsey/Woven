//
//  ChosenFriendView.m
//  Woven
//
//  Created by Alex Koren on 11/16/13.
//  Copyright (c) 2013 OOSE. All rights reserved.
//

#import "ChosenFriendView.h"
#import "ChooseFriendsView.h"

@implementation ChosenFriendView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)onRemove:(id)sender {
    [(ChooseFriendsView*)self.nextResponder removeFriend:self];
}
@end
