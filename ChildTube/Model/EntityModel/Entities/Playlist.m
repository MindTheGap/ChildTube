#import "SharedHeaders.h"

#import "Playlist.h"

#import "Episode.h"


@interface Playlist ()



@end

@implementation Playlist

- (void)addOrUpdateEpisodes:(NSArray *)episodesArray inContext:(NSManagedObjectContext *)context
{
    if (!episodesArray || [episodesArray class] == [NSNull class]) return;
    
    // creating all new chat messages
    for (NSDictionary *episodeDictionary in episodesArray) {
        int64_t episodeId = [[episodeDictionary objectForKey:@"Id"] longValue];
        Episode *episode = [Episode MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"id == %lld" argumentArray:@[@(episodeId)]] inContext:context];

        if (!episode) episode = [Episode MR_createEntityInContext:context];
        
        [episode updateWithDictionary:episodeDictionary inContext:context];
        [episode setPlaylist:self];
    }
}

- (void)updateWithDictionary:(NSDictionary *)playlistDictionary inContext:(NSManagedObjectContext *)context
{
    unsigned long playlistId = [[playlistDictionary objectForKey:@"Id"] longValue];
    unsigned long hits = [[playlistDictionary objectForKey:@"Hits"] longValue];
    NSString *title = [playlistDictionary objectForKey:@"Title"];
    NSString *imagePath = [playlistDictionary objectForKey:@"ImagePath"];
    
    [self setIdValue:playlistId];
    [self setHitsValue:hits];
    [self setTitle:title];
    [self setImagePath:imagePath];
}


@end
