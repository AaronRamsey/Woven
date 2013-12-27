//
//  CreateWeaveController.m
//  Woven
//
//  Created by Alex Koren on 10/28/13.
//  Copyright (c) 2013 OOSE. All rights reserved.
//

#import "CreateWeaveController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "CreateWeaveView.h"
#import "WeavePlayerController.h"
#import "MovieContainerController.h"
#import "ChooseFriendsController.h"

@interface CreateWeaveController ()

@end

@implementation CreateWeaveController {
    WeavePlayerController* movieController;
    MovieContainerController* mContainer;
    BOOL didCancel;
}

@synthesize networker = _networker;
@synthesize vidURL = _vidURL;

- (Networker*) networker {
    if (_networker == nil) {
        _networker = [Networker networker];
    }
    return _networker;
}

- (void)chooseFriends {
    ChooseFriendsController *chooseFriendsController = [[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil]instantiateViewControllerWithIdentifier:@"chooseFriendsController"];
    [self presentViewController:chooseFriendsController animated:YES completion:^(void){}];
}

- (void)sendVideo:(NSNotification*)notification {
    NSMutableArray *weavers = [[NSMutableArray alloc]init];
    if ([[notification name] isEqualToString:@"sendVideo"]) {
        weavers = [notification.userInfo objectForKey:@"weavers"];
        [self.networker sendVideo:self.vidURL toWeaversWithNames:weavers targetController:self onSuccess:@selector(videoSent) onFailureSetError:@selector(sendVideoFailed:)];
        [(CreateWeaveView*)self.view sendingVideo];
    }
}

- (void)videoSent {
    [(CreateWeaveView*)self.view videoSent];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)sendVideoFailed:(NSString*)error {
    [(CreateWeaveView*)self.view sendVideoFailed:error];
}

- (void)backToFeed {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self performSegueWithIdentifier:@"fromCreateToFeedSegue" sender:self];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    didCancel = YES;
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:NULL];
    self.vidURL = [info objectForKey:UIImagePickerControllerMediaURL];
    movieController = [[WeavePlayerController alloc] init];
    [movieController.moviePlayer setContentURL:self.vidURL];
    [movieController.view setFrame:CGRectMake(0,0,300,400)];
    [movieController.moviePlayer prepareToPlay];
    [movieController.moviePlayer setShouldAutoplay:YES];
    movieController.moviePlayer.controlStyle = MPMovieControlStyleEmbedded;
    [(CreateWeaveView*)self.view presentMovieWithPlayer:movieController inController:mContainer];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"weaveCreateEmbed"]) {
        mContainer = [segue destinationViewController];
    }
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
    [(CreateWeaveView*)self.view initialize];
    didCancel = NO;
	// Do any additional setup after loading the view.
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendVideo:)
                                                     name:@"sendVideo" object:nil];
    }
    return self;
}

- (void)dealloc {
    
}

- (void)viewDidAppear:(BOOL)animated {
    if (self.vidURL == nil && !didCancel) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
        picker.videoMaximumDuration = 10;
        picker.videoQuality = UIImagePickerControllerQualityTypeLow;
        [self presentViewController:picker animated:YES completion:NULL];
    } else if (didCancel) {
        [self performSegueWithIdentifier:@"fromCreateToFeedSegue" sender:self];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
