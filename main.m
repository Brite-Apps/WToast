#import "WToastAppDelegate.h"

int main(int argc, char *argv[]) {
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	int retVal = UIApplicationMain(argc, argv, nil, NSStringFromClass([WToastAppDelegate class]));
	[pool release];
	return retVal;
}
