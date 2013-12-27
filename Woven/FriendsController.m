//
//  FriendsController.m
//  Woven
//
//  Created by Alex Koren on 11/11/13.
//  Copyright (c) 2013 OOSE. All rights reserved.
//

#import "FriendsController.h"
#import "Networker.h"
#import "FriendsTableController.h"

@interface FriendsController ()

@end

@implementation FriendsController {
    FriendsTableController *friendsTable;
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
	// Do any additional setup after loading the view.
}

- (void)checkFriend:(NSString*)username {
    [[Networker networker] checkForWeaver:username targetController:self onSuccess:@selector(addFriend:) onFailureSetError:@selector(noFriendFound:)];
}

- (void)onBack {
    [self performSegueWithIdentifier:@"fromFriendsToFeedSegue" sender:self];
}

-(void)onSettings {
    [self performSegueWithIdentifier:@"fromFriendsToAccountSegue" sender:self];
}

- (void)addFriend:(NSString*)username {
    [friendsTable reloadTable];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Yay!" message:[NSString stringWithFormat:@"%@ has been added!",username] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
}

- (void)noFriendFound:(NSString*)error {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Uh oh!" message:error delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString * segueName = segue.identifier;
    if ([segueName isEqualToString: @"friendsListEmbed"]) {
        friendsTable = (FriendsTableController *) [segue destinationViewController];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
