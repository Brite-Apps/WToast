//
//  WToast.h
//  WToast
//
//  Small popup message inspired by Android Toast object
//
//  Created by Nik Dyonin on 08.04.11.
//  Copyright (c) 2011 Nik Dyonin. All rights reserved.
//  Copyright (c) 2014-2020 Brite Apps. All rights reserved.
//

@import Foundation;
@import UIKit;
@import QuartzCore;

typedef NS_ENUM(NSInteger, WToastDuration) {
	kWTShort = 1,
	kWTLong = 5
};

typedef NS_ENUM(NSInteger, WToastGravity) {
	kWTGravityBottom = 0,
	kWTGravityMiddle = 1,
	kWTGravityTop = 2
};

@interface WToast : UIView

@property (class, nonatomic, strong) UIColor *backgroundColor;
@property (class, nonatomic, strong) UIColor *textColor;

+ (void)showWithText:(NSString *)text;
+ (void)showWithImage:(UIImage *)image;

+ (void)showWithText:(NSString *)text duration:(NSInteger)duration;
+ (void)showWithImage:(UIImage *)image duration:(NSInteger)duration;

+ (void)showWithText:(NSString *)text duration:(NSInteger)duration roundedCorners:(BOOL)roundedCorners;
+ (void)showWithImage:(UIImage *)image duration:(NSInteger)duration roundedCorners:(BOOL)roundedCorners;

+ (void)showWithText:(NSString *)text gravity:(WToastGravity)gravity;
+ (void)showWithImage:(UIImage *)image gravity:(WToastGravity)gravity;

+ (void)showWithText:(NSString *)text duration:(NSInteger)duration gravity:(WToastGravity)gravity;
+ (void)showWithImage:(UIImage *)image duration:(NSInteger)duration gravity:(WToastGravity)gravity;

+ (void)showWithText:(NSString *)text duration:(NSInteger)duration roundedCorners:(BOOL)roundedCorners gravity:(WToastGravity)gravity;
+ (void)showWithImage:(UIImage *)image duration:(NSInteger)duration roundedCorners:(BOOL)roundedCorners gravity:(WToastGravity)gravity;

+ (void)hideToast;
+ (void)hideToastAnimated:(BOOL)animated;

@end
