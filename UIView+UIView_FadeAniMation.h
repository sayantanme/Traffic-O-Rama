//
//  UIView+UIView_FadeAniMation.h
//  Traffic-O-Rama
//
//  Created by Sayantan Chakraborty on 26/01/16.
//  Copyright © 2016 Sayantan Chakraborty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (UIView_FadeAniMation)
-(void)lock;
-(void)unlock;
-(void)fadeOut:(NSTimeInterval)duration;
-(void)fadeIn:(NSTimeInterval)duration;
@end
