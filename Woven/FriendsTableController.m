//
//  FriendsTableController.m
//  Woven
//
//  Created by Alex Koren on 11/11/13.
//  Copyright (c) 2013 OOSE. All rights reserved.
//

#import "FriendsTableController.h"
#import <AddressBookUI/AddressBookUI.h>
#import <AddressBook/AddressBook.h>
#import <Parse/Parse.h>
#import "FriendCell.h"
#import "Weaver.h"

@interface FriendsTableController ()

@end

@implementation FriendsTableController {
    PFUser *user;
    NSMutableArray *contacts;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    user = [PFUser currentUser];
    contacts = [[NSMutableArray alloc]init];
    [self reloadTable];
}

- (void)reloadTable {
    PFRelation *friendRelation = [user relationforKey:@"Friends"];
    PFQuery *friendQuery = friendRelation.query;
    [friendQuery orderByDescending:@"DisplayName"];
    [friendQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (objects) {
            contacts = [NSMutableArray arrayWithArray:objects];
            [self.tableView reloadData];
        }
    }];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [contacts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FriendCell";
    
    FriendCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FriendCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.nameLabel.text = [[contacts objectAtIndex:indexPath.row] objectForKey:@"DisplayName"];
    Weaver *weaver = [[Weaver alloc]init];
    weaver.displayName = [[contacts objectAtIndex:indexPath.row] objectForKey:@"DisplayName"];
    weaver.email = [[contacts objectAtIndex:indexPath.row] objectForKey:@"email"];
    cell.weaver = weaver;
    return cell;
}


@end
