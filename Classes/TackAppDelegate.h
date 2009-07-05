//
//  TackAppDelegate.h
//  Tack
//
//  Created by Stig Brautaset on 05/07/2009.
//  Copyright Morgan Stanley 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TackViewController;

@interface TackAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    TackViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet TackViewController *viewController;

@end

