//
//  Downloader.m
//  ChaseApplication
//
//  Created by Nikhil Singh on 12/3/16.
//  Copyright © 2016 NikhilSingh. All rights reserved.
//

#import "Downloader.h"
#import "Location.h"

@implementation Downloader

- (instancetype)initWithCustomInput:(NSString *) userInput
                       withDelegate:(id<DownloaderDelegate>) delegate
{
    self = [super init];
    if (self) {
        self.delegate = delegate;
        self.geoCoder = [[CLGeocoder alloc] init];
        [self.geoCoder geocodeAddressString:userInput completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            if(!error){
                CLPlacemark *placemark = [placemarks firstObject];
                [self downloadDataForLocation:placemark.location];
            } else {

            }
        }];
    }
    return self;
}


- (instancetype)initWithLocation:(CLLocation *) location
                    withDelegate:(id<DownloaderDelegate>) delegate {
    self = [super init];
    if (self) {
        self.delegate = delegate;
        [self downloadDataForLocation:location];
    }
    return self;
}


-(void) downloadDataForLocation:(CLLocation *) location {
    
    NSString *urlString = [NSString stringWithFormat:@"https://m.chase.com/PSRWeb/location/list.action?lat=%f&lng=%f",location.coordinate.latitude, location.coordinate.longitude];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(!error){
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
            if(httpResponse.statusCode == 200){
                
                NSError *errorResp;
                NSDictionary *dictionaryData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&errorResp];
                
                if(!errorResp){
                    NSArray *locations = [dictionaryData objectForKey:@"locations"];
                    NSMutableArray *arrayOfLocations = [[NSMutableArray alloc] init];
                    for (NSDictionary *locationDictionary in locations) {
                        Location *locationObject = [[Location alloc] initWithDictionary:locationDictionary];
                        [arrayOfLocations addObject:locationObject];
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.delegate fetchedLocations:arrayOfLocations];
                    });
                    
                }
                
            }
            
        }
    }] resume];
}

@end
