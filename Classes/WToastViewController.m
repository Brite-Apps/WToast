/**
 * @class WToastViewController
 * @author Nik S Dyonin <wolf.step@gmail.com>
 */

#import "WToastViewController.h"
#import "WToast.h"

@implementation WToastViewController

- (void)redrawInterface {
	CGRect screenFrame = [UIScreen mainScreen].bounds;
	float width, height;
	if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
		width = MAX(screenFrame.size.width, screenFrame.size.height);
		height = MIN(screenFrame.size.width, screenFrame.size.height);
	}
	else {
		width = MIN(screenFrame.size.width, screenFrame.size.height);
		height = MAX(screenFrame.size.width, screenFrame.size.height);
	}

	CGRect tmpRect = CGRectMake(0.0f, 30.0f, 300.0f, 40.0f);
	tmpRect.origin.x = floor((width - tmpRect.size.width) / 2.0f);
	textField.frame = tmpRect;
	
	tmpRect = showMessageButton.frame;
	tmpRect.origin.x = floor((width - tmpRect.size.width) / 2.0f);
	tmpRect.origin.y = textField.frame.origin.y + textField.frame.size.height + 20.0f;
	showMessageButton.frame = tmpRect;
	
	tmpRect = showImageButton.frame;
	tmpRect.origin.x = floor((width - tmpRect.size.width) / 2.0f);
	tmpRect.origin.y = showMessageButton.frame.origin.y + showMessageButton.frame.size.height + 30.0f;
	showImageButton.frame = tmpRect;
}

- (void)loadView {
	[super loadView];
	
	textField = [[UITextField alloc] init];
	textField.delegate = self;
	textField.borderStyle = UITextBorderStyleRoundedRect;
	textField.placeholder = @"Type message here";
	textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	textField.clearButtonMode = UITextFieldViewModeAlways;
	CGRect tmpRect = CGRectMake(0.0f, 30.0f, 300.0f, 40.0f);
	tmpRect.origin.x = floor((self.view.frame.size.width - tmpRect.size.width) / 2.0f);
	textField.frame = tmpRect;
	[self.view addSubview:textField];
	[textField release];
	
	showMessageButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[showMessageButton setTitle:@"Show message" forState:UIControlStateNormal];
	[showMessageButton sizeToFit];
	tmpRect = showMessageButton.frame;
	tmpRect.origin.x = floor((self.view.frame.size.width - tmpRect.size.width) / 2.0f);
	tmpRect.origin.y = textField.frame.origin.y + textField.frame.size.height + 20.0f;
	showMessageButton.frame = tmpRect;
	[self.view addSubview:showMessageButton];
	[showMessageButton addTarget:self action:@selector(showMessage:) forControlEvents:UIControlEventTouchUpInside];
	
	showImageButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[showImageButton setTitle:@"Show image" forState:UIControlStateNormal];
	[showImageButton sizeToFit];
	tmpRect = showImageButton.frame;
	tmpRect.origin.x = floor((self.view.frame.size.width - tmpRect.size.width) / 2.0f);
	tmpRect.origin.y = showMessageButton.frame.origin.y + showMessageButton.frame.size.height + 30.0f;
	showImageButton.frame = tmpRect;
	[self.view addSubview:showImageButton];
	[showImageButton addTarget:self action:@selector(showImage:) forControlEvents:UIControlEventTouchUpInside];
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

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	[self redrawInterface];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	return YES;
}

@end
