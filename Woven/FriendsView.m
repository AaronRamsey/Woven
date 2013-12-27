//
//  FriendsView.m
//  Woven
//
//  Created by Alex Koren on 11/11/13.
//  Copyright (c) 2013 OOSE. All rights reserved.
//

#import "FriendsView.h"
#import "FriendsController.h"

@implementation FriendsView

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

- (IBAction)onCheckFriend:(id)sender {
    NSString *temp = self.friendField.text;
    FriendsController *p = (FriendsController*)self.nextResponder;
    [p checkFriend:temp];
}

- (IBAction)onBack:(id)sender {
    [(FriendsController*)self.nextResponder onBack];
}

@end
