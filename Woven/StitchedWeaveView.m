//
//  StitchedWeaveView.m
//  Woven
//
//  Created by Alex Koren on 12/4/13.
//  Copyright (c) 2013 OOSE. All rights reserved.
//

#import "StitchedWeaveView.h"
#import "WeavePlayerController.h"
#import "MovieContainerController.h"
#import "StitchedWeaveController.h"

@implementation StitchedWeaveView {
    
}
@synthesize weavePlayer;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (IBAction)onSend:(id)sender {
    [(StitchedWeaveController*)self.nextResponder sendVideo];
}

- (IBAction)onHome:(id)sender {
    [(StitchedWeaveController*)self.nextResponder goHome];
}

- (void)presentMovieWithPlayer:(WeavePlayerController*)player inController:(MovieContainerController *)mContainer{
    weavePlayer = player;
    [mContainer.view addSubview:player.view];
    [self showVideo];
}

- (void)showVideo {
    [weavePlayer.moviePlayer play];
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
