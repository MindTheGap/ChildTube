// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Episode.h instead.

#import <CoreData/CoreData.h>

extern const struct EpisodeAttributes {
	__unsafe_unretained NSString *id;
	__unsafe_unretained NSString *number;
	__unsafe_unretained NSString *title;
	__unsafe_unretained NSString *urlPath;
} EpisodeAttributes;

extern const struct EpisodeRelationships {
	__unsafe_unretained NSString *playlist;
} EpisodeRelationships;

@class Playlist;

@interface EpisodeID : NSManagedObjectID {}
@end

@interface _Episode : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) EpisodeID* objectID;

@property (nonatomic, strong) NSNumber* id;

@property (atomic) int64_t idValue;
- (int64_t)idValue;
- (void)setIdValue:(int64_t)value_;

//- (BOOL)validateId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* number;

@property (atomic) int64_t numberValue;
- (int64_t)numberValue;
- (void)setNumberValue:(int64_t)value_;

//- (BOOL)validateNumber:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* title;

//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* urlPath;

//- (BOOL)validateUrlPath:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) Playlist *playlist;

//- (BOOL)validatePlaylist:(id*)value_ error:(NSError**)error_;

@end

@interface _Episode (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveId;
- (void)setPrimitiveId:(NSNumber*)value;

- (int64_t)primitiveIdValue;
- (void)setPrimitiveIdValue:(int64_t)value_;

- (NSNumber*)primitiveNumber;
- (void)setPrimitiveNumber:(NSNumber*)value;

- (int64_t)primitiveNumberValue;
- (void)setPrimitiveNumberValue:(int64_t)value_;

- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;

- (NSString*)primitiveUrlPath;
- (void)setPrimitiveUrlPath:(NSString*)value;

- (Playlist*)primitivePlaylist;
- (void)setPrimitivePlaylist:(Playlist*)value;

@end
