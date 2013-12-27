//
//  ChooseFriendsController.m
//  Woven
//
//  Created by Alex Koren on 11/16/13.
//  Copyright (c) 2013 OOSE. All rights reserved.
//

#import "ChooseFriendsController.h"
#import "ChooseFriendsView.h"
#import "ChooseFriendsTableController.h"
#import "Weaver.h"

@interface ChooseFriendsController ()

@end

@implementation ChooseFriendsController {
    ChooseFriendsTableController *friendsTable;
    NSMutableArray *weavers;
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
	[(ChooseFriendsView*)self.view initialize];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weaverChosen:)
                                                 name:@"weaverChosen" object:nil];
    weavers = [[NSMutableArray alloc]init];
}

- (void)backToFeed {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self performSegueWithIdentifier:@"fromChooseToFeedSegue" sender:self];
}

- (void)backToCamera {
    [self dismissViewControllerAnimated:YES completion:^(void){}];
}

- (void)weaverChosen:(NSNotification*)notification {
    if ([[notification name] isEqualToString:@"weaverChosen"]) {
        [(ChooseFriendsView*)self.view addWeaver:[notification.userInfo objectForKey:@"weaver"]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString * segueName = segue.identifier;
    if ([segueName isEqualToString: @"chooseFriendsListEmbed"]) {
        friendsTable = (ChooseFriendsTableController *) [segue destinationViewController];
    }
}

@end
