//
//  TackAppDelegate.m
//  Tack
//
//  Created by Stig Brautaset on 05/07/2009.
//  Copyright Morgan Stanley 2009. All rights reserved.
//

#import "TackAppDelegate.h"
#import "TackViewController.h"

@implementation TackAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
