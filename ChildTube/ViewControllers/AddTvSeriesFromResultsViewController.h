//
//  AddTvSeriesFromResultsViewController.h
//  ChildTube
//
//  Created by MTG on 5/3/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainGridViewController.h"

@interface AddTvSeriesFromResultsViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) NSMutableArray *tvSeriesResultsArray;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;

@property (strong, nonatomic) MainGridViewController *mainGridViewController;

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath;

@end
