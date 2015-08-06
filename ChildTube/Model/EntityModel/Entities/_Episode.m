// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Episode.m instead.

#import "_Episode.h"

const struct EpisodeAttributes EpisodeAttributes = {
	.id = @"id",
	.number = @"number",
	.title = @"title",
	.urlPath = @"urlPath",
};

const struct EpisodeRelationships EpisodeRelationships = {
	.playlist = @"playlist",
};

@implementation EpisodeID
@end

@implementation _Episode

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Episode" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Episode";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Episode" inManagedObjectContext:moc_];
}

- (EpisodeID*)objectID {
	return (EpisodeID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"numberValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"number"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
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

@dynamic number;

- (int64_t)numberValue {
	NSNumber *result = [self number];
	return [result longLongValue];
}

- (void)setNumberValue:(int64_t)value_ {
	[self setNumber:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveNumberValue {
	NSNumber *result = [self primitiveNumber];
	return [result longLongValue];
}

- (void)setPrimitiveNumberValue:(int64_t)value_ {
	[self setPrimitiveNumber:[NSNumber numberWithLongLong:value_]];
}

@dynamic title;

@dynamic urlPath;

@dynamic playlist;

@end

