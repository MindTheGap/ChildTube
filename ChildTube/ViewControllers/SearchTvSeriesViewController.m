//
//  SearchTvSeriesViewController.m
//  ChildTube
//
//  Created by MTG on 5/3/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import "SearchTvSeriesViewController.h"

@interface SearchTvSeriesViewController ()

- (void)searchTvSeries;

@end

@implementation SearchTvSeriesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.delegate = (ChildTubeAppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.searchText) {
        [textField resignFirstResponder];
        [self searchTvSeries];
        return NO;
    }
    return YES;
}

- (void)searchTvSeries
{
    NSDictionary *object = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d", SearchPhrase], @"Type", [[self searchText] text], @"Text", nil];
    [[self.delegate commManager] sendObject:object completion:^(NSDictionary *json)
     {
         NSArray *allTvSeries = [json objectForKey:@"TvSeriesResults"];
         
         for (int i = 0; i < [allTvSeries count]; i++) {
             NSDictionary *tvSeriesDictionary = [allTvSeries objectAtIndex:i];
             
//             TvSeries *tvSeries = [[TvSeries alloc] init];
//             
             NSString *tvSeriesName = [tvSeriesDictionary objectForKey:@"Name"];
//             if ([tvSeriesName class] != [NSNull class])
//                 [tvSeries setName:tvSeriesName];
//             
             NSString *tvSeriesImagePath = [tvSeriesDictionary objectForKey:@"SeriesImagePath"];
//             if ([tvSeriesImagePath class] != [NSNull class])
//                 [tvSeries setSeriesImagePath:tvSeriesImagePath];
//             
//             [[self tvSeriesArray] addObject:tvSeries];
         }
         
//         dispatch_async(dispatch_get_main_queue(), ^{ [[self collectionView] reloadData]; });
     }];
}

@end
