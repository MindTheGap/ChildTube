//
//  SearchForPlaylist.m
//  ChildTube
//
//  Created by mtg on 8/6/15.
//  Copyright (c) 2015 MTG. All rights reserved.
//

#import "SharedHeaders.h"

#import "SearchForPlaylistViewController.h"

#import "EpisodeListViewController.h"

@implementation SearchForPlaylistViewController

- (IBAction)searchTextFieldValueChanged:(id)sender
{
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue destinationViewController] class] == [EpisodeListViewController class]) {
        EpisodeListViewController *episodeListViewController = [segue destinationViewController];
//        NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems] firstObject];
//        Playlist *playlist = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        
//        [episodeListViewController setPlaylist:playlist];
    }
    
}


@end
