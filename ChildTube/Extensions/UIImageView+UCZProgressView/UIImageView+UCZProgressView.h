//
//  UIImageView+UIActivityIndicatorForSDWebImage.h
//  UIActivityIndicator for SDWebImage
//
//  Created by Giacomo Saccardo.
//  Copyright (c) 2014 Giacomo Saccardo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIImageView+WebCache.h"
#import <UCZProgressView/UCZProgressView.h>
#import "AWSS3.h"

#import "BFTask.h"

@interface UIImageView (UCZProgressView)

@property (nonatomic, strong) UIView *activityIndicator;

//- (void)downloadFacebookProfilePicture:(NSURL *)url downloadProgressBlock:(SDWebImageDownloaderProgressBlock)downloadProgressBlock completionBlock:(SDWebImageCompletionBlock)completionBlock;

//- (void)downloadImageWithPath:(NSString *)imagePath downloadProgressBlock:(AWSNetworkingDownloadProgressBlock)downloadProgressBlock completionBlock:(BFContinuationBlock)completionBlock failureBlock:(BFContinuationBlock)failureBlock withBlur:(BOOL)withBlur;
//
//- (void)downloadImageWithPath:(NSString *)imagePath downloadProgressBlock:(AWSNetworkingDownloadProgressBlock)downloadProgressBlock completionBlock:(BFContinuationBlock)completionBlock failureBlock:(BFContinuationBlock)failureBlock chatPhotoMessage:(ChatPhotoMessage *)chatPhotoMessage withBlur:(BOOL)withBlur;
//
//- (void)downloadVideoWithPath:(NSString *)videoPath progressBlock:(AWSNetworkingDownloadProgressBlock)progressBlock completionBlock:(BFContinuationBlock)completionBlock failureBlock:(BFContinuationBlock)failureBlock chatVideoMessage:(ChatVideoMessage *)chatVideoMessage;
//
//- (void)uploadVideoWithThumbnailImage:(UIImage *)image chatVideoMessage:(ChatVideoMessage *)chatVideoMessage videoUrl:(NSURL *)videoUrl forDate:(NSDate *)date key:(NSString *)key initialMessage:(InitialMessage *)initialMessage uploadProgressBlock:(AWSNetworkingUploadProgressBlock)uploadProgressBlock completionBlock:(BFContinuationBlock)completionBlock failureBlock:(BFContinuationBlock)failureBlock;
//
//- (void)uploadImageWithImage:(UIImage *)image chatPhotoMessage:(ChatPhotoMessage *)chatPhotoMessage compressedImageData:(NSData *)compressedImageData forDate:(NSDate *)date key:(NSString *)key uploadProgressBlock:(AWSNetworkingUploadProgressBlock)uploadProgressBlock completionBlock:(BFContinuationBlock)completionBlock failureBlock:(BFContinuationBlock)failureBlock;

//- (void)addNeededViewsForPhotoMessage:(ChatPhotoMessage *)chatPhotoMessage;
//- (void)addNeededViewsForVideoMessage:(ChatVideoMessage *)chatVideoMessage;

//- (void)removeActivityIndicator;

- (void)downloadImageWithPath:(NSString *)imagePath placeholderImage:(UIImage *)placeholderImage;


@end
