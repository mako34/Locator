//
//  CompassAppDelegate.h
//  Compass
//
//  Created by  on 4/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainVC;

@interface CompassAppDelegate : NSObject <UIApplicationDelegate> {
    
    MainVC *_viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) MainVC *viewController;

@end
