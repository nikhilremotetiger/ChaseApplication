//
//  Location.h
//  ChaseApplication
//
//  Created by Nikhil Singh on 12/3/16.
//  Copyright © 2016 NikhilSingh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject

@property (nonatomic, assign) BOOL isThisAtm;
@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *zip;
@property (nonatomic, copy) NSString *phone;

@property (nonatomic, assign) double lat;
@property (nonatomic, assign) double lng;
@property (nonatomic, assign) double distance;

@property (nonatomic, copy) NSArray *lobbyHours;
@property (nonatomic, copy) NSArray *driveUpHrs;
@property (nonatomic, copy) NSArray *services;

@property (nonatomic, assign) int numberOfATMs;

- (instancetype)initWithDictionary:(NSDictionary *) locationDetails;

@end
