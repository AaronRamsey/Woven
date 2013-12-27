//
//  Networker.m
//  Woven
//
//  Created by Alex Koren on 10/28/13.
//  Copyright (c) 2013 OOSE. All rights reserved.
//

#import "Networker.h"
#import <Parse/Parse.h>
#import "Weaver.h"

@implementation Networker
- (void) loginWithEmail:(NSString*)email password:(NSString*)pass {
    [PFUser logInWithUsernameInBackground:email password:pass
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            [[NSNotificationCenter defaultCenter]
                                             postNotificationName:@"successfulLogin" object:self];
                                        } else {
                                            NSString *errorString = [error userInfo][@"error"];
                                            NSLog(@"%@",errorString);
                                            [[NSNotificationCenter defaultCenter]
                                             postNotificationName:@"failedLogin" object:self
                                             userInfo:[NSDictionary dictionaryWithObject:errorString
                                                                                  forKey:@"error"]];
                                        }
                                    }];
}

- (void) registerWithEmail:(NSString*)email password:(NSString*)pass username:(NSString*)displayName {
    PFQuery *userQuery = [PFUser query];
    [userQuery whereKey:@"DisplayName" equalTo:displayName];
    [userQuery getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (!object) {
            PFUser *user = [PFUser user];
            user.username = email;
            user.password = pass;
            user.email = email;
            
            [user setObject:displayName forKey:@"DisplayName"];
            
            [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!error) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"failedLogin" object:self];
                } else {
                    NSString *errorString = [error userInfo][@"error"];
                    NSLog(@"%@",errorString);
                    [[NSNotificationCenter defaultCenter]
                     postNotificationName:@"failedLogin" object:self
                     userInfo:[NSDictionary dictionaryWithObject:errorString forKey:@"error"]];
                }
            }];
        } else {
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"failedLogin" object:self
             userInfo:[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%@ is already taken!",displayName] forKey:@"error"]];
        }
    }];
    
}

- (void)addFriend:(PFUser*)friend targetController:(UIViewController*)targetController onSuccess:(SEL)onSuccess onFailureSetError:(SEL)onFailureSetError {
    PFRelation *friendRelation = [[PFUser currentUser] objectForKey:@"Friends"];
    [friendRelation addObject:friend];
    [[PFUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [targetController performSelector:onSuccess withObject:[friend objectForKey:@"DisplayName"] afterDelay:0.0];
        } else {
            [targetController performSelector:onFailureSetError withObject:nil afterDelay:0.0];
        }
    }];
}

- (void)sendVideo:(NSURL*)vidURL toWeaversWithNames:(NSMutableArray*)names
         targetController:(UIViewController*)targetController
         onSuccess:(SEL)onSuccess onFailureSetError:(SEL)onFailureSetError {
    NSData *movie = [NSData dataWithContentsOfURL:vidURL];
    PFFile *movieFile = [PFFile fileWithData:movie];
    PFObject *weave = [PFObject objectWithClassName:@"Weave"];
    [weave setObject:names forKey:@"Next"];
    NSMutableArray *answered = [[NSMutableArray alloc]init];
    [answered addObject:[[PFUser currentUser] objectForKey:@"DisplayName"]];
    [weave setObject:answered forKey:@"Answered"];
    PFRelation *senderRelation = [weave relationforKey:@"Sender"];
    [senderRelation addObject:[PFUser currentUser]];
    [weave setObject:movieFile forKey:@"Video"];
    [weave saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [targetController performSelector:onSuccess withObject:nil afterDelay:0.0];
        } else {
            [targetController performSelector:onFailureSetError withObject:@"Video not sent!" afterDelay:0.0];
        }
    }];
    /*PFRelation *friendRelation = [[PFUser currentUser] relationforKey:@"Friends"];
    [[friendRelation query] findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSMutableArray *next = [[NSMutableArray alloc]init];
        NSMutableArray *answered = [[NSMutableArray alloc]init];
        for (PFObject *friend in objects) {
            [next addObject:[friend objectId]];
        }
        [weave setObject:next forKey:@"Next"];
        [weave setObject:answered forKey:@"Answered"];
        PFRelation *senderRelation = [weave relationforKey:@"Sender"];
        [senderRelation addObject:[PFUser currentUser]];
        [weave setObject:movieFile forKey:@"Video"];
        [weave saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                [targetController performSelector:onSuccess withObject:nil afterDelay:0.0];
            } else {
                [targetController performSelector:onFailureSetError withObject:@"Video not sent!" afterDelay:0.0];
            }
        }];
    }];*/
}

- (void) logOutWithController:(UIViewController*)targetController onSuccess:(SEL)onSuccess {
    [PFUser logOut];
    [targetController performSelector:onSuccess withObject:nil afterDelay:0.0];
    
}

- (BOOL) isLoggedOn {
    return [PFUser currentUser] != nil;
}

- (void)checkForWeaver:(NSString*)username targetController:(UIViewController*)targetController
             onSuccess:(SEL)onSuccess
     onFailureSetError:(SEL)onFailureSetError
{
    if ([username isEqualToString:[[PFUser currentUser] objectForKey:@"DisplayName"]]) {
        [targetController performSelector:onFailureSetError withObject:@"You can't add yourself as a friend!" afterDelay:0.0];
        return;
    }
    PFRelation *friendRelation = [[PFUser currentUser] relationforKey:@"Friends"];
    PFQuery *friendQuery = friendRelation.query;
    [friendQuery whereKey:@"DisplayName" equalTo:username];
    [friendQuery getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (object) {
            [targetController performSelector:onFailureSetError withObject:[NSString stringWithFormat:@"You're already friends with %@!",username] afterDelay:0.0];
        } else {
            PFQuery *userQuery = [PFUser query];
            [userQuery whereKey:@"DisplayName" equalTo:username];
            [userQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (![objects count]) {
                    [targetController performSelector:onFailureSetError withObject:@"That Weaver doesn't exist!" afterDelay:0.0];
                } else {
                    [self addFriend:[objects objectAtIndex:0] targetController:targetController onSuccess:onSuccess onFailureSetError:onFailureSetError];
                }
            }];
        }
    }];
}

- (void)skipWeave:(PFObject *)weave {
    NSMutableArray *next = [weave objectForKey:@"Next"];
    [next removeObject:[next objectAtIndex:0]];
    [weave setObject:next forKey:@"Next"];
    [weave saveInBackground];
}

- (void)sendVideoToNext:(PFObject *)weave withURL:(NSURL*)vidURL {
    NSData *movie = [NSData dataWithContentsOfURL:vidURL];
    PFFile *movieFile = [PFFile fileWithData:movie];
    NSMutableArray *next = [weave objectForKey:@"Next"];
    NSMutableArray *answered = [weave objectForKey:@"Answered"];
    NSString *nextUser = [next objectAtIndex:0];
    [next removeObjectAtIndex:0];
    [answered addObject:nextUser];
    [weave setObject:next forKey:@"Next"];
    [weave setObject:answered forKey:@"Answered"];
    [weave setObject:movieFile forKey:@"Video"];
    [weave saveInBackground];
}

+ (id)networker {
    static Networker *networker = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networker = [[self alloc]init];
    });
    return networker;
}

- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void) dealloc {
    
}

@end