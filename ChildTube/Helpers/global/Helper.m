//
//  Helper.m
//  IAmInToo
//
//  Created by mtg on 1/9/15.
//  Copyright (c) 2015 mindthegap. All rights reserved.
//

#import "SharedHeaders.h"

#import "Helper.h"

#import <UIKit/UIKit.h>
#import "FXBlurView.h"

#import "TestReach.h"

#define SERVER_REST_HOST @"http://192.168.1.3"


@implementation Helper



#pragma mark - Overlay

+ (MRProgressOverlayView *)showProgressOverlayViewWithText:(NSString *)text view:(UIView *)view
{
    UIWindow *tempKeyboardWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
    UIWindow *topWindow = tempKeyboardWindow ? tempKeyboardWindow : view.window;
    MRProgressOverlayView *overlayView = [MRProgressOverlayView showOverlayAddedTo:topWindow animated:YES];
    [overlayView setMode:MRProgressOverlayViewModeIndeterminateSmall];
    [overlayView setTitleLabelText:text];
    
    return overlayView;
}

+ (void)dismissProgressOverlayView:(UIView *)view
{
    UIWindow *tempKeyboardWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
    UIWindow *topWindow = tempKeyboardWindow ? tempKeyboardWindow : view.window;
    [MRProgressOverlayView dismissAllOverlaysForView:topWindow animated:YES];
}


#pragma mark - Image Tweaks

+ (void)makeCornersRound:(UIView *)view
{
    if (view)
    {
        [view layer].cornerRadius = view.frame.size.width / 2;
        [view setClipsToBounds:YES];
    }
}

+ (void)makeCornersRoundHeight:(UIView *)view
{
    if (view)
    {
        [view layer].cornerRadius = view.frame.size.height / 2;
        [view setClipsToBounds:YES];
    }
}

+ (void)makeCornersRadius:(UIView *)view cornerRadius:(CGFloat)cornerRadius
{
    if (view) {
        [view layer].cornerRadius = cornerRadius;
        [view setClipsToBounds:YES];
    }
}


+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToFillSize:(CGSize)size
{
    CGFloat scale = MAX(size.width/image.size.width, size.height/image.size.height);
    CGFloat width = image.size.width * scale;
    CGFloat height = image.size.height * scale;
    CGRect imageRect = CGRectMake((size.width - width)/2.0f,
                                  (size.height - height)/2.0f,
                                  width,
                                  height);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [image drawInRect:imageRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)imageWithBlur:(UIImage *)image
{
    UIColor *color = [UIColor colorWithRed:0 green:0.5 blue:0.5 alpha:1];
    
    return [image blurredImageWithRadius:50.0 iterations:2 tintColor:color];
}



#pragma mark - Conversions

+ (NSString *)convertDateStrToDateFormatted:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ssZ"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    [dateFormatter setDateFormat:@"dd-MM-yy HH:mm:ss"];
    NSString *dateFormatted = [dateFormatter stringFromDate:date];
    
    return dateFormatted;
}

+ (NSDate *)convertDateStrToNSDate:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ssZ"];
    NSDate *date = [dateFormatter dateFromString:dateStr];

    return date;
}

+ (NSString *)convertDateToNSString:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    return [dateFormatter stringFromDate:date];
}

#pragma mark - Communications

+ (void)sendObjectWithString:(NSString *)str sendType:(NSString *)sendType bodyObj:(id)bodyObj completion:(DictionaryBlock)completionBlock failureBlock:(DictionaryAndErrorBlock)failureBlock
{
    NSError *jsonError;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:bodyObj options:0 error:&jsonError];
    
    if (jsonError)
    {
        NSLog(@"Had an error parsing the json string body so returning...");
        return;
    }
    
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"jsonBody: %@", jsonStr);
    
    [self sendObjectWithString:str sendType:sendType body:jsonData completion:completionBlock failureBlock:failureBlock];
}


+ (void)sendObjectWithString:(NSString *)str sendType:(NSString *)sendType body:(NSData *)body completion:(DictionaryBlock)completionBlock failureBlock:(DictionaryAndErrorBlock)failureBlock
{
    NSString *hostname = [NSString stringWithFormat:@"%@/%@", SERVER_REST_HOST, str];
    NSURL *url = [NSURL URLWithString:
                  [hostname stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    
    [request setHTTPMethod:sendType];
    NSLog(@"sending to hostname: %@/%@", SERVER_REST_HOST, str);
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:body];
    [request setValue:body == nil ? 0 : [NSString stringWithFormat:@"%lu", (unsigned long)[body length]] forHTTPHeaderField:@"Content-Length"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data.length > 0 && connectionError == nil)
        {
            NSDictionary *result = [self convertDataToJsonNSDictionary:data];
            
            if (result && [result count] > 0)
            {
                EMessageTypeFromServer type = [[result objectForKey:@"Type"] intValue];
                if (type == Error)
                {
                    NSString *error = [result objectForKey:@"ErrorInfo"];
                    NSString *innerException = [result objectForKey:@"InnerMessage"];
                    NSLog(@"Sending %@ to server returned error: %@\nInner Message: %@", str, error, innerException);
                    if (failureBlock) {
                        failureBlock(result, connectionError);
                    }
                    return;
                }

                if (completionBlock) {
                    completionBlock(result);
                }
            }
        }
        else
        {
            NSLog(@"ERROR: %@ got a bad response from the server with connectionError: %@", str, [connectionError localizedDescription]);
            if (failureBlock) {
                failureBlock(nil, connectionError);
            }
        }

    }];
}

+ (void)testInternetConnectionWithCompletion:(IdBlock)completion failureBlock:(IdBlock)failureBlock
{
    TestReach *internetReachable = [TestReach testReachWithHostName:@"www.google.com"];
    
    // Internet is reachable
    internetReachable.reachableBlock = ^(TestReach* reach)
    {
        if (completion) {
            completion(reach);
        }
    };
    
    // Internet is not reachable
    internetReachable.unreachableBlock = ^(TestReach* reach)
    {
        if (failureBlock) {
            failureBlock(reach);
        }
    };
    
    [internetReachable startNotifier];
}


#pragma mark - Conversions


+ (NSDictionary *)convertStringToJsonNSDictionary:(NSString *)str
{
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding]
                                                         options:NSJSONReadingMutableContainers error:&error];
    if (error)
    {
        NSLog(@"Error parsing outer json. Error: %@!", error);
        return nil;
    }
    
    return json;
}

+ (NSDictionary *)convertDataToJsonNSDictionary:(NSData *)data
{
    NSError *error;
    
    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSString *outerJson = [NSJSONSerialization JSONObjectWithData:[newStr dataUsingEncoding:NSUTF8StringEncoding]
                                                          options:NSJSONReadingAllowFragments error:&error];
    if (error)
    {
        NSLog(@"Error parsing outer json. Error: %@!", error);
        NSLog(@"Error string: %@", newStr);
        return nil;
    }
    
    NSDictionary *innerJson = [NSJSONSerialization JSONObjectWithData:[outerJson dataUsingEncoding:NSUTF8StringEncoding]
                                                              options:0 error:&error];
    if (error)
    {
        NSLog(@"Error parsing inner json. Error: %@!", error);
        return nil;
    }
    
    return innerJson;
}

+ (UIVisualEffectView *)applyBlurToView:(UIView *)view withEffectStyle:(UIBlurEffectStyle)style andConstraints:(BOOL)addConstraints
{
    UIVisualEffectView *visualEffectView = nil;
    //only apply the blur if the user hasn't disabled transparency effects
    if(!UIAccessibilityIsReduceTransparencyEnabled())
    {
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:style];
        visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        visualEffectView.frame = view.bounds;
        
        [visualEffectView setAlpha:0.0];
        [view addSubview:visualEffectView];
        
        if(addConstraints)
        {
            //add auto layout constraints so that the blur fills the screen upon rotating device
            [visualEffectView setTranslatesAutoresizingMaskIntoConstraints:NO];
            
            [view addConstraint:[NSLayoutConstraint constraintWithItem:visualEffectView
                                                             attribute:NSLayoutAttributeTop
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:view
                                                             attribute:NSLayoutAttributeTop
                                                            multiplier:1
                                                              constant:0]];
            
            [view addConstraint:[NSLayoutConstraint constraintWithItem:visualEffectView
                                                             attribute:NSLayoutAttributeBottom
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:view
                                                             attribute:NSLayoutAttributeBottom
                                                            multiplier:1
                                                              constant:0]];
            
            [view addConstraint:[NSLayoutConstraint constraintWithItem:visualEffectView
                                                             attribute:NSLayoutAttributeLeading
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:view
                                                             attribute:NSLayoutAttributeLeading
                                                            multiplier:1
                                                              constant:0]];
            
            [view addConstraint:[NSLayoutConstraint constraintWithItem:visualEffectView
                                                             attribute:NSLayoutAttributeTrailing
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:view
                                                             attribute:NSLayoutAttributeTrailing
                                                            multiplier:1
                                                              constant:0]];
        }
        
        [UIView animateWithDuration:0.2 animations:^{
            [visualEffectView setAlpha:1.0];
        }];
    }
    else
    {
        view.backgroundColor = [[UIColor cyanColor] colorWithAlphaComponent:0.7];
    }
    
    return visualEffectView;
}



#pragma mark - Async/Sync Helpers

+ (void)runOnMainQueueWithBlock:(void (^)())block
{
    if ([NSThread isMainThread])
    {
        block();
    }
    else
    {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}




@end
