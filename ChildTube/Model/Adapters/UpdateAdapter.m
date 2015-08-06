//
//  UpdateAdapter.m
//  IAmInToo
//
//  Created by mtg on 5/29/15.
//  Copyright (c) 2015 mindthegap. All rights reserved.
//

#import "SharedHeaders.h"

#import "UpdateAdapter.h"

#import "RegisterAdapter.h"

#import "CoreDataMediator.h"

#import "MyDetails.h"
#import "Playlist.h"
#import "Episode.h"

@interface UpdateAdapter()

@property BOOL isUpdating;

@end

@implementation UpdateAdapter

#pragma mark - Singleton
+ (id)sharedObject {
    static UpdateAdapter *sharedDM = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDM = [[self alloc] init];
    });
    return sharedDM;
}

- (id)init {
    if (self = [super init]) {
        
    }
    
    return self;
}

#pragma mark - Methods

- (void)updateAllPlaylistsWithCompletion:(NoneBlock)completion failureBlock:(DictionaryAndErrorBlock)failureBlock
{
    @synchronized(self) {
        if (self.isUpdating) return;
        
        self.isUpdating = YES;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];

    [Helper sendObjectWithString:[NSString stringWithFormat:@"update/getAllPlaylists"] sendType:@"POST" bodyObj:dic completion:^(NSDictionary *result) {
        [self getAllPlaylistsWithCompletionHandler:result completion:completion];
        
        @synchronized(self) {
            self.isUpdating = NO;
        }
    } failureBlock:^(NSDictionary *result, NSError *connectionError) {
        if (failureBlock) {
            failureBlock(result, connectionError);
        }
        
        @synchronized(self) {
            self.isUpdating = NO;
        }
    }];
}

#pragma mark - Private Handlers


- (void)getAllPlaylistsWithCompletionHandler:(NSDictionary *)result completion:(NoneBlock)completionBlock
{
    NSArray *playlists = [result objectForKey:@"Playlists"];
    if (![playlists count]) return;
    
    NSLog(@"Found %lu playlists", (unsigned long)[playlists count]);
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        for (NSDictionary *playlistDictionary in playlists)
        {
            int64_t playlistId = [[playlistDictionary objectForKey:@"Id"] longValue];
            NSArray *episodesArray = [playlistDictionary objectForKey:@"Episodes"];
            Playlist *playlist = [Playlist MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"id = %lld" argumentArray:@[@(playlistId)]] inContext:localContext];
            
            if (!playlist) playlist = [Playlist MR_createEntityInContext:localContext];
            
            [playlist updateWithDictionary:playlistDictionary inContext:localContext];
            [playlist addOrUpdateEpisodes:episodesArray inContext:localContext];
        }
    } completion:^(BOOL success, NSError *error) {
        if (!success) {
            if (error) {
                NSLog(@"couldn't save in getAllPlaylistsWithCompletionHandler with error: %@", [error localizedDescription]);
            }
        }
        
        if (completionBlock) {
            completionBlock();
        }
    }];
}

@end
