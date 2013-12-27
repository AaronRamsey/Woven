//
//  LoginController.m
//  Woven
//
//  Created by Ben Glickman on 10/28/13.
//  Copyright (c) 2013 OOSE. All rights reserved.
//

#import "LoginController.h"
#import "Networker.h"
#import "LoginView.h"

@interface LoginController ()

@end

@implementation LoginController {
    LoginView *childView;
}
@synthesize networker = _networker;

- (Networker*) networker {
    if (_networker == nil) {
        _networker = [Networker networker];
    }
    return _networker;
}

- (void)loginWithEmail:(NSString*)email password:(NSString*)pass {
    [self.networker loginWithEmail:email password:pass];
}
- (void)registerWithEmail:(NSString*)email password:(NSString*)pass username:(NSString*)username {
    [self.networker registerWithEmail:email password:pass username:username];
}

- (void) segueToHome:(NSNotification*) notification {
    // We check which notification called this method. In the future, may have different segue for
    // login vs register.
    if ([[notification name] isEqualToString:@"successfulLogin"]) {
        [self performSegueWithIdentifier:@"fromLoginToFeedSegue" sender:self];
    }  else if ([[notification name] isEqualToString:@"successfulRegistration"]) {
        [self performSegueWithIdentifier:@"fromLoginToFeedSegue" sender:self];
    }
    
}

-(void) setError:(NSNotification *)notification {
    if ([[notification name] isEqualToString:@"failedLogin"]) {
        [childView setError:[notification.userInfo objectForKey:@"error"]];
    } else if ([[notification name] isEqualToString:@"failedRegistration"]) {
        [childView setError:[notification.userInfo objectForKey:@"error"]];
    }
}

- (id)init {
    self = [super init];
    if (self) {
        [self addObservers];
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addObservers];

    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)addObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(segueToHome:)
                                                 name:@"successfulLogin"object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(segueToHome:)
                                                 name:@"successfulRegistration" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setError:)
                                                 name:@"failedLogin" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setError:)
                                                 name:@"failedRegistration" object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    childView = (LoginView*)self.view;
    [childView initialize];
    childView.emailField.hidden = YES;
    childView.passwordField.hidden = YES;
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    if ([[Networker networker] isLoggedOn]) {
        [self performSegueWithIdentifier:@"fromLoginToFeedSegue" sender:self];
    } else {
        childView.emailField.hidden = NO;
        childView.passwordField.hidden = NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UIView *view in self.view.subviews) {
        for (UIView *sView in view.subviews) {
            [sView resignFirstResponder];
        }
        [view resignFirstResponder];
    }
}

@end
