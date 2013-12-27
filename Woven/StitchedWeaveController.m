//
//  StitchedWeaveController.m
//  Woven
//
//  Created by Alex Koren on 12/4/13.
//  Copyright (c) 2013 OOSE. All rights reserved.
//

#import "StitchedWeaveController.h"
#import "WeavePlayerController.h"
#import "MovieContainerController.h"
#import "StitchedWeaveView.h"
#import "Networker.h"
#import "Stitcher.h"

@interface StitchedWeaveController ()

@end

@implementation StitchedWeaveController {
    WeavePlayerController* movieController;
    MovieContainerController* mContainer;
}
@synthesize vidURL;
@synthesize weave;
@synthesize urls;
@synthesize networker = _networker;


- (Networker*) networker {
    if (_networker == nil) {
        _networker = [Networker networker];
    }
    return _networker;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    [self initVideo];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"stitchedEmbed"]) {
        mContainer = [segue destinationViewController];
    }
}

- (void)initVideo {
    movieController = [[WeavePlayerController alloc] init];
    [movieController.moviePlayer setContentURL:self.vidURL];
    [movieController.view setFrame:CGRectMake(0,0,300,400)];
    [movieController.moviePlayer prepareToPlay];
    [movieController.moviePlayer setShouldAutoplay:YES];
    movieController.moviePlayer.controlStyle = MPMovieControlStyleEmbedded;
    [(StitchedWeaveView*)self.view presentMovieWithPlayer:movieController inController:mContainer];
}

- (void)sendVideo {
    [self.networker sendVideoToNext:weave withURL:vidURL];
    [self performSegueWithIdentifier:@"fromStitchedToFeedSegue" sender:self];
}

- (void)goHome {
    [self performSegueWithIdentifier:@"fromStitchedToFeedSegue" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
