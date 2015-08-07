//
//  EpisodeDetailsViewController.h
//  ChildTube
//
//  Created by mtg on 8/6/15.
//  Copyright (c) 2015 MTG. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Playlist;

@interface EpisodeListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) Playlist *playlist;

@end
