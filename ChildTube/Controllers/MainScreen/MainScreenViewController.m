//
//  MainMessagesTableViewController.m
//  IAmInToo
//
//  Created by mindthegap on 11/28/14.
//  Copyright (c) 2014 mindthegap. All rights reserved.
//

#import "SharedHeaders.h"

#import "MainScreenViewController.h"

#import "Playlist.h"

#import "UpdateAdapter.h"

#import "PlaylistCollectionViewCell.h"


static NSString *PlaylistCollectionViewCellIdentifier = @"PlaylistCollectionViewCellIdentifier";



@interface MainScreenViewController ()


@property (weak, nonatomic) ChildTubeAppDelegate *delegate;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@property NSMutableArray *itemChanges;



@end

@implementation MainScreenViewController

@synthesize fetchedResultsController = _fetchedResultsController;

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    _fetchedResultsController = [Playlist MR_fetchAllSortedBy:@"title" ascending:YES withPredicate:[NSPredicate predicateWithFormat:@"saved == %d", YES] groupBy:nil delegate:self];
    NSError *error;
    if (![_fetchedResultsController performFetch:&error]) {
        // Update to handle the error appropriately.
        NSLog(@"Unresolved error while performing fetch of initial messages: %@, %@", error, [error userInfo]);
    }

    return _fetchedResultsController;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.delegate = (ChildTubeAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [Helper testInternetConnectionWithCompletion:nil failureBlock:^(id result) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[[[iToast makeText:@"Internet is down. Check your connection."] setGravity:iToastGravityCenter] setDuration:4000] show];
        });
    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[[self fetchedResultsController] fetchedObjects] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = nil;
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:PlaylistCollectionViewCellIdentifier forIndexPath:indexPath];
    
    [self configureCell:(PlaylistCollectionViewCell *)cell atIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(PlaylistCollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    if (row < [[[self fetchedResultsController] fetchedObjects] count]) {
        Playlist *playlist = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        
        [[cell titleLabel] setText:[playlist title]];
        [[cell playlistImageView] downloadImageWithPath:[playlist imagePath] placeholderImage:[UIImage imageNamed:@"default_playlist.png"]];
    }
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    self.itemChanges = [[NSMutableArray alloc] init];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    NSMutableDictionary *change = [[NSMutableDictionary alloc] init];
    change[@(type)] = @(sectionIndex);
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    NSMutableDictionary *change = [[NSMutableDictionary alloc] init];
    switch(type) {
        case NSFetchedResultsChangeInsert: {
            change[@(type)] = newIndexPath;
            break;
        }
        case NSFetchedResultsChangeDelete: {
            change[@(type)] = indexPath;
            break;
        }
        case NSFetchedResultsChangeUpdate: {
            change[@(type)] = indexPath;
            break;
        }
        case NSFetchedResultsChangeMove: {
            change[@(type)] = @[indexPath, newIndexPath];
            break;
        }
    }
    [self.itemChanges addObject:change];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    if (![self.itemChanges count]) return;
    
    [self.collectionView performBatchUpdates:^{
        for (NSDictionary *change in self.itemChanges) {
            [change enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                NSFetchedResultsChangeType type = [key unsignedIntegerValue];
                switch(type) {
                    case NSFetchedResultsChangeInsert:
                        [self.collectionView insertItemsAtIndexPaths:@[obj]];
                        break;
                    case NSFetchedResultsChangeDelete:
                        [self.collectionView deleteItemsAtIndexPaths:@[obj]];
                        break;
                    case NSFetchedResultsChangeUpdate:
                        [self.collectionView reloadItemsAtIndexPaths:@[obj]];
                        break;
                    case NSFetchedResultsChangeMove:
                        [self.collectionView moveItemAtIndexPath:obj[0] toIndexPath:obj[1]];
                        break;
                }
            }];
        }
    } completion:^(BOOL finished) {
        if (finished) {
            self.itemChanges = nil;
        }
    }];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
}

@end
