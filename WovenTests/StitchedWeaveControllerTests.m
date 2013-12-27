//
//  StitchedWeaveControllerTests.m
//  Woven
//
//  Created by xcode-dev on 12/6/13.
//  Copyright (c) 2013 OOSE. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FakeNetworker.h"
#import "OCMock/OCMock.h"
#import "StitchedWeaveView.h"
#import "StitchedWeaveController.h"

@interface StitchedWeaveControllerTests : XCTestCase

@end

@implementation StitchedWeaveControllerTests

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

- (void)testExample
{
    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

// Need to figure out how to account for sendVideo's call to a segue.
/*
- (void)testSendVideoToNext {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone.storyboard" bundle:[NSBundle bundleForClass:[self class]]];
    FakeNetworker* fakeNetworker = [[FakeNetworker alloc]init];
    StitchedWeaveController* stitchedWeaveController = [[StitchedWeaveController alloc] initWithCoder:Nil];
    StitchedWeaveView *stitchedWeaveView = [[StitchedWeaveView alloc] init];
    [stitchedWeaveController setView:stitchedWeaveView];
    OCMockObject* mockNetworker = [OCMockObject partialMockForObject:fakeNetworker];
    
    [stitchedWeaveController setNetworker:fakeNetworker];
    
    [[mockNetworker expect] sendVideoToNext:OCMOCK_ANY withURL:OCMOCK_ANY];
    
    
    [stitchedWeaveController sendVideo];
    [mockNetworker verify];
}
*/
@end
