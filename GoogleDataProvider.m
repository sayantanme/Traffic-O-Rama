//
//  GoogleDataProvider.m
//  Traffic-O-Rama
//
//  Created by Sayantan Chakraborty on 27/01/16.
//  Copyright © 2016 Sayantan Chakraborty. All rights reserved.
//

#import "GoogleDataProvider.h"
#import "GooglePlace.h"

@interface GoogleDataProvider()
@property (strong,nonatomic) NSMutableDictionary *photoCache;
@property (weak, nonatomic) NSURLSession *session;
@end


@implementation GoogleDataProvider
-(void)fetchPlacesNearCoordinate:(CLLocationCoordinate2D)coordinate withRadius:(double)radius Type:(NSArray *)types andCompletetion:(void (^)(NSMutableArray *))completion
{
    NSMutableArray *googlePlaces = [[NSMutableArray alloc]init];
    NSString *urlString = [[NSString alloc]initWithFormat:@"http://localhost:10000/maps/api/place/nearbysearch/json?location=%f,%f&radius=%f&rankby=prominence&sensor=true",coordinate.latitude,coordinate.longitude,radius];    NSString *typesString;
    if (types.count > 0) {
        typesString = [types componentsJoinedByString:@"|"];
    }else{
        typesString = @"food";
    }
    NSString *interim = [[NSString alloc]initWithFormat:@"&types=%@",typesString];
    urlString = [urlString stringByAppendingString:interim];
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    NSURL *url = [[NSURL alloc]initWithString:urlString];
    
    self.session = [NSURLSession sharedSession];
    [[self.session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
        NSError *jerror = nil;
        NSDictionary *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (jerror != nil) {
            NSLog(@"Error parsing %@",jerror);
        } else {
            NSDictionary *results = [jsonArray objectForKey:@"results"];
            for (NSDictionary *result in results){
                GooglePlace *g = [[GooglePlace alloc] initWithDictionary:result acceptedTypes:types];
                if(g.photoRefernce){
                    g.image = [self fetchPhotoFromRefernce:g.photoRefernce];
                }
                
                [googlePlaces addObject:g];
                NSLog(@"data:%@, is in Main Thread?:%@",g,[[NSThread currentThread] isMainThread]?@"YES":@"NO");
            }
            //NSLog(@"Array: %@",results);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(googlePlaces);
        });
    }] resume];
}

-(UIImage *)fetchPhotoFromRefernce:(NSString *)refernce
{
    UIImage *img;
    if (!self.photoCache) {
        self.photoCache = [[NSMutableDictionary alloc]initWithCapacity:10];
    }
    if(!self.photoCache[refernce]){
        NSString *urlString = [[NSString alloc]initWithFormat:@"http://localhost:10000/maps/api/place/photo?maxwidth=200&photoreference=%@",refernce];
        NSURL *url = [[NSURL alloc]initWithString:urlString];
        //NSError *error = nil;
        NSData *data = [[NSData alloc]initWithContentsOfURL:url];
        img =[[UIImage alloc]initWithData:data];
        [self.photoCache setObject:img forKey:refernce];
    }
    return img;
}
@end
