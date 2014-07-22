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
    
    [self setUrlPath:[dictionary objectForKey:@"URLPath"]];
    [self setEpisodeNumber:[dictionary objectForKey:@"EpisodeNumber"]];
    [self setSeriesNumber:[dictionary objectForKey:@"SeriesNumber"]];
    
    return self;
}

@end
