//
//  UIView+UIView_FadeAniMation.m
//  Traffic-O-Rama
//
//  Created by Sayantan Chakraborty on 26/01/16.
//  Copyright © 2016 Sayantan Chakraborty. All rights reserved.
//

#import "UIView+UIView_FadeAniMation.h"

@implementation UIView (UIView_FadeAniMation)
-(void)lock{
    if([self viewWithTag:10]){
        
    }else{
        UIView *lockView = [[UIView alloc]initWithFrame:self.bounds];
        lockView.backgroundColor = [[UIColor alloc]initWithWhite:0.0 alpha:0.75];
        lockView.tag = 10;
        lockView.alpha = 0.0;
        UIActivityIndicatorView *indicator =  [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleWhite];
        indicator.hidesWhenStopped = true;
        indicator.center = lockView.center;
        [lockView addSubview:indicator];
        [indicator startAnimating];
        [self addSubview:lockView];
        
        [UIView animateWithDuration:0.2 animations:^{
            lockView.alpha = 1.0;
        }];
    }
    
}

-(void)unlock
{
    UIView *lockView = [self viewWithTag:10];
    if (lockView) {
        [UIView animateWithDuration:0.2 animations:^{
            lockView.alpha = 0.0;
            [lockView removeFromSuperview];
        }];
    }
}
-(void)fadeOut:(NSTimeInterval)duration{
    [UIView animateWithDuration:duration animations:^{
        self.alpha = 0.0;
    }];
}
-(void)fadeIn:(NSTimeInterval)duration{
    [UIView animateWithDuration:duration animations:^{
        self.alpha = 1.0;
    }];
}
@end
