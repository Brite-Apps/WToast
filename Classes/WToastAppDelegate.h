/**
 * @class WToastAppDelegate
 */

@class WToastViewController;

@interface WToastAppDelegate : NSObject <UIApplicationDelegate, UITextFieldDelegate> {
	UIWindow *window;
	WToastViewController *v;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end
