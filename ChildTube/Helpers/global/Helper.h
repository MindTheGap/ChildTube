//
//  Helper.h
//  IAmInToo
//
//  Created by mtg on 1/9/15.
//  Copyright (c) 2015 mindthegap. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MRProgressOverlayView;

@interface Helper : NSObject


#pragma mark - Overlay
+ (MRProgressOverlayView *)showProgressOverlayViewWithText:(NSString *)text view:(UIView *)view;
+ (void)dismissProgressOverlayView:(UIView *)view;

#pragma mark - Image Tweaks
+ (void)makeCornersRoundHeight:(UIView *)view;
+ (void)makeCornersRound:(UIView *)view;
+ (void)makeCornersRadius:(UIView *)view cornerRadius:(CGFloat)cornerRadius;
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
+ (UIImage *)imageWithImage:(UIImage *)image scaledToFillSize:(CGSize)size;
+ (UIImage *)imageWithBlur:(UIImage *)image;

#pragma mark - Conversions
+ (NSString *)convertDateStrToDateFormatted:(NSString *)dateStr;
+ (NSDate *)convertDateStrToNSDate:(NSString *)dateStr;
+ (NSString *)convertDateToNSString:(NSDate *)date;

#pragma mark - Communications
+ (void)sendObjectWithString:(NSString *)str sendType:(NSString *)sendType body:(NSData *)body completion:(DictionaryBlock)completionBlock failureBlock:(DictionaryAndErrorBlock)failureBlock;
+ (void)sendObjectWithString:(NSString *)str sendType:(NSString *)sendType bodyObj:(id)bodyObj completion:(DictionaryBlock)completionBlock failureBlock:(DictionaryAndErrorBlock)failureBlock;
+ (void)testInternetConnectionWithCompletion:(IdBlock)completion failureBlock:(IdBlock)failureBlock;

#pragma mark - View Effects
+ (UIVisualEffectView *)applyBlurToView:(UIView *)view withEffectStyle:(UIBlurEffectStyle)style andConstraints:(BOOL)addConstraints;

#pragma mark - Async/Sync Helpers
+ (void)runOnMainQueueWithBlock:(void (^)())block;


@end
