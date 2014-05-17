//
//  Episode.h
//  ChildTube
//
//  Created by MTG on 5/17/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Episode : NSObject

@property (assign, nonatomic) int episodeNumber;
@property (assign, nonatomic) int seriesNumber;
@property (strong, nonatomic) NSString *urlPath;

@end
