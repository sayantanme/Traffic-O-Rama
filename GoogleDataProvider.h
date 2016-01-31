//
//  GoogleDataProvider.h
//  Traffic-O-Rama
//
//  Created by Sayantan Chakraborty on 27/01/16.
//  Copyright © 2016 Sayantan Chakraborty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GooglePlace.h"

@interface GoogleDataProvider : NSObject
//returns array of Google places
-(void)fetchPlacesNearCoordinate:(CLLocationCoordinate2D)coordinate withRadius:(double)radius Type:(NSArray *)types andCompletetion:(void(^)(NSMutableArray *))completion;
@end
