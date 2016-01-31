//
//  GooglePlace.m
//  Traffic-O-Rama
//
//  Created by Sayantan Chakraborty on 26/01/16.
//  Copyright © 2016 Sayantan Chakraborty. All rights reserved.
//

#import "GooglePlace.h"

@implementation GooglePlace

-(instancetype)initWithDictionary:(NSDictionary *)dictionary acceptedTypes:(NSArray *)acceptedType{
    NSLog(@"in Google Place");
    self = [super init];
    if (self) {
        self.name = [dictionary objectForKey:@"name"];
        self.address = [dictionary objectForKey:@"vicinity"];
        CLLocationDegrees lat = [[[[dictionary objectForKey:@"geometry"] objectForKey:@"location"]objectForKey:@"lat"] doubleValue];
        CLLocationDegrees lon = [[[[dictionary objectForKey:@"geometry"] objectForKey:@"location"]objectForKey:@"lng"] doubleValue];
        self.coordinate = CLLocationCoordinate2DMake(lat, lon);
        
        self.photoRefernce = [[[dictionary objectForKey:@"photos"] objectAtIndex:0]objectForKey:@"photo_reference"];
        
        NSArray *possibleTypes = [[NSArray alloc]init];
        NSMutableArray *actualType = [[NSMutableArray alloc]initWithCapacity:8];
        if (acceptedType.count > 0) {
            possibleTypes = acceptedType;
        } else {
            possibleTypes = @[@"bakery", @"bar", @"cafe", @"grocery_or_supermarket", @"restaurant"];
        }
        for (NSArray *type in [dictionary objectForKey:@"types"]){
            if ([possibleTypes containsObject:type]) {
                [actualType addObject:type];
            }
        }
        self.placeType = (NSString *)[actualType objectAtIndex:0];
    }
    
    return self;
}
@end
