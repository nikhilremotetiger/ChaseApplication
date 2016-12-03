//
//  Downloader.h
//  ChaseApplication
//
//  Created by Nikhil Singh on 12/3/16.
//  Copyright © 2016 NikhilSingh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol DownloaderDelegate <NSObject>

@optional
-(void) fetchedLocations:(NSArray *) locationObjects;

@end

@interface Downloader : NSObject

@property (nonatomic, weak) id<DownloaderDelegate> delegate;
@property (nonatomic, strong) CLGeocoder *geoCoder;

- (instancetype)initWithCustomInput:(NSString *) userInput
                       withDelegate:(id<DownloaderDelegate>) delegate;

- (instancetype)initWithLocation:(CLLocation *) location
                    withDelegate:(id<DownloaderDelegate>) delegate;

@end
