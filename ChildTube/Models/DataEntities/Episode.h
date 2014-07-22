//
//  Episode.h
//  ChildTube
//
//  Created by MTG on 5/17/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Episode : NSObject

@property (strong, nonatomic) NSString *episodeNumber;
@property (strong, nonatomic) NSString *seriesNumber;
@property (strong, nonatomic) NSString *urlPath;

- (Episode *)initWithDictionary:(NSDictionary *)dictionary;

@end
