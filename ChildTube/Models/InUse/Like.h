//
//  Like.h
//  WeddingHelp
//
//  Created by MTG on 1/18/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Comment.h"
#import "Greeting.h"

@interface Like : NSObject

@property (weak, nonatomic) id object;
@property (strong, nonatomic) id likeCreator;

@end
