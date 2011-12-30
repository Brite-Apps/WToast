/**
 * @class WToastAppDelegate
 * @author Nik S Dyonin <wolf.step@gmail.com>
 */

#import "WToastAppDelegate.h"
#import "WToastViewController.h"

@implementation WToastAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
	window.backgroundColor = [UIColor whiteColor];
	
	tabBarController = [[UITabBarController alloc] init];

	WToastViewController *v = [[WToastViewController alloc] init];
	v.tabBarItem.title = @"Test tab";
	tabBarController.viewControllers = [NSArray arrayWithObject:v];
	[v release];
	
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

- (void)dealloc {
	[window release];
	[tabBarController release];
	[super dealloc];
}

@end
