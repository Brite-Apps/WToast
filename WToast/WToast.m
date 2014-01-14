//
//  WToast.m
//  WToast
//
//  Small popup message inspired by Android Toast object
//
//  Created by Nik S Dyonin on 08.04.11.
//  Copyright (c) 2011 Nik S Dyonin. All rights reserved.
//

#import "WToast.h"

@import QuartzCore;

#if !__has_feature(objc_arc)
#error WToast requires ARC
#endif

#define TABBAR_OFFSET 44.0f

@interface WToast()

@property (nonatomic) NSInteger duration;

@end


@implementation WToast

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame]) != nil) {
		_duration = kWTShort;
		self.userInteractionEnabled = NO;
	}
	return self;
}

- (void)__show {
	__weak typeof(self) weakSelf = self;
	
	[UIView
	 animateWithDuration:0.2f
	 animations:^{
		 weakSelf.alpha = 1.0f;
	 }
	 completion:^(BOOL finished) {
		 [weakSelf performSelector:@selector(__hide) withObject:nil afterDelay:_duration];
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

+ (WToast *)__createWithText:(NSString *)text {
	CGFloat screenWidth;
	CGSize screenSize = [UIScreen mainScreen].bounds.size;
	
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
	
	CGFloat x = 10.0f;
	CGFloat width = screenWidth - x * 2.0f;

	UILabel *textLabel = [[UILabel alloc] init];
	textLabel.backgroundColor = [UIColor clearColor];
	textLabel.textAlignment = NSTextAlignmentCenter;
	textLabel.font = [UIFont systemFontOfSize:14];
	textLabel.textColor = RGB(255, 255, 255);
	textLabel.numberOfLines = 0;
	textLabel.lineBreakMode = NSLineBreakByWordWrapping;

	CGRect tmpRect = [text boundingRectWithSize:CGSizeMake(width - 20.0f, FLT_MAX)
										options:NSStringDrawingUsesLineFragmentOrigin
									 attributes:@{NSFontAttributeName: textLabel.font}
										context:nil];

	tmpRect.origin = CGPointZero;
	tmpRect.size.width = width;
	tmpRect.size.height = MAX(tmpRect.size.height + 20.0f, 38.0f);

	WToast *toast = [[WToast alloc] initWithFrame:tmpRect];
	toast.backgroundColor = RGBA(0, 0, 0, 0.8f);
	CALayer *layer = toast.layer;
	layer.masksToBounds = YES;
	layer.cornerRadius = 5.0f;

	textLabel.text = text;
	tmpRect.origin.x = floor((toast.frame.size.width - tmpRect.size.width) / 2.0f);
	tmpRect.origin.y = floor((toast.frame.size.height - tmpRect.size.height) / 2.0f);
	textLabel.frame = tmpRect;

	[toast addSubview:textLabel];

	toast.alpha = 0.0f;

	return toast;
}

+ (WToast *)__createWithImage:(UIImage *)image {
	CGFloat screenWidth;
	CGSize screenSize = [UIScreen mainScreen].bounds.size;
	
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
	
	CGFloat x = 10.0f;
	CGFloat width = screenWidth - x * 2.0f;

	UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
	CGSize sz = imageView.frame.size;

	CGRect tmpRect = CGRectZero;
	tmpRect.size.width = width;
	tmpRect.size.height = MAX(sz.height + 20.0f, 38.0f);

	WToast *toast = [[WToast alloc] initWithFrame:tmpRect];
	toast.backgroundColor = RGBA(0, 0, 0, 0.8f);
	CALayer *layer = toast.layer;
	layer.masksToBounds = YES;
	layer.cornerRadius = 5.0f;

	tmpRect.origin.x = floor((toast.frame.size.width - sz.width) / 2.0f);
	tmpRect.origin.y = floor((toast.frame.size.height - sz.height) / 2.0f);
	tmpRect.size = sz;
	imageView.frame = tmpRect;
	[toast addSubview:imageView];

	toast.alpha = 0.0f;
	
	return toast;
}

- (void)__flipViewAccordingToStatusBarOrientation {
	UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    CGFloat angle = 0.0;
	CGSize screenSize = [UIScreen mainScreen].bounds.size;
	CGFloat x;
	CGFloat y;

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

	CGRect f = self.frame;
	f.origin = CGPointMake(x, y);
	self.frame = f;
}

/**
 * Show toast with text in application window
 * @param text Text to print in toast window
 */
+ (void)showWithText:(NSString *)text {
	[WToast showWithText:text duration:kWTShort];
}

/**
 * Show toast with image in application window
 * @param image Image to show in toast window
 */
+ (void)showWithImage:(UIImage *)image {
	[WToast showWithImage:image duration:kWTShort];
}

/**
 * Show toast with text in application window
 * @param text Text to print in toast window
 * @param length Toast visibility duration
 */
+ (void)showWithText:(NSString *)text duration:(WToastDuration)duration {
	WToast *toast = [WToast __createWithText:text];
	toast.duration = duration;
	
	UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
	[mainWindow addSubview:toast];
	
	[toast __flipViewAccordingToStatusBarOrientation];
	[toast __show];
}

/**
 * Show toast with image in application window
 * @param image Image to show in toast window
 * @param length Toast visibility duration
 */
+ (void)showWithImage:(UIImage *)image duration:(WToastDuration)duration {
	WToast *toast = [WToast __createWithImage:image];
	toast.duration = duration;
	
	UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
	[mainWindow addSubview:toast];
	
	[toast __flipViewAccordingToStatusBarOrientation];
	[toast __show];
}

@end
