//
//  NetworkerTest.m
//  Woven
//
//  Created by xcode-dev on 11/13/13.
//  Copyright (c) 2013 OOSE. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Networker.h"



@interface NetworkerTest : XCTestCase
@property (nonatomic) BOOL methodCalled;

@end

@implementation NetworkerTest

@synthesize methodCalled = _methodCalled;

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testNetworkerLoginSuccess {
    NSString* username = @"kingcarlo1@gmail.com"; //Set a valid email
    NSString* password = @"password"; //Set a valid password
    
    [self setMethodCalled:NO]; //set flag to false
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(listenerCalled)
                                                name:@"successfulLogin"object:nil]; //Sets up a listener
    Networker* networkerUnderTest = [Networker networker]; //Create a networker
    //Send email and password to networker
    [networkerUnderTest loginWithEmail:username password:password];
    [NSThread sleepForTimeInterval:5]; //wait 5 seconds to see if listener is called
    
    XCTAssertTrue(self.methodCalled, @"Login failed with valid credentials");
    
}

- (void)listenerCalled
{
    [self setMethodCalled:YES];
}

- (void)testNetworkerLoginFail {
    NSString* username = @"username@doesntexist.com"; //Set an invalid email
    NSString* password = @"pass"; //Set a password
    
    [self setMethodCalled:NO]; //set flag to false
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(listenerCalled)
                                                 name:@"failedLogin"object:nil];
    Networker* networkerUnderTest = [Networker networker];
    [networkerUnderTest loginWithEmail:username password:password];
    [NSThread sleepForTimeInterval:5]; //wait 5 seconds to see if listener is called
    XCTAssertTrue(self.methodCalled, @"Login failed with valid credentials");
    
    
    username = @"blah"; //set an incorrect email
    [self setMethodCalled:NO]; //set flag to false
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(listenerCalled)
                                                 name:@"failedLogin"object:nil];
    [networkerUnderTest loginWithEmail:username password:password];
    [NSThread sleepForTimeInterval:5]; //wait 5 seconds to see if listener is called
    XCTAssertTrue(self.methodCalled, @"Login failed with valid credentials");
    
    
    username = @"kingcarlo1@gmail.com"; //set a valid email
    password = @"asdf"; //set an invalid password
    [self setMethodCalled:NO]; //set flag to false
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(listenerCalled)
                                                 name:@"failedLogin"object:nil];
    [networkerUnderTest loginWithEmail:username password:password];
    [NSThread sleepForTimeInterval:5]; //wait 5 seconds to see if listener is called
    XCTAssertTrue(self.methodCalled, @"Login failed with valid credentials");
    
}



@end
