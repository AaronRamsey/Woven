//
//  FakeNetworkewr.h
//  Woven
//
//  Created by xcode-dev on 11/13/13.
//  Copyright (c) 2013 OOSE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Networker.h"

@interface FakeNetworker : Networker

@property (nonatomic) BOOL successfulLogin;
@property (nonatomic) BOOL successfulRegistration;


@end
