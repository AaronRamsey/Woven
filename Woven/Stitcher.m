//
//  Stitcher.m
//  Woven
//
//  Created by Alex Koren on 12/3/13.
//  Copyright (c) 2013 OOSE. All rights reserved.
//

#import "Stitcher.h"
#import <MediaPlayer/MediaPlayer.h>
#import "MovieContainerController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <AssetsLibrary/AssetsLibrary.h>

@implementation Stitcher

-(void)stitchVideo:(NSURL*)vidURL1 withVideo:(NSURL*)vidURL2 {
    NSArray *urls = @[vidURL1, vidURL2];
    [self performSelectorInBackground:@selector(performStitch:) withObject:urls];
}

- (void)performStitch:(NSArray*)urls {
    NSURL *vidURL1 = [urls objectAtIndex:0];
    NSURL *vidURL2 = [urls objectAtIndex:1];
    AVMutableComposition *composition = [[AVMutableComposition alloc] init];
    
    AVMutableCompositionTrack *compositionVideoTrack = [composition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
    
    AVMutableCompositionTrack *compositionAudioTrack = [composition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
    
    CMTime start = kCMTimeZero;
    
    AVURLAsset *asset1 = [AVURLAsset URLAssetWithURL:vidURL1 options:nil];
    
    AVAssetTrack *videoTrack1 = [[asset1 tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0];
    AVAssetTrack *audioTrack1 = [[asset1 tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0];
    
    [compositionVideoTrack setPreferredTransform:videoTrack1.preferredTransform];
    
    [compositionVideoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, [asset1 duration]) ofTrack:videoTrack1 atTime:start error:nil];
    [compositionAudioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, [asset1 duration]) ofTrack:audioTrack1 atTime:start error:nil];
    
    start = CMTimeAdd(start, [asset1 duration]);
    
    AVURLAsset *asset2 = [AVURLAsset URLAssetWithURL:vidURL2 options:nil];
    AVAssetTrack *videoTrack2 = [[asset2 tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0];
    AVAssetTrack *audioTrack2 = [[asset2 tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0];
    
    [compositionVideoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, [asset2 duration]) ofTrack: videoTrack2 atTime:start error:nil];
    [compositionAudioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, [asset2 duration]) ofTrack: audioTrack2 atTime:start error:nil];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *myPathDocs =  [documentsDirectory stringByAppendingPathComponent:
                             [NSString stringWithFormat:@"mergeVideo-%d.mov",arc4random() % 1000]];
    //NSString *finalURL = [NSURL fileURLWithPath:myPathDocs];
    
    NSURL *url = [[NSURL alloc] initFileURLWithPath:myPathDocs];
    
    AVAssetExportSession *exporter = [[AVAssetExportSession alloc] initWithAsset:composition presetName:AVAssetExportPreset640x480];
    
    exporter.outputURL = url;
    
    exporter.outputFileType = [[exporter supportedFileTypes] objectAtIndex:0];
    
    [exporter exportAsynchronouslyWithCompletionHandler:^(void)
     {
         [[NSNotificationCenter defaultCenter] postNotificationName:@"finishedStitching" object:self userInfo:[NSDictionary dictionaryWithObject:url forKey:@"url"]];
     }];

}

+ (id)stitcher {
    static Stitcher *stitcher= nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        stitcher = [[self alloc]init];
    });
    return stitcher;
}

- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void) dealloc {
    
}

@end
