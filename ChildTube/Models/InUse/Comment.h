//
//  Comment.h
//  WeddingHelp
//
//  Created by MTG on 1/18/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject

@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSMutableArray *likes;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) id commentCreator;

@end
