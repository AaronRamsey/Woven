//
//  ChooseFriendsView.m
//  Woven
//
//  Created by Alex Koren on 11/16/13.
//  Copyright (c) 2013 OOSE. All rights reserved.
//

#import "ChooseFriendsView.h"
#import "ChosenFriendView.h"
#import "ChooseFriendsController.h"
#import "Weaver.h"

@implementation ChooseFriendsView {
    NSMutableArray *chosenViews;
    NSArray *chosenLocations;
    BOOL sent;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (BOOL)isChosenView:(UIView*)view {
    return view.tag > 100 && view.tag < 106;
}

- (void)initialize {
    chosenViews = [[NSMutableArray alloc]init];
    [chosenViews removeAllObjects];
    self.sendButton.hidden = YES;
    chosenLocations = @[@70,@100,@130,@160,@190];
    sent = NO;
}

- (IBAction)onSend:(id)sender {
    NSMutableArray *weavers = [[NSMutableArray alloc]init];
    [[NSNotificationCenter defaultCenter] removeObserver:self.nextResponder];
    for (ChosenFriendView *view in chosenViews) {
        [weavers addObject:view.friendLabel.text];
    }
    self.sendButton.hidden = YES;
    sent = YES;
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"sendVideo" object:self
     userInfo:[NSDictionary dictionaryWithObject:weavers
                                          forKey:@"weavers"]];
}

- (void)videoSent {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Yay!" message:@"Your Weave was sent!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
    [(ChooseFriendsController*)self.nextResponder backToFeed];
}

- (void)sendVideoFailed:(NSString *)error {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Uh oh!" message:error delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
    self.sendButton.hidden = NO;
}

- (void)sendingVideo {
    self.sendButton.hidden = YES;
}

- (IBAction)onBack:(id)sender {
    if (sent) {
        [(ChooseFriendsController*)self.nextResponder backToFeed];
    } else {
        [(ChooseFriendsController*)self.nextResponder backToCamera];
    }
}

- (void)addWeaver:(Weaver*)weaver {
    if ([chosenViews count] < 5) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ChosenFriendView" owner:self options:nil];
        ChosenFriendView *newFriendView = [nib objectAtIndex:0];
        newFriendView.frame = CGRectMake(0, [chosenViews count]*30+70, 320, 25);
        newFriendView.tag = 101+[chosenViews count];
        newFriendView.friendLabel.text = weaver.displayName;
        [self addSubview:newFriendView];
        [chosenViews addObject:newFriendView];
    } else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Uh oh!" message:@"Your weave can only have 5 other weavers!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }
    if ([chosenViews count] > 0) {
        self.sendButton.hidden = NO;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    if ([self isChosenView:[touch view]]) {
        CGPoint location = [touch locationInView:self];
        if (location.y > 60 && location.y < 210) {
            [touch view].center = CGPointMake(self.frame.size.width/2, location.y);
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [self touchesBegan:touches withEvent:event];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSMutableArray *temp = [[NSMutableArray alloc]init];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.3];
    for (int x = 0; x < 5; x++) {
        int m = 300;
        ChosenFriendView *toMove;
        for (ChosenFriendView *view in chosenViews) {
            if (view.center.y < m) {
                m = view.center.y;
                toMove = view;
            }
        }
        if (toMove) {
            [chosenViews removeObject:toMove];
            [temp addObject:toMove];
            toMove.frame = CGRectMake(0,[[chosenLocations objectAtIndex:x] intValue],320,25);
        }
        
    }
    [UIView commitAnimations];
    chosenViews = temp;
}

- (void)removeFriend:(ChosenFriendView*)friendView {
    [friendView removeFromSuperview];
    [chosenViews removeObject:friendView];
    [self touchesEnded:nil withEvent:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
