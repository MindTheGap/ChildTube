//
//  UIImageView+UIActivityIndicatorForSDWebImage.m
//  UIActivityIndicator for SDWebImage
//
//  Created by Giacomo Saccardo.
//  Copyright (c) 2014 Giacomo Saccardo. All rights reserved.
//

#import "SharedHeaders.h"

#import "UIImageView+UCZProgressView.h"

#import <objc/runtime.h>
#import <UCZProgressView/UCZProgressView.h>
#import "FXBlurView.h"


@interface UIImageView (Private)


@end

@implementation UIImageView (UCZProgressView)

@dynamic activityIndicator;


- (void)addActivityIndicator {
    
    [Helper runOnMainQueueWithBlock:^{
        UCZProgressView *activityIndicator = [[UCZProgressView alloc] initWithFrame:self.frame];
        activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
        activityIndicator.showsText = YES;
        activityIndicator.blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        [activityIndicator setProgress:0.0 animated:NO];
        [activityIndicator setAlpha:0.0];
        self.activityIndicator = activityIndicator;
        
        [self updateActivityIndicatorFrame];
        
        [self addSubview:self.activityIndicator];

        [(UCZProgressView *)self.activityIndicator setProgress:0.0];
        [(UCZProgressView *)self.activityIndicator setAlpha:1.0];
    }];
}

-(void)updateActivityIndicatorFrame {
    if (self.activityIndicator) {
        [Helper runOnMainQueueWithBlock:^{
            CGRect activityIndicatorBounds = self.activityIndicator.bounds;
            float x = (self.frame.size.width - activityIndicatorBounds.size.width) / 2.0;
            float y = (self.frame.size.height - activityIndicatorBounds.size.height) / 2.0;
            self.activityIndicator.frame = CGRectMake(x, y, activityIndicatorBounds.size.width, activityIndicatorBounds.size.height);
        }];
    }
}

- (void)removeActivityIndicator {
    if (self.activityIndicator) {
        [Helper runOnMainQueueWithBlock:^{
            [self.activityIndicator removeFromSuperview];
            self.activityIndicator = nil;
        }];
    }
}

-(void)layoutSubviews {
    [super layoutSubviews];

    [self updateActivityIndicatorFrame];
}
//
//#pragma mark - Methods
//
//- (void)uploadVideoWithThumbnailImage:(UIImage *)image chatVideoMessage:(ChatVideoMessage *)chatVideoMessage videoUrl:(NSURL *)videoUrl forDate:(NSDate *)date key:(NSString *)key initialMessage:(InitialMessage *)initialMessage uploadProgressBlock:(AWSNetworkingUploadProgressBlock)uploadProgressBlock completionBlock:(BFContinuationBlock)completionBlock failureBlock:(BFContinuationBlock)failureBlock
//{
//    self.image = image;
//    
//    [self removeRetryView];
//    [self addActivityIndicator];
//    
//    [[StorageMediator sharedObject] uploadVideoWithThumbnailImage:image videoUrl:videoUrl forDate:date key:key initialMessage:initialMessage uploadProgressBlock:^(int64_t bytesSent, int64_t totalBytesSent, int64_t totalBytesExpectedToSend) {
//        if (uploadProgressBlock) {
//            uploadProgressBlock(bytesSent, totalBytesSent, totalBytesExpectedToSend);
//        }
//        
//        NSLog(@"bytesSent: %lld, totalBytesSent: %lld, totalBytesExpectedToSend: %lld", bytesSent, totalBytesSent, totalBytesExpectedToSend);
//        
//        CGFloat progress = MIN((float)totalBytesSent / totalBytesExpectedToSend,0.99);
//        
//        [self performSelectorOnMainThread:@selector(setLoaderProgress:) withObject:[NSNumber numberWithFloat:progress] waitUntilDone:NO];
//    } completionBlock:^id(BFTask *task) {
//        [[WantAdapter sharedObject] sendNewChatVideoMessage:chatVideoMessage key:key forInitialMessageId:[initialMessage idValue] completion:^{
//            [self removeActivityIndicator];
//            [self addPlayView];
//            
//            if (completionBlock) {
//                completionBlock(task);
//            }
//        } failureBlock:^(NSDictionary *result, NSError *connectionError) {
//            [self removeActivityIndicator];
//            [self addRetryView:[chatVideoMessage size] upload:YES];
//            
//            if (failureBlock) {
//                failureBlock(task);
//            }
//        }];
//        
//        return task;
//    } failureBlock:^id(BFTask *task) {
//        [self removeActivityIndicator];
//        [self addRetryView:[chatVideoMessage size] upload:YES];
//        
//        if (failureBlock) {
//            failureBlock(task);
//        }
//
//        return task;
//    }];
//}
//
//- (void)downloadFacebookProfilePicture:(NSURL *)url downloadProgressBlock:(SDWebImageDownloaderProgressBlock)downloadProgressBlock completionBlock:(SDWebImageCompletionBlock)completionBlock
//{
//    [self addActivityIndicator];
//    
//    [self sd_setImageWithURL:url placeholderImage:nil options:SDWebImageRetryFailed|SDWebImageContinueInBackground progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//        if (downloadProgressBlock) {
//            downloadProgressBlock(receivedSize, expectedSize);
//        }
//        NSLog(@"receivedSize: %ld, expectedSize: %ld", (long)receivedSize, (long)expectedSize);
//        
//        CGFloat progress = MIN((float)receivedSize / expectedSize,0.99);
//        
//        [self performSelectorOnMainThread:@selector(setLoaderProgress:) withObject:[NSNumber numberWithFloat:progress] waitUntilDone:NO];
//    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        if (completionBlock) {
//            completionBlock(image, error, cacheType, imageURL);
//        }
//        
//        self.image = image;
//        
//        [self removeActivityIndicator];
//    }];
//}
//
//- (void)downloadVideoWithPath:(NSString *)videoPath progressBlock:(AWSNetworkingDownloadProgressBlock)progressBlock completionBlock:(BFContinuationBlock)completionBlock failureBlock:(BFContinuationBlock)failureBlock chatVideoMessage:(ChatVideoMessage *)chatVideoMessage
//{
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString  *documentsDirectory = [paths objectAtIndex:0];
//    NSString *downloadingFilePath = [documentsDirectory stringByAppendingPathComponent:[[videoPath componentsSeparatedByString:@"/"] lastObject]];
//    NSURL *downloadingFileURL = [NSURL fileURLWithPath:downloadingFilePath];
//    
//    [self removeRetryView];
//    [self addActivityIndicator];
//    
//    [[StorageMediator sharedObject] downloadFileWithPath:videoPath downloadingFileURL:downloadingFileURL downloadProgressBlock:^(int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
//        if (progressBlock) {
//            progressBlock(bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
//        }
//        
//        NSLog(@"bytesWritten: %lld, totalBytesWritten: %lld, totalBytesExpectedToWrite: %lld", bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
//        
//        CGFloat progress = MIN((float)totalBytesWritten / totalBytesExpectedToWrite,0.99);
//        
//        [self performSelectorOnMainThread:@selector(setLoaderProgress:) withObject:[NSNumber numberWithFloat:progress] waitUntilDone:NO];
//    } completionBlock:^id(BFTask *task) {
//        NSLog(@"Finished downloading video %@", videoPath);
//
//        ALAssetsLibrary *library = [Helper defaultAssetsLibrary];
//        [library saveVideo:downloadingFileURL toAlbum:@"IAmInToo" completion:^(NSURL *assetURL, NSError *error) {
//            NSLog(@"Saved video on custom album");
//            [library assetForURL:assetURL resultBlock:^(ALAsset *asset) {
//                NSLog(@"Setting video to local album path");
//                
//                [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
//                    ChatVideoMessage *localChatVideoMessage = [chatVideoMessage MR_inContext:localContext];
//                    
//                    [localChatVideoMessage setVideoPath:[[[asset defaultRepresentation] url] absoluteString]];
//                } completion:^(BOOL success, NSError *error) {
//                    [self performSelectorOnMainThread:@selector(setLoaderProgress:) withObject:[NSNumber numberWithFloat:1.0] waitUntilDone:YES];
//
//                    [[UpdateMediator sharedObject] readChatMessage:chatVideoMessage completion:^{
//                        if (completionBlock) {
//                            completionBlock(task);
//                        }
//
//                        [self removeActivityIndicator];
//                        [self addPlayView];
//                    } failureBlock:^(NSDictionary *result, NSError *connectionError) {
//                        if (failureBlock) {
//                            failureBlock(task);
//                        }
//
//                        [self removeActivityIndicator];
//                        [self addRetryView:[chatVideoMessage size] upload:NO];
//                    }];
//                }];
//                
//            } failureBlock:nil];
//        } failure:^(NSError *error) {
//            NSLog(@"Couldn't save image on custom album");
//            NSLog(@"Error: %@", [error localizedDescription]);
//            
//            [self removeActivityIndicator];
//            [self addRetryView:[chatVideoMessage size] upload:NO];
//        }];
//
//        return task;
//    } failureBlock:^id(BFTask *task) {
//        if (failureBlock) {
//            failureBlock(task);
//        }
//        
//        [self removeActivityIndicator];
//        [self addRetryView:[chatVideoMessage size] upload:NO];
//
//        return task;
//    }];
//}
//

- (void)downloadImageWithPath:(NSString *)imagePath placeholderImage:(UIImage *)placeholderImage
{
    [self addActivityIndicator];
    
    [self sd_setImageWithURL:[NSURL URLWithString:imagePath] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error) {
            NSLog(@"Couldn't download image with path: %@, with error: %@", imagePath, [error localizedDescription]);
        }
        
        [self removeActivityIndicator];
    }];
}

//
//- (void)downloadImageWithPath:(NSString *)imagePath downloadProgressBlock:(AWSNetworkingDownloadProgressBlock)downloadProgressBlock completionBlock:(BFContinuationBlock)completionBlock failureBlock:(BFContinuationBlock)failureBlock chatPhotoMessage:(ChatPhotoMessage *)chatPhotoMessage withBlur:(BOOL)withBlur
//{
//    [self downloadImageWithPath:imagePath downloadProgressBlock:downloadProgressBlock completionBlock:^id(BFTask *task) {
//        if (chatPhotoMessage) {
//            ALAssetsLibrary *library = [Helper defaultAssetsLibrary];
//            [library saveImage:self.image toAlbum:@"IAmInToo" completion:^(NSURL *assetURL, NSError *error) {
//                NSLog(@"Saved image on custom album");
//                [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
//                    ChatPhotoMessage *localChatPhotoMessage = [chatPhotoMessage MR_inContext:localContext];
//
//                    localChatPhotoMessage.imagePath = [assetURL absoluteString];
//                } completion:^(BOOL success, NSError *error) {
//                    [[UpdateMediator sharedObject] readChatMessage:chatPhotoMessage completion:^{
//                        if (completionBlock) {
//                            completionBlock(task);
//                        }
//                    } failureBlock:^(NSDictionary *result, NSError *connectionError) {
//                        if (failureBlock) {
//                            failureBlock(task);
//                        }
//                    }];
//                }];
//            } failure:^(NSError *error) {
//                NSLog(@"Couldn't save image on custom album");
//                NSLog(@"Error: %@", [error localizedDescription]);
//
//                if (failureBlock) {
//                    failureBlock(task);
//                }
//            }];
//        }
//        
//        return task;
//    } failureBlock:failureBlock withBlur:withBlur];
//}
//
//- (void)uploadImageWithImage:(UIImage *)image chatPhotoMessage:(ChatPhotoMessage *)chatPhotoMessage compressedImageData:(NSData *)compressedImageData forDate:(NSDate *)date key:(NSString *)key uploadProgressBlock:(AWSNetworkingUploadProgressBlock)uploadProgressBlock completionBlock:(BFContinuationBlock)completionBlock failureBlock:(BFContinuationBlock)failureBlock
//{
//    [self removeRetryView];
//    [self addActivityIndicator];
//    
//    [[StorageMediator sharedObject] uploadImageWithImage:image compressedImageData:compressedImageData forDate:date key:key uploadProgressBlock:^(int64_t bytesSent, int64_t totalBytesSent, int64_t totalBytesExpectedToSend) {
//        if (uploadProgressBlock) {
//            uploadProgressBlock(bytesSent, totalBytesSent, totalBytesExpectedToSend);
//        }
//        
//        NSLog(@"key: %@  -  bytesSent: %lld, totalBytesSent: %lld, totalbytesExpectedToSend: %lld", key, bytesSent, totalBytesSent, totalBytesExpectedToSend);
//        
//        CGFloat progress = MIN((float)totalBytesSent / totalBytesExpectedToSend,0.99);
//        
//        [self performSelectorOnMainThread:@selector(setLoaderProgress:) withObject:[NSNumber numberWithFloat:progress] waitUntilDone:NO];
//    } completionBlock:^id(BFTask *task) {
//        if (completionBlock) {
//            completionBlock(task);
//        }
//        
//        [self removeActivityIndicator];
//        
//        return task;
//    } failureBlock:^id(BFTask *task) {
//        if (failureBlock) {
//            failureBlock(task);
//        }
//        
//        [self removeActivityIndicator];
//        [self addRetryView:[chatPhotoMessage size] upload:YES];
//
//        return task;
//    }];
//}
//
//- (void)addNeededViewsForPhotoMessage:(ChatPhotoMessage *)chatPhotoMessage
//{
//    switch ([chatPhotoMessage receivedStateValue]) {
//        case MessageStateNotReceivedYet: {
//            [self addRetryView:[chatPhotoMessage size] upload:YES];
//            break;
//        }
//        case MessageStateSentToServer:
//        case MessageStateSentToClient: {
//            if (![chatPhotoMessage ownerValue]) {
//                [self addRetryView:[chatPhotoMessage size] upload:NO];
//            }
//            break;
//        }
//        case MessageStateReadByClient:
//        case MessageStateReadByClientAck:
//        case MessageStateReadByClientAckServerOk: {
//            break;
//        }
//    }
//}
//
//- (void)addNeededViewsForVideoMessage:(ChatVideoMessage *)chatVideoMessage
//{
//    switch ([chatVideoMessage receivedStateValue]) {
//        case MessageStateNotReceivedYet: {
//            [self addRetryView:[chatVideoMessage size] upload:YES];
//            break;
//        }
//        case MessageStateSentToServer:
//        case MessageStateSentToClient: {
//            if (![chatVideoMessage ownerValue]) {
//                [self addRetryView:[chatVideoMessage size] upload:NO];
//            } else {
//                [self addPlayView];
//            }
//            break;
//        }
//        case MessageStateReadByClient:
//        case MessageStateReadByClientAck:
//        case MessageStateReadByClientAckServerOk: {
//            [self addPlayView];
//            break;
//        }
//    }
//}
//
//- (void)setLoaderProgress:(NSNumber *)number
//{
//    if (self.activityIndicator) {
//        float num = [number floatValue];
//        if ([self.activityIndicator respondsToSelector:@selector(setProgress:animated:)]) {
//            [(UCZProgressView *)self.activityIndicator setProgress:num animated:YES];
//        }
//    }
//}
//






@end
