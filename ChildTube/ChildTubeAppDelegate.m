//
//  ChildTubeAppDelegate.m
//  ChildTube
//
//  Created by MTG on 4/6/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import "SharedHeaders.h"

#import "ChildTubeAppDelegate.h"

#import "RegisterAdapter.h"
#import "UpdateAdapter.h"

#import "InAppPurchaseMediator.h"

#import "UpdateAdapter.h"

#import "Playlist.h"


static NSString *kStoreName = @"EntityModel";


@interface ChildTubeAppDelegate()

@property BOOL coreDataStackSetupFinished;



@end

@implementation ChildTubeAppDelegate

- (void)setupCoreDataStack
{
    @synchronized(self) {
        if (self.mainQueueObjectContext) return;
        
        NSLog(@"Setup core data stack");
        NSPersistentStoreCoordinator *coordinator = [NSPersistentStoreCoordinator MR_coordinatorWithSqliteStoreNamed:kStoreName];
        [NSPersistentStoreCoordinator MR_setDefaultStoreCoordinator:coordinator];
        
        self.privateQueueSaveObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [self.privateQueueSaveObjectContext setPersistentStoreCoordinator:[NSPersistentStoreCoordinator MR_defaultStoreCoordinator]];
        [NSManagedObjectContext MR_setRootSavingContext:self.privateQueueSaveObjectContext];
        
        self.mainQueueObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [self.mainQueueObjectContext setParentContext:self.privateQueueSaveObjectContext];
        [NSManagedObjectContext MR_setDefaultContext:self.mainQueueObjectContext];
        NSLog(@"Setup core data stack complete successfully");
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self setupCoreDataStack];
    
    [RMStore defaultStore].receiptVerificator = [InAppPurchaseMediator sharedObject];

    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert
                                                                                         |UIUserNotificationTypeSound
                                                                                         |UIUserNotificationTypeBadge) categories:nil];
    [application registerUserNotificationSettings:settings];
    
    [self setIPhoneSB:[UIStoryboard storyboardWithName:@"Main" bundle:nil]];
    
    __block NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    __block BOOL normalRun = [defaults boolForKey:kNormalRunUserDefaults];
    
    [[UpdateAdapter sharedObject] updateAllPlaylistsWithCompletion:^{
        if (!normalRun) {
            NSArray *playlists = [Playlist MR_findAllSortedBy:@"hits" ascending:NO];
            NSArray *topPlaylists = [playlists subarrayWithRange:NSMakeRange(0, 3)];
            [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
                for (Playlist *playlist in topPlaylists) {
                    Playlist *localPlaylist = [playlist MR_inContext:localContext];
                    
                    [localPlaylist setSavedValue:YES];
                }
            } completion:^(BOOL contextDidSave, NSError *error) {
                if (error) {
                    NSLog(@"Couldn't save in application:didFinishLaunchingWithOptions: with error: %@", [error localizedDescription]);
                }
                
                [defaults setBool:YES forKey:kNormalRunUserDefaults];
            }];
        }
    } failureBlock:^(NSDictionary *result, NSError *connectionError) {
        [[[[iToast makeText:@"Couldn't reach server - Check your internet."] setGravity:iToastGravityCenter] setDuration:4000] show];
    }];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}





@end
