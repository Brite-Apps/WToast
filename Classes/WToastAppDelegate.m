/**
 * @class WToastAppDelegate
 * @author Nik S Dyonin <wolf.step@gmail.com>
 */

#import "WToastAppDelegate.h"
#import "WToastTestViewController.h"

@implementation WToastAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
	window.backgroundColor = [UIColor whiteColor];
	
	tabBarController = [[UITabBarController alloc] init];

	WToastTestViewController *v = [[WToastTestViewController alloc] initWithNibName:@"WToastTestViewController" bundle:nil];
	v.tabBarItem.title = @"Test tab";
	tabBarController.viewControllers = [NSArray arrayWithObject:v];
	
	[window addSubview:tabBarController.view];
	[window makeKeyAndVisible];
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

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
}


@end
