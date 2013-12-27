//
//  ChooseFriendsTableController.m
//  Woven
//
//  Created by Alex Koren on 11/16/13.
//  Copyright (c) 2013 OOSE. All rights reserved.
//

#import "ChooseFriendsTableController.h"
#import <Parse/Parse.h>
#import "FriendCell.h"
@interface ChooseFriendsTableController ()

@end

@implementation ChooseFriendsTableController {
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
    PFQuery *userQuery = [PFUser query];
    [userQuery whereKey:@"DisplayName" equalTo:[[PFUser currentUser] objectForKey:@"DisplayName"]];
    PFQuery *uQuery = [PFQuery orQueryWithSubqueries:[NSArray arrayWithObjects:friendQuery,userQuery,nil]];
    [uQuery orderByDescending:@"DisplayName"];
    [uQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FriendCell *selected = (FriendCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"weaverChosen" object:self
     userInfo:[NSDictionary dictionaryWithObject:selected.weaver
                                          forKey:@"weaver"]];
    
}

@end
