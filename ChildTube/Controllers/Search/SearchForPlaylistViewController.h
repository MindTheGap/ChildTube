//
//  SearchForPlaylist.h
//  ChildTube
//
//  Created by mtg on 8/6/15.
//  Copyright (c) 2015 MTG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchForPlaylistViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
