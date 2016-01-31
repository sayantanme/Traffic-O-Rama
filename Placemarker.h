//
//  Placemarker.h
//  Traffic-O-Rama
//
//  Created by Sayantan Chakraborty on 26/01/16.
//  Copyright © 2016 Sayantan Chakraborty. All rights reserved.
//

#import <GoogleMaps/GoogleMaps.h>
#import "GooglePlace.h"

@interface Placemarker : GMSMarker
@property (nonatomic,strong) GooglePlace *gPlace;

-(instancetype)init:(GooglePlace *)googlePlace;
@end
