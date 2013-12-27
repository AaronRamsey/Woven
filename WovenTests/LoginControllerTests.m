//
//  LoginControllerTests.m
//  LoginControllerTests
//
//  Created by Alex Koren on 10/28/13.
//  Copyright (c) 2013 OOSE. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LoginController.h"
#import "LoginView.h"
#import "OCMock/OCMock.h"
#import "FakeNetworker.h"


@interface LoginControllerTests : XCTestCase

@end

@implementation LoginControllerTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testLogin {
    LoginController* lCont = [[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"login"];
    LoginView* lView = (LoginView*)lCont.view;
    XCTAssert([lView getIsRegister] == NO, @"Fail. Login screen should start as login, not as register");
    [lView onRegister:self];
    XCTAssert([lView getIsRegister] == YES, @"Fail. After clicking New User, view should be in register mode");
    [lView onRegister:self];
    XCTAssert([lView getIsRegister] == NO, @"Fail. After clicking Cancel, login should show");
}


- (void)testCallSegueToHomeMethodOnLoginSuccess {
    
    NSString* username = @"kingcarlo1@gmail.com"; //Set a valid email
    NSString* password = @"password"; //Set a valid password
    
    FakeNetworker* fakeNetworker = [[FakeNetworker alloc]init];
    [fakeNetworker setSuccessfulLogin:YES];
    LoginController* loginController = [[LoginController alloc] init];
    [loginController setNetworker:fakeNetworker];
    OCMockObject* mockLoginController = [OCMockObject partialMockForObject:loginController];

    [[mockLoginController expect] segueToHome:OCMOCK_ANY];
    
    [loginController loginWithEmail:username password:password];
    
    [mockLoginController verify];
}

- (void)testCallSetErrorOnLoginFailure {
    NSString* username = @"kingcarlo1"; //Set a valid email
    NSString* password = @"password"; //Set a valid password

    FakeNetworker* fakeNetworker = [[FakeNetworker alloc]init];
    [fakeNetworker setSuccessfulLogin:NO];
    LoginController* loginController = [[LoginController alloc] init];
    [loginController setNetworker:fakeNetworker];
    OCMockObject* mockLoginController = [OCMockObject partialMockForObject:loginController];
    
    [[mockLoginController expect] setError:OCMOCK_ANY];
    
    [loginController loginWithEmail:username password:password];
    
    [mockLoginController verify];
}

@end
