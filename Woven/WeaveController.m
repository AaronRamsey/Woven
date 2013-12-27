//
//  WeaveController.m
//  Woven
//
//  Created by Alex Koren on 11/6/13.
//  Copyright (c) 2013 OOSE. All rights reserved.
//

#import "WeaveController.h"
#import "WeavePlayerController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "MovieContainerController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "WeaveView.h"
#import "Networker.h"
#import "Stitcher.h"
#import "StitchedWeaveController.h"
#import <Social/Social.h>

@interface WeaveController ()

@end

@implementation WeaveController {
    WeavePlayerController* movieController;
    MovieContainerController* mContainer;
    StitchedWeaveController *swController;
    NSURL *vidURL;
    BOOL firstTime;
    NSURL *newVidURL;
    ACAccountStore *accountStore;
    ACAccount *fbAccount;
    NSArray *urls;
}

@synthesize weave;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL)isFinished {
    return ([[weave objectForKey:@"Next"] count] == 0);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishedStitching:)
                                                 name:@"finishedStitching" object:nil];
    if ([self isFinished]) {
        [(WeaveView*)self.view finishedWeave];
    }
    [[weave objectForKey:@"Video"] getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *appFile = [documentsDirectory stringByAppendingPathComponent:@"video.m4v"];
        [data writeToFile:appFile atomically:YES];
        vidURL = [NSURL fileURLWithPath:appFile];
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(finishedStitching:)
                                                 name:@"finishedStitching" object:nil];
    firstTime = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [(WeaveView*)self.view onBack];
}

- (void)onSave {
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    if ([library videoAtPathIsCompatibleWithSavedPhotosAlbum:vidURL])
    {
        [library writeVideoAtPathToSavedPhotosAlbum:vidURL
                                    completionBlock:^(NSURL *assetURL, NSError *error){}
         ];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    // TODO: Why is this here? According to the storyboard, the view will only appear once per
    // ViewController's lifecycle. I don't see how this method would be called twice.  
    if (firstTime) {
        movieController = [[WeavePlayerController alloc] init];
        [movieController.moviePlayer setContentURL:vidURL];
        [movieController.view setFrame:CGRectMake(0,0,300,400)];
        [movieController.moviePlayer prepareToPlay];
        [movieController.moviePlayer setShouldAutoplay:YES];
        movieController.moviePlayer.controlStyle = MPMovieControlStyleEmbedded;
        [(WeaveView*)self.view presentMovieWithPlayer:movieController inController:mContainer];
        firstTime = NO;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"weaveEmbed"]) {
        mContainer = [segue destinationViewController];
    } else if ([segue.identifier isEqualToString:@"fromWeaveToStitchedSegue"]) {
        swController = (StitchedWeaveController*) segue.destinationViewController;
        swController.vidURL = newVidURL;
        swController.urls = urls;
        swController.weave = weave;
    }
}

- (void)onSkip {
    [[Networker networker] skipWeave:weave];
    [self performSegueWithIdentifier:@"fromWeaveToFeedSegue" sender:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) onPostWithTitle:(NSString*)title description:(NSString*)description {
    accountStore = [[ACAccountStore alloc] init];
    ACAccountType *fbAccountType = [accountStore
                                    accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
    NSDictionary *options = @{ACFacebookAppIdKey : @"252983111529141",
                              ACFacebookPermissionsKey : @[@"email"],
                              ACFacebookAudienceKey:ACFacebookAudienceFriends};
    
    [accountStore requestAccessToAccountsWithType:fbAccountType
                                          options:options
                                       completion:^(BOOL granted, NSError *error) {
                                           if (granted) {
                                               NSDictionary *permissions = @{ACFacebookAppIdKey : @"252983111529141",
                                                                             ACFacebookPermissionsKey : @[@"publish_actions"],
                                                                             ACFacebookAudienceKey:ACFacebookAudienceFriends};
                                               [accountStore requestAccessToAccountsWithType:fbAccountType
                                                                                     options:permissions
                                                                                  completion:^(BOOL granted, NSError *error)
                                                {
                                                    NSArray *accounts = [accountStore
                                                                         accountsWithAccountType:fbAccountType];
                                                    fbAccount = [accounts lastObject];
                                                    
                                                    ACAccountCredential *fbCredential = [fbAccount credential];
                                                    NSString *accessToken = [fbCredential oauthToken];
                                                    NSLog(@"Facebook Access Token: %@", accessToken);
                                                    NSURL *videourl = [NSURL URLWithString:@"https://graph.facebook.com/me/videos"];
                                                    
                                                    NSData *videoData = [NSData dataWithContentsOfFile:[vidURL path]];
                                                    
                                                    NSDictionary *params = @{
                                                                             @"title": title,
                                                                             @"description": description
                                                                             };
                                                    
                                                    SLRequest *uploadRequest = [SLRequest requestForServiceType:SLServiceTypeFacebook
                                                                                                  requestMethod:SLRequestMethodPOST
                                                                                                            URL:videourl
                                                                                                     parameters:params];
                                                    [uploadRequest addMultipartData:videoData
                                                                           withName:@"source"
                                                                               type:@"video/quicktime"
                                                                           filename:[vidURL absoluteString]];
                                                    
                                                    uploadRequest.account = fbAccount;
                                                    NSLog(@"%@",[vidURL absoluteString]);
                                                    [uploadRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                                                        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
                                                        if(error){
                                                            NSLog(@"Error %@", error.localizedDescription);
                                                        }else
                                                            NSLog(@"%@", responseString);
                                                    }];
                                                }];
                                               
                                           } else {
                                               NSLog(@"Access not granted");
                                               NSLog(@"%@",error);
                                           }
                                       }];

}


- (void)onAdd {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
    picker.videoMaximumDuration = 10;
    picker.videoQuality = UIImagePickerControllerQualityTypeLow;
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^(void){
        urls = @[vidURL, [info objectForKey:UIImagePickerControllerMediaURL]];
        [[Stitcher stitcher] performStitch:urls];
    }];
}

- (void)finishedStitching:(NSNotification*)notification {
    if ([[notification name] isEqualToString:@"finishedStitching"]) {
        newVidURL = [notification.userInfo objectForKey:@"url"];
        [self performSegueWithIdentifier:@"fromWeaveToStitchedSegue" sender:self];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UIView *view in self.view.subviews) {
        for (UIView *sView in view.subviews) {
            [sView resignFirstResponder];
        }
        [view resignFirstResponder];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
