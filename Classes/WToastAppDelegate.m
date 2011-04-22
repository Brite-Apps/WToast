/**
 * @class WToastAppDelegate
 * @author Nik S Dyonin <wolf.step@gmail.com>
 */

#import "WToastAppDelegate.h"
#import "WToast.h"

@implementation WToastAppDelegate

@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	textField = [[UITextField alloc] init];
	textField.delegate = self;
	textField.borderStyle = UITextBorderStyleRoundedRect;
	textField.placeholder = @"Type message here";
	textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	textField.clearButtonMode = UITextFieldViewModeAlways;
	textField.frame = CGRectMake(10.0f, 100.0f, 300.0f, 40.0f);
	[self.window addSubview:textField];
	[textField release];

	UIButton *showMessageButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[showMessageButton setTitle:@"Show message" forState:UIControlStateNormal];
	[showMessageButton sizeToFit];
	CGRect tmpRect = showMessageButton.frame;
	tmpRect.origin.x = floor((self.window.frame.size.width - tmpRect.size.width) / 2.0f);
	tmpRect.origin.y = textField.frame.origin.y + textField.frame.size.height + 20.0f;
	showMessageButton.frame = tmpRect;
	[self.window addSubview:showMessageButton];
	[showMessageButton addTarget:self action:@selector(showMessage:) forControlEvents:UIControlEventTouchUpInside];
	
	UIButton *showImageButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[showImageButton setTitle:@"Show image" forState:UIControlStateNormal];
	[showImageButton sizeToFit];
	tmpRect = showImageButton.frame;
	tmpRect.origin.x = floor((self.window.frame.size.width - tmpRect.size.width) / 2.0f);
	tmpRect.origin.y = showMessageButton.frame.origin.y + showMessageButton.frame.size.height + 30.0f;
	showImageButton.frame = tmpRect;
	[self.window addSubview:showImageButton];
	[showImageButton addTarget:self action:@selector(showImage:) forControlEvents:UIControlEventTouchUpInside];
	
	[self.window makeKeyAndVisible];
	return YES;
}

- (void)showMessage:(UIButton *)sender {
	[textField resignFirstResponder];
	NSString *text = textField.text;
	if (!text || ![text length]) {
		text = @"No text!";
	}
	[WToast showWithText:text];
}

- (void)showImage:(UIButton *)sender {
	[WToast showWithImage:[UIImage imageNamed:@"test.png"]];
}

- (BOOL)textFieldShouldReturn:(UITextField *)aTextField {
	[aTextField resignFirstResponder];
	return NO;
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
	[super dealloc];
}

@end
