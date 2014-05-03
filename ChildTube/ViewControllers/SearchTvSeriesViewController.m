//
//  SearchTvSeriesViewController.m
//  ChildTube
//
//  Created by MTG on 5/3/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import "SearchTvSeriesViewController.h"
#import "AddTvSeriesFromResultsViewController.h"
#import "DataEntities.h"

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
         NSArray *searchTvSeriesArray = [json objectForKey:@"TvSeriesResults"];
         NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
         
         for (int i = 0; i < [searchTvSeriesArray count]; i++) {
             NSDictionary *tvSeriesDictionary = [searchTvSeriesArray objectAtIndex:i];
             
             TvSeries *tvSeries = [[TvSeries alloc] init];
             
             NSString *tvSeriesName = [tvSeriesDictionary objectForKey:@"Name"];
             if ([tvSeriesName class] != [NSNull class])
                 [tvSeries setName:tvSeriesName];
             
             NSString *tvSeriesImagePath = [tvSeriesDictionary objectForKey:@"SeriesImagePath"];
             if ([tvSeriesImagePath class] != [NSNull class])
                 [tvSeries setSeriesImagePath:tvSeriesImagePath];
             
             [tvSeries setChecked:false];
             
             [mutableArray addObject:tvSeries];
         }
         
         self.addTvSeriesFromResultsArray = mutableArray;
         [self performSegueWithIdentifier:@"ToAddTvSeriesFromResultsSegue" sender:self];
     }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ToAddTvSeriesFromResultsSegue"])
    {
        AddTvSeriesFromResultsViewController *addTvSeriesFromResultsViewController = [segue destinationViewController];
        [addTvSeriesFromResultsViewController setTvSeriesResultsArray:[self addTvSeriesFromResultsArray]];
    }
}

@end
