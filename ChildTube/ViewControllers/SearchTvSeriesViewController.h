//
//  SearchTvSeriesViewController.h
//  ChildTube
//
//  Created by MTG on 5/3/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChildTubeAppDelegate.h"

@interface SearchTvSeriesViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *searchText;

@property (strong, nonatomic) ChildTubeAppDelegate *delegate;


@end
