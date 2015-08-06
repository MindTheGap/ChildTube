// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Playlist.m instead.

#import "_Playlist.h"

const struct PlaylistAttributes PlaylistAttributes = {
	.hits = @"hits",
	.id = @"id",
	.imagePath = @"imagePath",
	.saved = @"saved",
	.title = @"title",
};

const struct PlaylistRelationships PlaylistRelationships = {
	.episodes = @"episodes",
};

@implementation PlaylistID
@end

@implementation _Playlist

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Playlist" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Playlist";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Playlist" inManagedObjectContext:moc_];
}

- (PlaylistID*)objectID {
	return (PlaylistID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"hitsValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"hits"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"savedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"saved"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic hits;

- (int64_t)hitsValue {
	NSNumber *result = [self hits];
	return [result longLongValue];
}

- (void)setHitsValue:(int64_t)value_ {
	[self setHits:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveHitsValue {
	NSNumber *result = [self primitiveHits];
	return [result longLongValue];
}

- (void)setPrimitiveHitsValue:(int64_t)value_ {
	[self setPrimitiveHits:[NSNumber numberWithLongLong:value_]];
}

@dynamic id;

- (int64_t)idValue {
	NSNumber *result = [self id];
	return [result longLongValue];
}

- (void)setIdValue:(int64_t)value_ {
	[self setId:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveIdValue {
	NSNumber *result = [self primitiveId];
	return [result longLongValue];
}

- (void)setPrimitiveIdValue:(int64_t)value_ {
	[self setPrimitiveId:[NSNumber numberWithLongLong:value_]];
}

@dynamic imagePath;

@dynamic saved;

- (BOOL)savedValue {
	NSNumber *result = [self saved];
	return [result boolValue];
}

- (void)setSavedValue:(BOOL)value_ {
	[self setSaved:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveSavedValue {
	NSNumber *result = [self primitiveSaved];
	return [result boolValue];
}

- (void)setPrimitiveSavedValue:(BOOL)value_ {
	[self setPrimitiveSaved:[NSNumber numberWithBool:value_]];
}

@dynamic title;

@dynamic episodes;

- (NSMutableSet*)episodesSet {
	[self willAccessValueForKey:@"episodes"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"episodes"];

	[self didAccessValueForKey:@"episodes"];
	return result;
}

@end

