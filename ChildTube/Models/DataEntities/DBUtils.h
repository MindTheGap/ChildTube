//
//  DBUtils.h
//  ChildTube
//
//  Created by MTG on 8/7/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DBUtils : NSObject

- (void)close;

- (BOOL)isTvSeriesExists:(NSString *)tvSeriesName;
- (sqlite3_int64)addTvSeriesWithName:(NSString *)tvSeriesName imagePath:(NSString *)imagePath image:(UIImage *)image;
- (sqlite3_int64)addEpisode:(int)episodeNumber seriesNumber:(int)seriesNumber urlPath:(NSString *)urlPath tvSeriesID:(sqlite3_int64)tvSeriesID;


@end
