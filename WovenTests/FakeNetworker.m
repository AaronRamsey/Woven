//
//  FakeNetworkewr.m
//  Woven
//
//  Created by xcode-dev on 11/13/13.
//  Copyright (c) 2013 OOSE. All rights reserved.
//

#import "FakeNetworker.h"

@implementation FakeNetworker

@synthesize successfulRegistration = _successfulRegistration;
@synthesize successfulLogin = _successfulLogin;

- (void) loginWithEmail:(NSString*)email password:(NSString*)pass {
    if(self.successfulLogin) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"successfulLogin"
                                                            object:self];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"failedLogin"
                                                            object:self];
    }
    
}

- (void) registerWithEmail:(NSString*)email password:(NSString*)pass username:(NSString*)displayName {
    if(self.successfulRegistration) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"successfulRegistration"
                                                            object:self];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"failedRegistration"
                                                            object:self];
    }
}

- (void) sendVideo:(NSURL *)vidURL toWeaversWithNames:(NSMutableArray *)names targetController:(UIViewController *)targetController onSuccess:(SEL)onSuccess onFailureSetError:(SEL)onFailureSetError {
    
}

@end
