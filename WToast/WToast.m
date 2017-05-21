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

#if __IPHONE_OS_VERSION_MIN_REQUIRED < 80000
#error WToast requires deployment target iOS 8.0 or higher
#endif


#define TABBAR_OFFSET (44.0)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface WToast()

@property (nonatomic) NSInteger duration;
@property (nonatomic) BOOL roundedCorners;
@property (nonatomic) WToastGravity gravity;

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
	 animateWithDuration:0.2
	 animations:^{
		 weakSelf.alpha = 1.0;
	 }
	 completion:^(BOOL finished) {
		 [weakSelf performSelector:@selector(__hide) withObject:nil afterDelay:bDuration];
	 }];
}

- (void)__hide {
	__weak typeof(self) weakSelf = self;

	[UIView
	 animateWithDuration:0.8
	 animations:^{
		 weakSelf.alpha = 0.0;
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
		layer.cornerRadius = 5.0;
	}
}

+ (WToast *)__createWithText:(NSString *)text {
	CGSize screenSize = [UIScreen mainScreen].bounds.size;
	CGFloat screenWidth = screenSize.width;

	CGFloat x = 10.0;
	CGFloat width = screenWidth - x * 2.0;

	UILabel *textLabel = [[UILabel alloc] init];
	textLabel.backgroundColor = [UIColor clearColor];
	textLabel.textAlignment = NSTextAlignmentCenter;
	textLabel.font = [UIFont systemFontOfSize:14];
	textLabel.textColor = RGB(255, 255, 255);
	textLabel.numberOfLines = 0;
	textLabel.lineBreakMode = NSLineBreakByWordWrapping;

	CGRect frame = CGRectZero;
	CGSize sizeConstraint = CGSizeMake(width - 20.0, FLT_MAX);

	frame = [text boundingRectWithSize:sizeConstraint
									options:NSStringDrawingUsesLineFragmentOrigin
								 attributes:@{NSFontAttributeName: textLabel.font}
									context:nil];

	frame.size.width = width;
	frame.size.height = MAX(frame.size.height + 20.0, 38.0);

	WToast *toast = [[WToast alloc] initWithFrame:frame];
	toast.backgroundColor = RGBA(0, 0, 0, 0.8);

	textLabel.text = text;
	frame.origin.x = floor((toast.frame.size.width - frame.size.width) / 2.0);
	frame.origin.y = floor((toast.frame.size.height - frame.size.height) / 2.0);
	textLabel.frame = frame;

	[toast addSubview:textLabel];

	toast.alpha = 0.0;

	return toast;
}

+ (WToast *)__createWithImage:(UIImage *)image {
	CGSize screenSize = [UIScreen mainScreen].bounds.size;
	CGFloat screenWidth = screenSize.width;
	
	CGFloat x = 10.0;
	CGFloat width = screenWidth - x * 2.0;

	UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
	CGSize sz = imageView.frame.size;

	CGRect frame = CGRectZero;
	frame.size.width = width;
	frame.size.height = MAX(sz.height + 20.0, 38.0);

	WToast *toast = [[WToast alloc] initWithFrame:frame];
	toast.backgroundColor = RGBA(0, 0, 0, 0.8);

	frame.origin.x = floor((toast.frame.size.width - sz.width) / 2.0);
	frame.origin.y = floor((toast.frame.size.height - sz.height) / 2.0);
	frame.size = sz;
	imageView.frame = frame;
	[toast addSubview:imageView];

	toast.alpha = 0.0;
	
	return toast;
}

- (void)__flipViewAccordingToStatusBarOrientation {
	CGSize screenSize = [UIScreen mainScreen].bounds.size;
	CGFloat x = floor((screenSize.width - self.bounds.size.width) / 2.0);
	CGFloat y;
	
	switch (self.gravity) {
		case kWTGravityTop: {
			y = MIN([UIApplication sharedApplication].statusBarFrame.size.width, [UIApplication sharedApplication].statusBarFrame.size.height) + 15.0;
			break;
		}
		case kWTGravityMiddle: {
			y = floor((screenSize.height - self.bounds.size.height) * 0.5);
			break;
		}
		case kWTGravityBottom:
		default: {
			y = screenSize.height - self.bounds.size.height - 15.0 - TABBAR_OFFSET;
			break;
		}
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
	[WToast showWithText:text gravity:kWTGravityBottom];
}

/**
 * Show toast with text in application window
 * @param text Text to print in toast window
 * @param gravity Toast position in window
 */
+ (void)showWithText:(NSString *)text gravity:(WToastGravity)gravity {
	[WToast showWithText:text duration:kWTShort roundedCorners:NO gravity:gravity];
}

/**
 * Show toast with image in application window
 * @param image Image to show in toast window
 */
+ (void)showWithImage:(UIImage *)image {
	[WToast showWithImage:image gravity:kWTGravityBottom];
}

/**
 * Show toast with image in application window
 * @param image Image to show in toast window
 * @param gravity Toast position in window
 */
+ (void)showWithImage:(UIImage *)image gravity:(WToastGravity)gravity {
	[WToast showWithImage:image duration:kWTShort roundedCorners:NO gravity:gravity];
}

/**
 * Show toast with text in application window
 * @param text Text to print in toast window
 * @param duration Toast visibility duration
 */
+ (void)showWithText:(NSString *)text duration:(NSInteger)duration {
	[WToast showWithText:text duration:kWTShort gravity:kWTGravityBottom];
}

/**
 * Show toast with text in application window
 * @param text Text to print in toast window
 * @param duration Toast visibility duration
 * @param gravity Toast position in window
 */
+ (void)showWithText:(NSString *)text duration:(NSInteger)duration gravity:(WToastGravity)gravity {
	[WToast showWithText:text duration:kWTShort roundedCorners:NO gravity:gravity];
}

/**
 * Show toast with image in application window
 * @param image Image to show in toast window
 * @param duration Toast visibility duration
 */
+ (void)showWithImage:(UIImage *)image duration:(NSInteger)duration {
	[WToast showWithImage:image duration:kWTShort roundedCorners:NO gravity:kWTGravityBottom];
}

/**
 * Show toast with image in application window
 * @param image Image to show in toast window
 * @param duration Toast visibility duration
 * @param gravity Toast position in window
 */
+ (void)showWithImage:(UIImage *)image duration:(NSInteger)duration gravity:(WToastGravity)gravity {
	[WToast showWithImage:image duration:kWTShort roundedCorners:NO gravity:gravity];
}

/**
 * Show toast with text in application window
 * @param image Image to show in toast window
 * @param duration Toast visibility duration
 * @param roundedCorners Make corners of toast rounded
 */
+ (void)showWithText:(NSString *)text duration:(NSInteger)duration roundedCorners:(BOOL)roundedCorners {
	[WToast showWithText:text duration:duration roundedCorners:roundedCorners gravity:kWTGravityBottom];
}

/**
 * Show toast with text in application window
 * @param image Image to show in toast window
 * @param duration Toast visibility duration
 * @param roundedCorners Make corners of toast rounded
 * @param gravity Toast position in window
 */
+ (void)showWithText:(NSString *)text duration:(NSInteger)duration roundedCorners:(BOOL)roundedCorners gravity:(WToastGravity)gravity {
	WToast *toast = [WToast __createWithText:text];
	toast.duration = duration;
	toast.roundedCorners = roundedCorners;
	toast.gravity = gravity;

	[[self mainWindow] addSubview:toast];
	
	[toast __flipViewAccordingToStatusBarOrientation];
	[toast __show];
}

/**
 * Show toast with image in application window
 * @param image Image to show in toast window
 * @param duration Toast visibility duration
 * @param roundedCorners Make corners of toast rounded
 */
+ (void)showWithImage:(UIImage *)image duration:(NSInteger)duration roundedCorners:(BOOL)roundedCorners {
	[WToast showWithImage:image duration:duration roundedCorners:roundedCorners gravity:kWTGravityBottom];
}

/**
 * Show toast with image in application window
 * @param image Image to show in toast window
 * @param duration Toast visibility duration
 * @param roundedCorners Make corners of toast rounded
 */
+ (void)showWithImage:(UIImage *)image duration:(NSInteger)duration roundedCorners:(BOOL)roundedCorners gravity:(WToastGravity)gravity {
	WToast *toast = [WToast __createWithImage:image];
	toast.duration = duration;
	toast.roundedCorners = roundedCorners;
	toast.gravity = gravity;
	
	[[self mainWindow] addSubview:toast];
	
	[toast __flipViewAccordingToStatusBarOrientation];
	[toast __show];
}

+ (void)hideToast {
	[self hideToastAnimated:NO];
}

+ (void)hideToastAnimated:(BOOL)animated {
	WToast *toast = [self currentToast];
	
	if (toast) {
		if (animated) {
			[UIView
			 animateWithDuration:0.8
			 animations:^{
				 toast.alpha = 0.0;
			 }
			 completion:^(BOOL finished) {
				 [toast removeFromSuperview];
			 }];
		}
		else {
			[toast removeFromSuperview];
		}
	}
}

+ (WToast *)currentToast {
	NSEnumerator *subviewsEnum = [[self mainWindow].subviews reverseObjectEnumerator];
	
	for (UIView *subview in subviewsEnum) {
		if ([subview isKindOfClass:self]) {
			return (WToast *)subview;
		}
	}
	
	return nil;
}

+ (UIWindow *)mainWindow {
	return [[UIApplication sharedApplication] keyWindow];
}

@end
