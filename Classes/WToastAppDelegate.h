/**
 * @class WToastAppDelegate
 */

@interface WToastAppDelegate : NSObject <UIApplicationDelegate, UITextFieldDelegate> {
	UIWindow *window;
	UITextField *textField;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end
