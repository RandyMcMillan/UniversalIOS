  //
  //  UniversalExampleAppDelegate.m
  //  UniversalExample
  //
  //  Created by Cory Wiles on 7/29/10.
  //  Copyright __MyCompanyName__ 2010. All rights reserved.
  //

#import "UniversalExampleAppDelegate_Pad.h"
#import "RootViewController_Pad.h"
#import "DetailViewController_Pad.h"

@implementation UniversalExampleAppDelegate_Pad

@synthesize window;
@synthesize splitViewController;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
  RootViewController_Pad *rootVC     = [[RootViewController_Pad alloc] initWithStyle:UITableViewStylePlain];

  UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:rootVC];
  
  DetailViewController_Pad *detailVC = [[DetailViewController_Pad alloc] init];
  
  self.splitViewController = [[UISplitViewController alloc] init];
  
  self.splitViewController.delegate        = detailVC;
  self.splitViewController.viewControllers = [NSArray arrayWithObjects:navController, detailVC, nil];
  
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  
  self.window.rootViewController = self.splitViewController;
  
  [self.window makeKeyAndVisible];
  
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
  
}


@end

