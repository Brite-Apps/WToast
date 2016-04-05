//
//  WTestViewController.m
//  WToast
//
//  Created by Nik Dyonin on 14.01.14.
//  Copyright (c) 2014 Nik Dyonin. All rights reserved.
//

#import "WTestViewController.h"
#import "WToast.h"

@implementation WTestViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	_textField.delegate = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return NO;
}

- (IBAction)showShortMessage {
	[_textField resignFirstResponder];

	NSString *text = _textField.text;

	if (text.length == 0) {
		text = @"No text!";
	}

	WToastGravity gravity = (WToastGravity)self.gravitySegmentedControl.selectedSegmentIndex;
	
	[WToast showWithText:text gravity:gravity];
}

- (IBAction)showLongMessage {
	[_textField resignFirstResponder];

	NSString *text = _textField.text;

	if (text.length == 0) {
		text = @"No text!";
	}
	
	WToastGravity gravity = (WToastGravity)self.gravitySegmentedControl.selectedSegmentIndex;

	[WToast showWithText:text duration:kWTLong gravity:gravity];
}

- (IBAction)showShortImage {
	WToastGravity gravity = (WToastGravity)self.gravitySegmentedControl.selectedSegmentIndex;
	
	[WToast showWithImage:[UIImage imageNamed:@"test.png"] gravity:gravity];
}

- (IBAction)showLongImage {
	WToastGravity gravity = (WToastGravity)self.gravitySegmentedControl.selectedSegmentIndex;
	
	[WToast showWithImage:[UIImage imageNamed:@"test.png"] duration:kWTLong gravity:gravity];
	
	//[WToast showWithImage:[UIImage imageNamed:@"toast-image"] gravity:gravity];
	//[WToast showWithImage:[UIImage imageNamed:@"toast-image"] duration:10 gravity:gravity];
	//[WToast showWithImage:[UIImage imageNamed:@"toast-image"] duration:12 roundedCorners:NO gravity:gravity];
}

@end
