//
//  AccountViewController.m
//  Woven
//
//  Created by Benjamin Glickman on 12/16/13.
//  Copyright (c) 2013 OOSE. All rights reserved.
//

#import "AccountViewController.h"

@interface AccountViewController ()

@end

@implementation AccountViewController

@synthesize networker = _networker;

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (Networker*) networker {
    if (_networker == nil) {
        _networker = [Networker networker];
    }
    return _networker;
}

- (void)onLogoutButton {
    [self.networker logOutWithController:self onSuccess:@selector(loggedOut)];
}

- (void)loggedOut {
    [self performSegueWithIdentifier:@"fromAccountToLoginSegue" sender:self];
}

- (void)onBack {
    [self performSegueWithIdentifier:@"fromAccountToFriendsSegue" sender:self];
}

@end
