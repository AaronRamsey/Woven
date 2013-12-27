//
//  FeedView.m
//  Woven
//
//  Created by Alex Koren on 11/13/13.
//  Copyright (c) 2013 OOSE. All rights reserved.
//

#import "FeedView.h"
#import <Parse/Parse.h>
#import "FeedController.h"

@implementation FeedView

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

- (IBAction)onCreate:(id)sender {
    [(FeedController*)self.nextResponder onCreate];
}
@end
