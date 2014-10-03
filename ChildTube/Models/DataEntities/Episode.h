//
//  Episode.h
//  ChildTube
//
//  Created by MTG on 5/17/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface Episode : NSObject

@property (assign, nonatomic) sqlite3_int64 ID;
@property (strong, nonatomic) NSString *episodeNumber;
@property (strong, nonatomic) NSString *seriesNumber;
@property (strong, nonatomic) NSString *urlPath;

- (Episode *)initWithDictionary:(NSDictionary *)dictionary;

@end
