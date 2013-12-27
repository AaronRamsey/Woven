//
//  WeaveView.m
//  Woven
//
//  Created by Alex Koren on 11/13/13.
//  Copyright (c) 2013 OOSE. All rights reserved.
//

#import "WeaveView.h"
#import "WeaveController.h"

@implementation WeaveView {
    WeavePlayerController *vidPlayer;
    MovieContainerController *vidContainer;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)presentMovieWithPlayer:(WeavePlayerController*)player inController:(MovieContainerController *)mContainer{
    vidPlayer = player;
    vidContainer = mContainer;
    [player removeFromParentViewController];
    [mContainer.view addSubview:player.view];
    [player.moviePlayer play];
}

- (IBAction)onSkip:(id)sender {
    [(WeaveController*)self.nextResponder onSkip];
}

- (IBAction)onSave:(id)sender {
    [(WeaveController*)self.nextResponder onSave];
    self.saveButton.hidden = YES;
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Yay!" message:@"Your weave was saved!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
}

- (IBAction)onFacebook:(id)sender {
    self.postView.hidden = NO;
}

- (IBAction)onPost:(id)sender {
    [(WeaveController*)self.nextResponder onPostWithTitle:self.titleField.text description:self.descriptionField.text];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Yay!" message:@"Your Weave was posted!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK" , nil];
    [alert show];
    [self onCancel:self];
}

- (IBAction)onCancel:(id)sender {
    self.titleField.text = @"";
    self.descriptionField.text = @"";
    self.postView.hidden = YES;
}

- (void)finishedWeave {
    self.skipButton.hidden = YES;
    self.addButton.hidden = YES;
    self.saveButton.hidden = NO;
    self.fbButton.hidden = NO;
}

- (void)onBack {
    [vidPlayer.moviePlayer stop];
}

- (IBAction)onAdd:(id)sender {
    [(WeaveController*)self.nextResponder onAdd];
}

- (void)changeVidURL:(NSURL *)newVidURL {
    [vidPlayer removeFromParentViewController];
    [vidContainer.view addSubview:vidPlayer.view];
    [vidPlayer.moviePlayer setContentURL:newVidURL];
    [vidPlayer.moviePlayer play];
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
