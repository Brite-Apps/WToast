//
//  WToast.m
//  WToast
//
//  Small popup message inspired by Android Toast object
//
//  Created by Nik Dyonin on 08.04.11.
//  Copyright (c) 2011 Nik Dyonin. All rights reserved.
//  Copyright (c) 2014 Brite Apps. All rights reserved.
//

#import "WToast.h"

#if !__has_feature(objc_arc)
#error WToast requires ARC
#endif

#define TABBAR_OFFSET 44.0f
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface WToast()

@property (nonatomic) NSInteger duration;
@property (nonatomic) BOOL roundedCorners;

@end


@implementation WToast

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame]) != nil) {
		_duration = kWTShort;
		_roundedCorners = NO;
		self.userInteractionEnabled = NO;
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowWillAnimateRotation) name:@"UIWindowWillAnimateRotationNotification" object:nil];
	}
	return self;
}

- (void)windowWillAnimateRotation {
	[self __flipViewAccordingToStatusBarOrientation];
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)__show {
	__weak typeof(self) weakSelf = self;
	__block NSInteger bDuration = _duration;

	[UIView
	 animateWithDuration:0.2f
	 animations:^{
		 weakSelf.alpha = 1.0f;
	 }
	 completion:^(BOOL finished) {
		 [weakSelf performSelector:@selector(__hide) withObject:nil afterDelay:bDuration];
	 }];
}

- (void)__hide {
	__weak typeof(self) weakSelf = self;

	[UIView
	 animateWithDuration:0.8f
	 animations:^{
		 weakSelf.alpha = 0.0f;
	 }
	 completion:^(BOOL finished) {
		 [weakSelf removeFromSuperview];
	 }];
}

- (void)setRoundedCorners:(BOOL)roundedCorners {
	_roundedCorners = roundedCorners;
	
	if (_roundedCorners) {
		CALayer *layer = self.layer;
		layer.masksToBounds = YES;
		layer.cornerRadius = 5.0f;
	}
}

+ (WToast *)__createWithText:(NSString *)text {
	CGFloat screenWidth;
	CGSize screenSize = [UIScreen mainScreen].bounds.size;

	
	if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
		screenWidth = screenSize.width;
	}
	else {
		UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
		
		switch (orientation) {
			case UIInterfaceOrientationPortraitUpsideDown: {
				screenWidth = MIN(screenSize.width, screenSize.height);
				break;
			}
			case UIInterfaceOrientationLandscapeLeft: {
				screenWidth = MAX(screenSize.width, screenSize.height);
				break;
			}
			case UIInterfaceOrientationLandscapeRight: {
				screenWidth = MAX(screenSize.width, screenSize.height);
				break;
			}
			default: {
				screenWidth = MIN(screenSize.width, screenSize.height);
				break;
			}
		}
	}

	CGFloat x = 10.0f;
	CGFloat width = screenWidth - x * 2.0f;

	UILabel *textLabel = [[UILabel alloc] init];
	textLabel.backgroundColor = [UIColor clearColor];
	textLabel.textAlignment = NSTextAlignmentCenter;
	textLabel.font = [UIFont systemFontOfSize:14];
	textLabel.textColor = RGB(255, 255, 255);
	textLabel.numberOfLines = 0;
	textLabel.lineBreakMode = NSLineBreakByWordWrapping;

	CGRect frame = CGRectZero;
	CGSize sizeConstraint = CGSizeMake(width - 20.0f, FLT_MAX);

	frame = [text boundingRectWithSize:sizeConstraint
									options:NSStringDrawingUsesLineFragmentOrigin
								 attributes:@{NSFontAttributeName: textLabel.font}
									context:nil];

	frame.size.width = width;
	frame.size.height = MAX(frame.size.height + 20.0f, 38.0f);

	WToast *toast = [[WToast alloc] initWithFrame:frame];
	toast.backgroundColor = RGBA(0, 0, 0, 0.8f);

	textLabel.text = text;
	frame.origin.x = floor((toast.frame.size.width - frame.size.width) / 2.0f);
	frame.origin.y = floor((toast.frame.size.height - frame.size.height) / 2.0f);
	textLabel.frame = frame;

	[toast addSubview:textLabel];

	toast.alpha = 0.0f;

	return toast;
}

+ (WToast *)__createWithImage:(UIImage *)image {
	CGFloat screenWidth;
	CGSize screenSize = [UIScreen mainScreen].bounds.size;
	
	if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
		screenWidth = screenSize.width;
	}
	else {
		UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
		
		switch (orientation) {
			case UIInterfaceOrientationPortraitUpsideDown: {
				screenWidth = MIN(screenSize.width, screenSize.height);
				break;
			}
			case UIInterfaceOrientationLandscapeLeft: {
				screenWidth = MAX(screenSize.width, screenSize.height);
				break;
			}
			case UIInterfaceOrientationLandscapeRight: {
				screenWidth = MAX(screenSize.width, screenSize.height);
				break;
			}
			default: {
				screenWidth = MIN(screenSize.width, screenSize.height);
				break;
			}
		}
	}

	
	CGFloat x = 10.0f;
	CGFloat width = screenWidth - x * 2.0f;

	UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
	CGSize sz = imageView.frame.size;

	CGRect frame = CGRectZero;
	frame.size.width = width;
	frame.size.height = MAX(sz.height + 20.0f, 38.0f);

	WToast *toast = [[WToast alloc] initWithFrame:frame];
	toast.backgroundColor = RGBA(0, 0, 0, 0.8f);

	frame.origin.x = floor((toast.frame.size.width - sz.width) / 2.0f);
	frame.origin.y = floor((toast.frame.size.height - sz.height) / 2.0f);
	frame.size = sz;
	imageView.frame = frame;
	[toast addSubview:imageView];

	toast.alpha = 0.0f;
	
	return toast;
}

- (void)__flipViewAccordingToStatusBarOrientation {
	CGSize screenSize = [UIScreen mainScreen].bounds.size;
	CGFloat x;
	CGFloat y;

	if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
		x = floor((screenSize.width - self.bounds.size.width) / 2.0f);
		y = screenSize.height - self.bounds.size.height - 15.0f - TABBAR_OFFSET;
	}
	else {
		UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
		CGFloat angle = 0.0;

		switch (orientation) {
			case UIInterfaceOrientationPortraitUpsideDown: {
				angle = M_PI;
				CGFloat screenWidth = MIN(screenSize.width, screenSize.height);
				x = floor((screenWidth - self.bounds.size.width) / 2.0f);
				y = 15.0f + TABBAR_OFFSET;
				break;
			}
			case UIInterfaceOrientationLandscapeLeft: {
				angle = - M_PI / 2.0f;
				CGFloat screenWidth = MAX(screenSize.width, screenSize.height);
				CGFloat screenHeight = MIN(screenSize.width, screenSize.height);
				x = screenHeight - self.bounds.size.height - 15.0f - TABBAR_OFFSET;
				y = floor((screenWidth - self.bounds.size.width) / 2.0f);
				break;
			}
			case UIInterfaceOrientationLandscapeRight: {
				angle = M_PI / 2.0f;
				CGFloat screenWidth = MAX(screenSize.width, screenSize.height);
				x = 15.0f + TABBAR_OFFSET;
				y = floor((screenWidth - self.bounds.size.width) / 2.0f);
				break;
			}
			default: {
				angle = 0.0;
				CGFloat screenWidth = MIN(screenSize.width, screenSize.height);
				CGFloat screenHeight = MAX(screenSize.width, screenSize.height);
				x = floor((screenWidth - self.bounds.size.width) / 2.0f);
				y = screenHeight - self.bounds.size.height - 15.0f - TABBAR_OFFSET;
				break;
			}
		}
		
		self.transform = CGAffineTransformMakeRotation(angle);
	}

	CGRect f = self.bounds;
	f.origin = CGPointMake(x, y);
	self.frame = f;
}

/**
 * Show toast with text in application window
 * @param text Text to print in toast window
 */
+ (void)showWithText:(NSString *)text {
	[WToast showWithText:text duration:kWTShort roundedCorners:NO];
}

/**
 * Show toast with image in application window
 * @param image Image to show in toast window
 */
+ (void)showWithImage:(UIImage *)image {
	[WToast showWithImage:image duration:kWTShort roundedCorners:NO];
}

/**
 * Show toast with text in application window
 * @param text Text to print in toast window
 * @param length Toast visibility duration
 */
+ (void)showWithText:(NSString *)text duration:(NSInteger)duration {
	[WToast showWithText:text duration:kWTShort roundedCorners:NO];
}

/**
 * Show toast with image in application window
 * @param image Image to show in toast window
 * @param length Toast visibility duration
 */
+ (void)showWithImage:(UIImage *)image duration:(NSInteger)duration {
	[WToast showWithImage:image duration:kWTShort roundedCorners:NO];
}

/**
 * Show toast with text in application window
 * @param image Image to show in toast window
 * @param length Toast visibility duration
 * @param roundedCorners Make corners of toast rounded
 */
+ (void)showWithText:(NSString *)text duration:(NSInteger)duration roundedCorners:(BOOL)roundedCorners {
	WToast *toast = [WToast __createWithText:text];
	toast.duration = duration;
	toast.roundedCorners = roundedCorners;
	
	UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
	[mainWindow addSubview:toast];
	
	[toast __flipViewAccordingToStatusBarOrientation];
	[toast __show];
}

/**
 * Show toast with image in application window
 * @param image Image to show in toast window
 * @param length Toast visibility duration
 * @param roundedCorners Make corners of toast rounded
 */
+ (void)showWithImage:(UIImage *)image duration:(NSInteger)duration roundedCorners:(BOOL)roundedCorners {
	WToast *toast = [WToast __createWithImage:image];
	toast.duration = duration;
	toast.roundedCorners = roundedCorners;
	
	UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
	[mainWindow addSubview:toast];
	
	[toast __flipViewAccordingToStatusBarOrientation];
	[toast __show];
}

@end
