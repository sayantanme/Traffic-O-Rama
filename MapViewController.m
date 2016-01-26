//
//  MapViewController.m
//  Traffic-O-Rama
//
//  Created by Sayantan Chakraborty on 10/01/16.
//  Copyright © 2016 Sayantan Chakraborty. All rights reserved.
//

#import "MapViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "UIView+UIView_FadeAniMation.h"


@interface MapViewController ()<GMSMapViewDelegate>
@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@property (strong,nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UILabel *locationText;
@property (weak, nonatomic) IBOutlet UIImageView *pinImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pinImageVerticalContraint;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate=self;
    self.mapView.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    self.locationText.text = @"For Test";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)reverseGeoCoordinate:(CLLocationCoordinate2D)coordinate {
    GMSGeocoder *geocoder = [[GMSGeocoder alloc]init];
    [self.locationText unlock];
    [geocoder reverseGeocodeCoordinate:coordinate completionHandler:^(GMSReverseGeocodeResponse *response, NSError *error) {
        if (!error) {
            GMSAddress *address = response.firstResult;
            if (address) {
                NSString *lines = [address.lines componentsJoinedByString:@""];
                self.locationText.text = lines;
//                CGFloat labelheight = [self.locationText intrinsicContentSize].height;
//                self.mapView.padding = UIEdgeInsetsMake([self.topLayoutGuide length], 0, labelheight, 0);
                
                [UIView animateWithDuration:0.25 animations:^{
                    //self.pinImageVerticalContraint.constant = (CGFloat)(((double)labelheight - (double)[self.topLayoutGuide length]) * 0.5);
                    [self.view layoutIfNeeded];
                }];
            }
        }
    }];
}

#pragma mark - GMSMapViewDelegate
-(void)mapView:(GMSMapView *)mapView idleAtCameraPosition:(GMSCameraPosition *)position{
    [self reverseGeoCoordinate:position.target];
}

-(void)mapView:(GMSMapView *)mapView willMove:(BOOL)gesture{
    [self.locationText lock];
}


#pragma mark - CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if(status == kCLAuthorizationStatusAuthorizedWhenInUse){
        [self.locationManager startUpdatingLocation];
        self.mapView.myLocationEnabled = true;
        self.mapView.settings.myLocationButton = true;
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *currLoc = [locations lastObject];
    if (currLoc) {
        self.mapView.camera = [[GMSCameraPosition alloc]initWithTarget:currLoc.coordinate zoom:5 bearing:0 viewingAngle:15];
        [self.locationManager stopUpdatingLocation];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
