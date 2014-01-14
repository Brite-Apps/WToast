//
//  WAppDelegate.m
//  WToast
//
//  Created by Nik S Dyonin on 14.01.14.
//  Copyright (c) 2014 Brite Apps. All rights reserved.
//

#import "WAppDelegate.h"
#import "WTestViewController.h"

@implementation WAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	self.window.backgroundColor = [UIColor whiteColor];
	
	UITabBarController *tabBarController = [[UITabBarController alloc] init];
	
	WTestViewController *v = [[WTestViewController alloc] initWithNibName:@"WTestViewController" bundle:[NSBundle mainBundle]];
	v.tabBarItem.title = @"Test tab";
	tabBarController.viewControllers = @[v];
	_window.rootViewController = tabBarController;
	[_window makeKeyAndVisible];

	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
