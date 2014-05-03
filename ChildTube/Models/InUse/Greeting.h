//
//  Greeting.h
//  WeddingHelp
//
//  Created by MTG on 1/18/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Greeting : NSObject

@property (strong, nonatomic) NSString *firstLines;
@property (strong, nonatomic) NSString *secondLines;
@property (strong, nonatomic) NSString *userProfileImagePath;
@property (strong, nonatomic) NSString *addedImagePath;

@property (strong, nonatomic) UIImage *userProfileImage;
@property (strong, nonatomic) UIImage *addedImage;

@property (strong, nonatomic) NSMutableArray *likes;
@property (strong, nonatomic) NSMutableArray *comments;
@property (assign, nonatomic) int greetingId;

@end
