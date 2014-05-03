//
//  Wedding.h
//  WeddingHelp
//
//  Created by MTG on 1/11/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Wedding : NSObject

@property (strong, nonatomic) NSString *groomFullName;
@property (strong, nonatomic) NSString *brideFullName;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *place;
@property (strong, nonatomic) NSString *imagePath;
@property (strong, nonatomic) UIImage  *image;

@end
