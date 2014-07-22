//
//  MainGridCollectionViewController.m
//  ChildTube
//
//  Created by MTG on 4/6/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import "MainGridViewController.h"
#import "UIImageView+WebCache.h"
#import "ServerMessageTypes.h"
#import "DataEntities.h"
#import "SearchTvSeriesViewController.h"
#import "VideoPlayerViewController.h"
#import "DataEntities.h"

@interface MainGridViewController ()

@property (strong, nonatomic) SearchTvSeriesViewController *searchViewController;

@end

@implementation MainGridViewController

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
    [self.navigationController setToolbarHidden:YES animated:NO];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [[self tvSeriesArray] addObjectsFromArray:[self resultFromAddSelectedViewController]];
    [[self collectionView] reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setToolbarHidden:YES animated:NO];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [[self navigationController] setToolbarHidden:YES];
    
    [self setTvSeriesArray:[[NSMutableArray alloc] init]];
    
    self.delegate = (ChildTubeAppDelegate *)[[UIApplication sharedApplication] delegate];
    self.searchViewController = [[self.delegate iPhoneSB] instantiateViewControllerWithIdentifier:@"searchTvSeriesViewControllerIdentifier"];
    [self.searchViewController setMainGridViewController:self];
    
    if ([[self tvSeriesArray] count] == 0)
    {
        NSDictionary *object = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%d", GetAllTvSeries], @"Type", nil];
        [[self.delegate commManager] sendObject:object completion:^(NSDictionary *json)
         {
             NSArray *allTvSeries = [json objectForKey:@"TvSeries"];
             
             for (int i = 0; i < [allTvSeries count]; i++) {
                 NSDictionary *tvSeriesDictionary = [allTvSeries objectAtIndex:i];
                 
                 TvSeries *tvSeries = [[TvSeries alloc] init];
                 
                 NSString *tvSeriesName = [tvSeriesDictionary objectForKey:@"Name"];
                 if ([tvSeriesName class] != [NSNull class])
                     [tvSeries setName:tvSeriesName];
                 
                 NSString *tvSeriesImagePath = [tvSeriesDictionary objectForKey:@"SeriesImagePath"];
                 if ([tvSeriesImagePath class] != [NSNull class])
                     [tvSeries setSeriesImagePath:tvSeriesImagePath];

                 NSArray *episodes = [tvSeriesDictionary objectForKey:@"Episodes"];
                 if ([episodes class] != [NSNull class])
                     [tvSeries setEpisodes:episodes];
                 
                 [[self tvSeriesArray] addObject:tvSeries];
             }
             
             dispatch_async(dispatch_get_main_queue(), ^{ [[self collectionView] reloadData]; });
         }];
    }
}

- (IBAction)plusButtonTouched:(id)sender
{
    [[self navigationController] pushViewController:[self searchViewController] animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[self tvSeriesArray] count];
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MainCategoryCell" forIndexPath:indexPath];
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:100];
    UILabel *label = (UILabel *)[cell viewWithTag:200];
    
    TvSeries *tvSeriesObject = [[self tvSeriesArray] objectAtIndex:[indexPath row]];
    if ([tvSeriesObject seriesImage] != nil)
    {
        [imageView setImage:[tvSeriesObject seriesImage]];
    }
    else
    {
//        NSLog(@"Fetching image from path: %@", [tvSeriesObject seriesImagePath]);
        [imageView setImageWithURL:[NSURL URLWithString:[tvSeriesObject seriesImagePath]]
                       placeholderImage:[UIImage imageNamed:@"anonymous.png"]];
    }
    
    [label setText:[tvSeriesObject name]];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController class] == [VideoPlayerViewController class])
    {
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
        
        TvSeries *tvSeriesObject = [[self tvSeriesArray] objectAtIndex:[indexPath row]];

        if ([tvSeriesObject episodes] != nil)
        {
            NSDictionary *episode = [[tvSeriesObject episodes] firstObject];
            if (episode == nil)
            {
                NSLog(@"No episodes for this tv series!");
            }
            else
            {
                VideoPlayerViewController *videoPlayerViewController = (VideoPlayerViewController *)segue.destinationViewController;
                [videoPlayerViewController setEpisode:[[Episode alloc] initWithDictionary:episode]];
                [videoPlayerViewController setTvSeries:tvSeriesObject];
            }
        }
        else
        {
            NSLog(@"episodes array is nil!");
        }
    }
}











@end
