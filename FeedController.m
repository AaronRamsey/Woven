//
//  FeedController.m
//  Woven
//
//  Created by Alex Koren on 11/13/13.
//  Copyright (c) 2013 OOSE. All rights reserved.
//

#import "FeedController.h"
#import "Networker.h"
#import "CreateWeaveController.h"

@interface FeedController ()

@end

@implementation FeedController {
    CreateWeaveController *createWeaveController;
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

- (void)onCreate {
    [self performSegueWithIdentifier:@"fromFeedToCreateSegue" sender:self];
    
}

- (void)loggedOut {
    [self performSegueWithIdentifier:@"fromFeedToLoginSegue" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
