//
//  AppDelegate.m
//  PhotoBombers
//
//  Created by Joe Gesualdo on 9/15/14
//  Copyright (c) 2014 joegesualdo. All rights reserved.
//

#import "AppDelegate.h"
#import "PhotosViewController.h"

@implementation AppDelegate

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // FYI: If you are using story boardsn you only need the last line (return YES)
    
    //======
    // The following lines create your application’s main window programmatically, since we aren't using story boards
    //======
    // size of the window to the full bounds of the screen.
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    //rootViewController is the controller that is the root of the window
    self.window.rootViewController = [[PhotosViewController alloc]init];
    // Set the background color of the window to white
    self.window.backgroundColor = [UIColor whiteColor];
    // This is a convenience method to make the receiver the main window and displays it in front of other windows at the same window level or lower. You can also hide and reveal a window using the inherited hidden property of UIView.
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
