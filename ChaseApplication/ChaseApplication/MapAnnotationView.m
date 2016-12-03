//
//  MapAnnotationView.m
//  ChaseApplication
//
//  Created by Nikhil Singh on 12/3/16.
//  Copyright © 2016 NikhilSingh. All rights reserved.
//

#import "MapAnnotationView.h"

@implementation MapAnnotationView

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        MapAnnotation *ann = (MapAnnotation *) annotation;
        self.enabled = YES;
        self.canShowCallout = YES;
        if(ann.isThisAtm){
            self.image = [UIImage imageNamed:@"atm.png"];
        } else {
            self.image = [UIImage imageNamed:@"branch.png"];
        }
    }
    return self;
}

@end
