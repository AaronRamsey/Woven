//
//  FeedTableController.m
//  Woven
//
//  Created by Alex Koren on 11/6/13.
//  Copyright (c) 2013 OOSE. All rights reserved.
//

#import "FeedTableController.h"
#import "WeaveController.h"
#import "FeedCell.h"

@interface FeedTableController ()

@end

@implementation FeedTableController
PFUser *user;
NSMutableArray *weaveList;
PFObject *currentWeave;

- (void)viewDidLoad
{
    [super viewDidLoad];
    weaveList = [[NSMutableArray alloc]init];
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    user = [PFUser currentUser];
    [super viewDidAppear:animated];
    //[self queryForTable];
    [self loadObjects];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (PFQuery*)queryForTable {
    if (user) {
        PFQuery *senderQuery = [PFQuery queryWithClassName:@"Weave"];
        [senderQuery whereKey:@"Sender" equalTo:user];
        
        PFQuery *nextQuery = [PFQuery queryWithClassName:@"Weave"];
        [nextQuery whereKey:@"Next" equalTo:[[PFUser currentUser] objectForKey:@"DisplayName"]];
        
        PFQuery *answeredQuery = [PFQuery queryWithClassName:@"Weave"];
        [answeredQuery whereKey:@"Answered" equalTo:[[PFUser currentUser] objectForKey:@"DisplayName"]];
        
        
        
        PFQuery *LQuery = [PFQuery orQueryWithSubqueries:[NSArray arrayWithObjects:senderQuery,nextQuery,answeredQuery,nil]];
        
        if (self.pullToRefreshEnabled) {
            LQuery.cachePolicy = kPFCachePolicyNetworkOnly;
        }
        if (self.objects.count == 0) {
            LQuery.cachePolicy = kPFCachePolicyCacheThenNetwork;
        }
        
        LQuery.limit = 100;
        
        [LQuery orderByDescending:@"createdAt"];
        
        return LQuery;
    }
    return NULL;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    
    // This method is called every time objects are loaded from Parse via the PFQuery
    
    [weaveList removeAllObjects];
    for (PFObject *object in self.objects) {
        [weaveList addObject:object];
    }
}

- (BOOL)isMyWeave:(PFObject*)weave {
    if ([[[weave objectForKey:@"Answered"] objectAtIndex:0] isEqualToString:[[PFUser currentUser] objectForKey:@"DisplayName"]]) {
        return YES;
    }
    return NO;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
                        object:(PFObject *)object
{
    
    static NSString *CellIdentifier = @"FeedCell";
    
    FeedCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FeedCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.hidden = YES;
    NSMutableArray *next = [object objectForKey:@"Next"];
    if ([self isMyWeave:object]) {
        cell.senderLabel.text = @"My Weave";
    } else {
        cell.senderLabel.text = [NSString stringWithFormat:@"Weave from %@",[[object objectForKey:@"Answered"] objectAtIndex:0]];
    }
    
    if ([next count] == 0) {
        cell.statusImage.image = [UIImage imageNamed:@"have_small"];
        cell.userInteractionEnabled = YES;
    } else if ([[next objectAtIndex:0] isEqualToString:[[PFUser currentUser] objectForKey:@"DisplayName"]]) {
        cell.statusImage.image = [UIImage imageNamed:@"haventviewed"];
        cell.userInteractionEnabled = YES;
    } else {
        cell.statusImage.image = [UIImage imageNamed:@"cantview"];
        cell.userInteractionEnabled = NO;
    }
    cell.hidden = NO;
    cell.dateLabel.text = [self timeDif:object.createdAt];
    return cell;
}

-(NSString*)timeDif:(NSDate*)date {
    NSCalendar *Calander = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    [dateFormat setDateFormat:@"dd"];
    [comps setDay:[[dateFormat stringFromDate:[NSDate date]] intValue]];
    [dateFormat setDateFormat:@"MM"];
    [comps setMonth:[[dateFormat stringFromDate:[NSDate date]] intValue]];
    [dateFormat setDateFormat:@"yyyy"];
    [comps setYear:[[dateFormat stringFromDate:[NSDate date]] intValue]];
    [dateFormat setDateFormat:@"HH"];
    [comps setHour:[[dateFormat stringFromDate:[NSDate date]] intValue]];
    [dateFormat setDateFormat:@"mm"];
    [comps setMinute:[[dateFormat stringFromDate:[NSDate date]] intValue]];
    
    NSDate *currentDate=[Calander dateFromComponents:comps];
    
    //NSLog(@"Current Date is :- '%@'",currentDate);
    
    
    [dateFormat setDateFormat:@"dd"];
    [comps setDay:[[dateFormat stringFromDate:date] intValue]];
    [dateFormat setDateFormat:@"MM"];
    [comps setMonth:[[dateFormat stringFromDate:date] intValue]];
    [dateFormat setDateFormat:@"yyyy"];
    [comps setYear:[[dateFormat stringFromDate:date] intValue]];
    [dateFormat setDateFormat:@"HH"];
    [comps setHour:[[dateFormat stringFromDate:date] intValue]];
    [dateFormat setDateFormat:@"mm"];
    [comps setMinute:[[dateFormat stringFromDate:date] intValue]];
    
    NSDate *reminderDate=[Calander dateFromComponents:comps];
    
    //NSLog(@"Current Date is :- '%@'",reminderDate);
    
    //NSLog(@"Current Date is :- '%@'",currentDate);
    
    NSTimeInterval ti = [reminderDate timeIntervalSinceDate:currentDate];
    //NSLog(@"Time Interval is :- '%f'",ti);
    int days = abs(ti/86400);
    if (days == 0) {
        [dateFormat setDateFormat:@"HH:mm"];
        NSString *d = [dateFormat stringFromDate:date];
        d = [NSString stringWithFormat:@"%@ %@",@"Today at",d];
        return d;
    } else if (days == 1) {
        [dateFormat setDateFormat:@"HH:mm"];
        NSString *d = [dateFormat stringFromDate:date];
        d = [NSString stringWithFormat:@"%@ %@",@"Yesterday at",d];
        return d;
    } else if (days < 7) {
        return [NSString stringWithFormat:@"%d days ago",days];
    } else  if (days < 14) {
        return @"1 week ago";
    } else {
        return [NSString stringWithFormat:@"%d weeks ago",days/7];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    currentWeave = [weaveList objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"toWeaveSegue" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toWeaveSegue"]) {
        WeaveController *destController = segue.destinationViewController;
        destController.weave = currentWeave;
    }
}
@end

