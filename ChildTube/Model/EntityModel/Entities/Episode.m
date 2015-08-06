#import "Episode.h"

@interface Episode ()

// Private interface goes here.

@end

@implementation Episode

- (void)updateWithDictionary:(NSDictionary *)episodeDictionary inContext:(NSManagedObjectContext *)context
{
    unsigned long episodeId = [[episodeDictionary objectForKey:@"Id"] longValue];
    unsigned long number = [[episodeDictionary objectForKey:@"Number"] longValue];
    NSString *title = [episodeDictionary objectForKey:@"Title"];
    NSString *urlPath = [episodeDictionary objectForKey:@"URLPath"];

    [self setIdValue:episodeId];
    [self setNumberValue:number];
    if (title && [title class] != [NSNull class]) [self setTitle:title];
    [self setUrlPath:urlPath];
    
    NSLog(@"Finished updating episode with id %lu", episodeId);
}


@end
