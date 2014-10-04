//
//  Episode.m
//  ChildTube
//
//  Created by MTG on 5/17/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import "Episode.h"

@implementation Episode

- (Episode *)initWithDictionary:(NSDictionary *)dictionary
{
    if (![super init])
    {
        return false;
    }
    
    [self setID:[[dictionary objectForKey:@"EpisodeID"] longLongValue]];
    [self setUrlPath:[dictionary objectForKey:@"URLPath"]];
    [self setEpisodeNumber:[dictionary objectForKey:@"EpisodeNumber"]];
    [self setSeriesNumber:[dictionary objectForKey:@"SeriesNumber"]];
    [self setTvSeriesID:[[dictionary objectForKey:@"TvSeriesID"] longLongValue]];

    return self;
}

@end
