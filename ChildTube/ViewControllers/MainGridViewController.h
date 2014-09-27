//
//  MainGridCollectionViewController.h
//  ChildTube
//
//  Created by MTG on 4/6/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "ChildTubeAppDelegate.h"
#import "DBUtils.h"


@interface MainGridViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) NSMutableArray *tvSeriesArray;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) ChildTubeAppDelegate *delegate;

@property (strong, nonatomic) NSArray *resultFromAddSelectedViewController;

@property (strong, nonatomic) DBUtils *db;

@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *userEmail;



@end
