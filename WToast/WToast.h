//
//  WToast.h
//  WToast
//
//  Small popup message inspired by Android Toast object
//
//  Created by Nik S Dyonin on 08.04.11.
//  Copyright (c) 2011 Nik S Dyonin. All rights reserved.
//

#define RGB(a, b, c) [UIColor colorWithRed:(a / 255.0f) green:(b / 255.0f) blue:(c / 255.0f) alpha:1.0f]
#define RGBA(a, b, c, d) [UIColor colorWithRed:(a / 255.0f) green:(b / 255.0f) blue:(c / 255.0f) alpha:d]

typedef NS_ENUM(NSInteger, WToastDuration) {
	kWTShort = 1,
	kWTLong = 5
};

@interface WToast : UIView

+ (void)showWithText:(NSString *)text;
+ (void)showWithImage:(UIImage *)image;

+ (void)showWithText:(NSString *)text duration:(WToastDuration)duration;
+ (void)showWithImage:(UIImage *)image duration:(WToastDuration)duration;

@end
