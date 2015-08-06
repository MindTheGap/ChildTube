#import "_Episode.h"

@interface Episode : _Episode {}

- (void)updateWithDictionary:(NSDictionary *)episodeDictionary inContext:(NSManagedObjectContext *)context;

@end
