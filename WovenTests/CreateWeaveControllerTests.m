    //
//  CreateWeaveControllerTests.m
//  Woven
//
//  Created by xcode-dev on 12/5/13.
//  Copyright (c) 2013 OOSE. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FakeNetworker.h"
#import "CreateWeaveView.h"
#import "CreateWeaveController.h"
#import "OCMock/OCMock.h"


@interface CreateWeaveControllerTests : XCTestCase
@property (nonatomic) BOOL methodCalled;

@end

@implementation CreateWeaveControllerTests

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

- (void)testNetworkersSendVideoCalled {

    NSMutableArray *weavers = [[NSMutableArray alloc]init];
    FakeNetworker* fakeNetworker = [[FakeNetworker alloc]init];
    CreateWeaveController* createWeaveController = [[CreateWeaveController alloc] initWithCoder:Nil];
    CreateWeaveView *createWeaveView = [[CreateWeaveView alloc] init];
    [createWeaveController setView:createWeaveView];
    OCMockObject* mockNetworker = [OCMockObject partialMockForObject:fakeNetworker];
    
    [createWeaveController setNetworker:fakeNetworker];

    [[mockNetworker expect] sendVideo:createWeaveController.vidURL
                   toWeaversWithNames:weavers
                     targetController:createWeaveController
                            onSuccess:@selector(videoSent)
                    onFailureSetError:@selector(sendVideoFailed:)];
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"sendVideo" object:self
     userInfo:[NSDictionary dictionaryWithObject:weavers
                                          forKey:@"weavers"]];
    [mockNetworker verify];

    
}

- (void)testAddedSendVideoObserversDuringInitialization {
    NSMutableArray *weavers = [[NSMutableArray alloc]init];
    CreateWeaveController* createWeaveController = [[CreateWeaveController alloc] initWithCoder:Nil];
    OCMockObject* mockCreateWeaveController = [OCMockObject partialMockForObject:createWeaveController];
    
    [[mockCreateWeaveController expect] sendVideo:OCMOCK_ANY];

    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"sendVideo" object:self
     userInfo:[NSDictionary dictionaryWithObject:weavers
                                          forKey:@"weavers"]];
    [mockCreateWeaveController verify];
}

@end
