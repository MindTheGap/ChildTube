//
//  AddTvSeriesFromResultsViewController.h
//  ChildTube
//
//  Created by MTG on 5/3/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddTvSeriesFromResultsViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) NSMutableArray *tvSeriesResultsArray;

@property (weak, nonatomic) IBOutlet UILabel *numSelectedLabel;

@end
