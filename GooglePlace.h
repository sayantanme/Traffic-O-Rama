//
//  GooglePlace.h
//  Traffic-O-Rama
//
//  Created by Sayantan Chakraborty on 26/01/16.
//  Copyright © 2016 Sayantan Chakraborty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@interface GooglePlace : NSObject
@property (nonatomic,retain) NSString *name;
@property (nonatomic,retain) NSString *address;
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic,retain) NSString *placeType;
@property (nonatomic,retain) NSString *photoRefernce;
@property (nonatomic,retain) UIImage *image;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary acceptedTypes:(NSArray *)acceptedType;
@end
