/**
 * @class WToastAppDelegate
 * @author Nik S Dyonin <wolf.step@gmail.com>
 */

#import "WToastAppDelegate.h"
#import "WToastViewController.h"

@implementation WToastAppDelegate

@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	v = [[WToastViewController alloc] init];
	[self.window addSubview:v.view];
	[self.window makeKeyAndVisible];
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
	[v release];
	[super dealloc];
}

@end
