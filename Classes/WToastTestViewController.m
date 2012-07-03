/**
 * @class WToastTestViewController
 * @author Nik S Dyonin <wolf.step@gmail.com>
 */

#import "WToastTestViewController.h"
#import "WToast.h"

@implementation WToastTestViewController

@synthesize textField = _textField;

- (void)viewDidLoad {
	[super viewDidLoad];
	self.textField.delegate = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return NO;
}

- (IBAction)showShortMessage {
	[self.textField resignFirstResponder];
	NSString *text = self.textField.text;
	if (!text || ![text length]) {
		text = @"No text!";
	}
	[WToast showWithText:text];
}

- (IBAction)showLongMessage {
	[self.textField resignFirstResponder];
	NSString *text = self.textField.text;
	if (!text || ![text length]) {
		text = @"No text!";
	}
	[WToast showWithText:text length:kWTLong];
}

- (IBAction)showShortImage {
	[WToast showWithImage:[UIImage imageNamed:@"test.png"]];
}

- (IBAction)showLongImage {
	[WToast showWithImage:[UIImage imageNamed:@"test.png"] length:kWTLong];
}

- (void)dealloc {
	self.textField = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	return YES;
}

@end
