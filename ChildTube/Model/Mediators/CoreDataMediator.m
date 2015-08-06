//
//  CoreDataMediator.m
//  IAmInToo
//
//  Created by mtg on 5/29/15.
//  Copyright (c) 2015 mindthegap. All rights reserved.
//

#import "SharedHeaders.h"

#import "CoreDataMediator.h"

#import "MyDetails.h"
#import "Episode.h"
#import "Playlist.h"

@implementation CoreDataMediator

#pragma mark - Singleton
+ (id)sharedObject {
    static CoreDataMediator *sharedDM = nil;
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
- (void)truncateAllData
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:NO forKey:kNormalRunUserDefaults];
    
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        [MyDetails MR_truncateAllInContext:localContext];
        [Episode MR_truncateAllInContext:localContext];
        [Playlist MR_truncateAllInContext:localContext];
    }];
}


@end
