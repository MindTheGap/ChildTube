//
//  MainMessagesTableViewController.h
//  IAmInToo
//
//  Created by mindthegap on 11/28/14.
//  Copyright (c) 2014 mindthegap. All rights reserved.
//

#import "SharedHeaders.h"

#import <UIKit/UIKit.h>


@interface MainScreenViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;



@end
