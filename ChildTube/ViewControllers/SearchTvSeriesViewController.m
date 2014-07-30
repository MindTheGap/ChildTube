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
#import "iToast.h"

@interface SearchTvSeriesViewController ()

- (void)searchTvSeries;
@property (strong, nonatomic) AddTvSeriesFromResultsViewController *addTvSeriesCollectionViewController;

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

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setToolbarHidden:NO animated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setToolbarHidden:YES animated:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.delegate = (ChildTubeAppDelegate *)[[UIApplication sharedApplication] delegate];
    self.addTvSeriesCollectionViewController = [[self.delegate iPhoneSB] instantiateViewControllerWithIdentifier:@"AddTvSeriesFromResultsIdentifier"];
    [self.addTvSeriesCollectionViewController setMainGridViewController:[self mainGridViewController]];
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
             
             NSString *name = [tvSeriesDictionary objectForKey:@"Name"];
             NSString *tvSeriesImagePath = [tvSeriesDictionary objectForKey:@"SeriesImagePath"];
             
             NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@",@"name", name];
             NSArray *filteredArray = [[[self mainGridViewController] tvSeriesArray] filteredArrayUsingPredicate:predicate];
             if (filteredArray.count > 0)
             {
                 NSLog(@"Main Grid View already contained tv series %@ so skipping", name);
                 continue;
             }
             
             TvSeries *tvSeries = [[TvSeries alloc] init];
             
             if ([name class] != [NSNull class])
                 [tvSeries setName:name];
             
             if ([tvSeriesImagePath class] != [NSNull class])
                 [tvSeries setSeriesImagePath:tvSeriesImagePath];
             
             [tvSeries setChecked:false];
             
             [mutableArray addObject:tvSeries];
         }
         
         if ([mutableArray count] > 0)
         {
             self.addTvSeriesFromResultsArray = mutableArray;
             if ([self addTvSeriesCollectionViewController])
             {
                 [[self addTvSeriesCollectionViewController] setTvSeriesResultsArray:[self addTvSeriesFromResultsArray]];
                 dispatch_async(dispatch_get_main_queue(), ^{
                     [[self navigationController] pushViewController:[self addTvSeriesCollectionViewController] animated:YES];
                 });
             }
         }
         else
         {
             NSLog(@"No Results");
             dispatch_async(dispatch_get_main_queue(), ^{
                 [[[[iToast makeText:NSLocalizedString(@"No Results", @"")]
                    setGravity:iToastGravityCenter] setDuration:2000] show];
             });


         }
     }];
}


@end
