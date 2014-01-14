//
//  WTestViewController.m
//  WToast
//
//  Created by Nik S Dyonin on 14.01.14.
//  Copyright (c) 2014 Nik S Dyonin. All rights reserved.
//

#import "WTestViewController.h"
#import "WToast.h"

@implementation WTestViewController

- (void)viewDidLoad {
	_textField.delegate = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return NO;
}

- (IBAction)showShortMessage {
	[_textField resignFirstResponder];

	NSString *text = _textField.text;

	if (!text || ![text length]) {
		text = @"No text!";
	}

	[WToast showWithText:text];
}

- (IBAction)showLongMessage {
	[_textField resignFirstResponder];

	NSString *text = _textField.text;

	if (!text || ![text length]) {
		text = @"No text!";
	}

	[WToast showWithText:text duration:kWTLong];
}

- (IBAction)showShortImage {
	[WToast showWithImage:[UIImage imageNamed:@"test.png"]];
}

- (IBAction)showLongImage {
	[WToast showWithImage:[UIImage imageNamed:@"test.png"] duration:kWTLong];
}

@end
