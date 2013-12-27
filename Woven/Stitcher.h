//
//  Stitcher.h
//  Woven
//
//  Created by Alex Koren on 12/3/13.
//  Copyright (c) 2013 OOSE. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
Singleton of the stitcher
 */
@interface Stitcher : NSObject

/**
returns the singleton object of the stitched
 */
+(id)stitcher;

/**
 Stitches the two videos together
 @param vidURL1 the URL of the first video
 @param vidURL2 the URL of the video to be added on the end
 */
-(void)stitchVideo:(NSURL*)vidURL1 withVideo:(NSURL*)vidURL2;


/**
 Stitches the associated videos in the array of urls together.
 @param urls array of videos to be stitched together, given by their urls.
 */
-(void)performStitch:(NSArray*)urls;

@end
