//
//  Placemarker.m
//  Traffic-O-Rama
//
//  Created by Sayantan Chakraborty on 26/01/16.
//  Copyright © 2016 Sayantan Chakraborty. All rights reserved.
//

#import "Placemarker.h"
#import <UIKit/UIKit.h>

@implementation Placemarker

-(instancetype)init:(GooglePlace *)googlePlace{
    self.gPlace = googlePlace;
    self = [super init];
    
    self.position = googlePlace.coordinate;
    //self.icon = [[UIImage alloc]initWithContentsOfFile:[googlePlace.placeType stringByAppendingString:@"_pin"]];
    self.icon = [UIImage imageNamed:[googlePlace.placeType stringByAppendingString:@"_pin"]];
    self.groundAnchor = CGPointMake(0.5, 1);
    self.appearAnimation = kGMSMarkerAnimationPop;
    
    return self;
}
@end
