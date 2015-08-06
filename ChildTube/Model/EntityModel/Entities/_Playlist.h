// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Playlist.h instead.

#import <CoreData/CoreData.h>

extern const struct PlaylistAttributes {
	__unsafe_unretained NSString *hits;
	__unsafe_unretained NSString *id;
	__unsafe_unretained NSString *imagePath;
	__unsafe_unretained NSString *saved;
	__unsafe_unretained NSString *title;
} PlaylistAttributes;

extern const struct PlaylistRelationships {
	__unsafe_unretained NSString *episodes;
} PlaylistRelationships;

@class Episode;

@interface PlaylistID : NSManagedObjectID {}
@end

@interface _Playlist : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) PlaylistID* objectID;

@property (nonatomic, strong) NSNumber* hits;

@property (atomic) int64_t hitsValue;
- (int64_t)hitsValue;
- (void)setHitsValue:(int64_t)value_;

//- (BOOL)validateHits:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* id;

@property (atomic) int64_t idValue;
- (int64_t)idValue;
- (void)setIdValue:(int64_t)value_;

//- (BOOL)validateId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* imagePath;

//- (BOOL)validateImagePath:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* saved;

@property (atomic) BOOL savedValue;
- (BOOL)savedValue;
- (void)setSavedValue:(BOOL)value_;

//- (BOOL)validateSaved:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* title;

//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *episodes;

- (NSMutableSet*)episodesSet;

@end

@interface _Playlist (EpisodesCoreDataGeneratedAccessors)
- (void)addEpisodes:(NSSet*)value_;
- (void)removeEpisodes:(NSSet*)value_;
- (void)addEpisodesObject:(Episode*)value_;
- (void)removeEpisodesObject:(Episode*)value_;

@end

@interface _Playlist (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveHits;
- (void)setPrimitiveHits:(NSNumber*)value;

- (int64_t)primitiveHitsValue;
- (void)setPrimitiveHitsValue:(int64_t)value_;

- (NSNumber*)primitiveId;
- (void)setPrimitiveId:(NSNumber*)value;

- (int64_t)primitiveIdValue;
- (void)setPrimitiveIdValue:(int64_t)value_;

- (NSString*)primitiveImagePath;
- (void)setPrimitiveImagePath:(NSString*)value;

- (NSNumber*)primitiveSaved;
- (void)setPrimitiveSaved:(NSNumber*)value;

- (BOOL)primitiveSavedValue;
- (void)setPrimitiveSavedValue:(BOOL)value_;

- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;

- (NSMutableSet*)primitiveEpisodes;
- (void)setPrimitiveEpisodes:(NSMutableSet*)value;

@end
