//
//  AppDelegate.m
//  PhotoBombers
//
//  Created by Joe Gesualdo on 9/15/14
//  Copyright (c) 2014 joegesualdo. All rights reserved.
//

#import "AppDelegate.h"
#import "PhotosViewController.h"
#import <SimpleAuth/SimpleAuth.h>

@implementation AppDelegate

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // FYI: If you are using story boardsn you only need the last line (return YES)
    
    // Setup Simple auth to work with instagram
    // The redirect uri is the one we set with the providers
    // redirect uri can be whateve you want as long as it looks like a url
    SimpleAuth.configuration[@"instagram"] = @{
        @"client_id" : @"f4bf8eb111f3402ead2c1b4c523687b6",
        SimpleAuthRedirectURIKey : @"photobombers://auth/instagram"
    };
    
    //======
    // The following lines create your application’s main window programmatically, since we aren't using story boards
    //======
    // size of the window to the full bounds of the screen.
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    // Create a variable to hold photos view conroller
    PhotosViewController *photosViewController = [[PhotosViewController alloc]init];
    // allocate and initialize a navigation controller, WITH the photosViewController nested in it
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:photosViewController];
    // get's the navigationBar form the navigation controller and stores it in a variable
    UINavigationBar *navigationBar = navigationController.navigationBar;
    // TODO: refactor the styling of the color in the navigation bar to use UIAppearance, which is the modern way to do it
    // set barTintColor property on the navigation bar to change the color of the navigation bar
    navigationBar.barTintColor = [UIColor colorWithRed:242.0f/255.0f green:122.0f/255.0f blue:87.0f/255.0f alpha:1.0];
    // THis makes the the text on the navigation bar and status bar white
    navigationBar.barStyle = UIBarStyleBlackOpaque;
    //rootViewController is the controller that is the root of the window
    // set the root view controller as our navigation controller with photos controller embedded within it
    self.window.rootViewController = navigationController;
    // Set the background color of the window to white
    self.window.backgroundColor = [UIColor whiteColor];
    // This is a convenience method to make the receiver the main window and displays it in front of other windows at the same window level or lower. You can also hide and reveal a window using the inherited hidden property of UIView.
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
