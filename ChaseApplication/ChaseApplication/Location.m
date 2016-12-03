//
//  Location.m
//  ChaseApplication
//
//  Created by Nikhil Singh on 12/3/16.
//  Copyright © 2016 NikhilSingh. All rights reserved.
//

#import "Location.h"

@implementation Location


- (instancetype)initWithDictionary:(NSDictionary *) locationDetails
{
    self = [super init];
    if (self) {
        if([[locationDetails objectForKey:@"locType"] isEqualToString:@"atm"]){
            self.isThisAtm = YES;
        } else {
            self.isThisAtm = NO;
        }
        
        if([[locationDetails objectForKey:@"type"] isKindOfClass:[NSNull class]]){
            self.type = @"NA";
        } else {
            self.type = [locationDetails objectForKey:@"type"];
        }
        
        self.name = [locationDetails objectForKey:@"name"];
        self.address = [locationDetails objectForKey:@"address"];
        self.city = [locationDetails objectForKey:@"city"];
        self.state = [locationDetails objectForKey:@"state"];
        self.zip = [locationDetails objectForKey:@"zip"];
        
        if([[locationDetails objectForKey:@"phone"] isKindOfClass:[NSNull class]]){
            self.phone = @"NA";
        } else {
            self.phone = [locationDetails objectForKey:@"phone"];
        }
        
        self.lat = [[locationDetails objectForKey:@"lat"] doubleValue];
        self.lng = [[locationDetails objectForKey:@"lng"] doubleValue];
        self.distance = [[locationDetails objectForKey:@"distance"] doubleValue];
        
        if([[locationDetails objectForKey:@"lobbyHrs"] isKindOfClass:[NSNull class]]){
            self.lobbyHours = @[];
        } else {
            self.lobbyHours = [locationDetails objectForKey:@"lobbyHrs"];
        }
        
        if([[locationDetails objectForKey:@"lobbyHrs"] isKindOfClass:[NSNull class]]){
            self.lobbyHours = @[];
        } else {
            self.lobbyHours = [locationDetails objectForKey:@"lobbyHrs"];
        }
        
        if([[locationDetails objectForKey:@"driveUpHrs"] isKindOfClass:[NSNull class]]){
            self.driveUpHrs = @[];
        } else {
            self.driveUpHrs = [locationDetails objectForKey:@"driveUpHrs"];
        }
        
        if([[locationDetails objectForKey:@"services"] isKindOfClass:[NSNull class]]){
            self.services = @[];
        } else {
            self.services = [locationDetails objectForKey:@"driveUpHrs"];
        }
        
        if([[locationDetails objectForKey:@"atms"] isKindOfClass:[NSNull class]]){
            self.numberOfATMs = 0;
        } else {
            self.numberOfATMs = [[locationDetails objectForKey:@"atms"] intValue];
        }

        
    }
    return self;
}

@end
