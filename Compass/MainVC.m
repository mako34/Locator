//
//  MainVC.m
//  Compass
//
//  Created by  on 4/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainVC.h"


// This is defined in Math.h
#define M_PI   3.14159265358979323846264338327950288   /* pi */

// Our conversion definition
#define DEGREES_TO_RADIANS(angle) (angle / 180.0 * M_PI)

@implementation MainVC

@synthesize CLController=_CLController; 
@synthesize locationManager = _locationManager;
@synthesize magHeading = _magHeading;


 

 

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //[self.view addSubview:[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"proctor.png"]] autorelease]];
    
    
   CGRect myImageRect = CGRectMake(00.0f, 30.0f, 320.0f, 316.0f); 
    UIImageView *myImage = [[UIImageView alloc] initWithFrame:myImageRect]; 
    [myImage setImage:[UIImage imageNamed:@"proctor.png"]]; 
    myImage.opaque = YES; // explicitly opaque for performance 
    [self.view addSubview:myImage]; 
    [myImage release];

    
    imageToMove = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow.png"]];
    imageToMove.frame = CGRectMake(150 , 140, 20, 100);
    [self.view addSubview:imageToMove];
    
    
 
    

    //labels
         
    UILabel *lava = [[[UILabel alloc] initWithFrame:CGRectMake(70, 10, 200, 20)] autorelease];
    lava.text = @"Magnetic sensor test";
     [self.view addSubview:lava];
    
    self.magHeading = [[[UILabel alloc] initWithFrame:CGRectMake(10, 350, 200, 20)] autorelease];
    [self.view addSubview:self.magHeading];
    
    lat = [[UILabel alloc]initWithFrame:CGRectMake(25, 370, 220, 20)];
    lat.text = @"latitude  =";
    [self.view addSubview:lat];
    
    lon = [[UILabel alloc]initWithFrame:CGRectMake(25, 390, 220, 20)];
    lon.text = @"longitude ="; 
    [self.view addSubview:lon];
    
    
    // setup the location manager
	self.locationManager = [[[CLLocationManager alloc] init] autorelease];
	
	// check if the hardware has a compass
	if ([CLLocationManager headingAvailable] == NO) {
		// No compass is available. This application cannot function without a compass, 
        // so a dialog will be displayed and no magnetic data will be measured.
        self.locationManager = nil;
        UIAlertView *noCompassAlert = [[UIAlertView alloc] initWithTitle:@"No Compass!" message:@"This device does not have the ability to measure magnetic fields." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [noCompassAlert show];
        [noCompassAlert release];
	} else {
        // heading service configuration
        self.locationManager.headingFilter = kCLHeadingFilterNone;
        
        // setup delegate callbacks
        self.locationManager.delegate = self;
        
        // start the compass
        [self.locationManager startUpdatingHeading];
    }
    
    
    // 
    self.CLController = [[CoreLocationController alloc] init];
	self.CLController.delegate = self;
	[self.CLController.locMgr startUpdatingLocation];
    [self.CLController.locMgr startUpdatingHeading];

}


 
- (void)locationUpdate:(CLLocation *)location {
     lat.text = [NSString stringWithFormat:@"latitude  = %f", location.coordinate.latitude];
    lon.text = [NSString stringWithFormat:@"longitude = %f", location.coordinate.longitude];
    //compass.text = [NSString stringWithFormat:@"deg from north = %f", location.coordinate. 
}

- (void)locationError:(NSError *)error {
	lat.text = [error description];
}


// This delegate method is invoked when the location manager has heading data.
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)heading {
 	     //Magnetic heading n true heading
    [self.magHeading setText:[NSString stringWithFormat:@"magnetic Heading: %.1f", heading.magneticHeading]];
   // [self.trueHeading setText:[NSString stringWithFormat:@"true Heading: %.1f", heading.trueHeading]];

    [self rotateImage:imageToMove duration:0.2 curve:UIViewAnimationCurveEaseIn degrees:-(heading.magneticHeading)];

    //calculate difference in deg,
    
    
}

// This delegate method is invoked when the location managed encounters an error condition.
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if ([error code] == kCLErrorDenied) {
        // This error indicates that the user has denied the application's request to use location services.
        [manager stopUpdatingHeading];
    } else if ([error code] == kCLErrorHeadingFailure) {
        // This error indicates that the heading could not be determined, most likely because of strong magnetic interference.
    }
}


- (void)rotateImage:(UIImageView *)image duration:(NSTimeInterval)duration curve:(int)curve degrees:(CGFloat)degrees
{
    // Setup the animation
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:curve];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    // The transform matrix
    CGAffineTransform transform = 
    CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(degrees));
    image.transform = transform;
    
    // Commit the changes
    [UIView commitAnimations];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(void) viewDidUnload {
    [super viewDidUnload];

    /*
    self.magnitudeLabel = nil;
    self.xLabel = nil;
    self.yLabel = nil;
    self.zLabel = nil;
*/
        
    self.magHeading = nil;
}

-(void) dealloc {
    
    [_magHeading release];
/*
    [_magnitudeLabel release];
    [_xLabel release];
    [_yLabel release];
    [_zLabel release];
    [_locationManager release];
    [_trueHeading release];
  */  
    // Stop the compass
	[self.locationManager stopUpdatingHeading];
    [self.locationManager release];
    
    [super dealloc];
}

@end
