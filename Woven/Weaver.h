//
//  User.h
//  Woven
//
//  Created by Alex Koren on 10/28/13.
//  Copyright (c) 2013 OOSE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

/**
 Class that holds a Weaver's information. Subclass of NSObject
 */
@interface Weaver : NSObject
/**
 The Weaver's display name.
 */
@property (nonatomic, retain) NSString *displayName;
/**
 The Weaver's email.
 */
@property (nonatomic, retain) NSString *email;


@end
