//
//  MainVC.h
//  Compass
//
//  Created by  on 4/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "CoreLocationController.h"



@interface MainVC : UIViewController <CLLocationManagerDelegate, CoreLocationControllerDelegate> {
    
     
    UILabel *_magHeading;
    
    CLLocationManager *_locationManager;
    
    UIImageView *imageToMove;
    
    CoreLocationController *_CLController;
    
    UILabel *lat;
    UILabel *lon;


}

 
@property (nonatomic, retain)  UILabel *magHeading;


 
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) CoreLocationController *CLController;


- (void)rotateImage:(UIImageView *)image duration:(NSTimeInterval)duration curve:(int)curve degrees:(CGFloat)degrees;


@end
