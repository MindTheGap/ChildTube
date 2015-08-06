#import "_Playlist.h"

@interface Playlist : _Playlist {}

- (void)addOrUpdateEpisodes:(NSArray *)episodesArray inContext:(NSManagedObjectContext *)context;
- (void)updateWithDictionary:(NSDictionary *)playlistDictionary inContext:(NSManagedObjectContext *)context;

@end
