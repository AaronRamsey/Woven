//
//  CreateWeaveView.m
//  Woven
//
//  Created by Alex Koren on 10/28/13.
//  Copyright (c) 2013 OOSE. All rights reserved.
//

#import "CreateWeaveView.h"
#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "CreateWeaveController.h"
#import "WeavePlayerController.h"

@implementation CreateWeaveView {
    MovieContainerController *weaveContainer;
    WeavePlayerController *weavePlayer;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (IBAction)onSend:(id)sender {
    [(CreateWeaveController*)self.nextResponder chooseFriends];
}

- (IBAction)onBack:(id)sender {
    [weavePlayer.moviePlayer stop];
    [(CreateWeaveController*)self.nextResponder backToFeed];
}

- (void)initialize {
    self.movieContainer.hidden = YES;
    //self.sendButton.hidden = YES;
}

- (void)videoSent {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Yay!" message:@"Your Weave was sent!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
}

- (void)sendVideoFailed:(NSString *)error {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Uh oh!" message:error delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
    self.sendButton.hidden = NO;
}

- (void)sendingVideo {
    self.sendButton.hidden = YES;
}

- (void)presentMovieWithPlayer:(WeavePlayerController*)player inController:(MovieContainerController *)mContainer{
    weaveContainer = mContainer;
    weavePlayer = player;
    self.movieContainer.hidden = NO;
    [weaveContainer.view addSubview:weavePlayer.view];
    [weavePlayer.moviePlayer play];
    self.sendButton.hidden = NO;
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
