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
    [self setResultFromAddSelectedViewController:nil];
    [[self collectionView] reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setToolbarHidden:YES animated:NO];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (IBAction)signOutButtonClicked:(id)sender
{
    [[GPPSignIn sharedInstance] signOut];
    [[self delegate] hideHud];
    [[[self delegate] navigationController] popViewControllerAnimated:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [[self navigationController] setToolbarHidden:YES];
    
    [self setDb:[[DBUtils alloc] init]];
    
    self.delegate = (ChildTubeAppDelegate *)[[UIApplication sharedApplication] delegate];
    self.searchViewController = [[self.delegate iPhoneSB] instantiateViewControllerWithIdentifier:@"searchTvSeriesViewControllerIdentifier"];
    [self.searchViewController setMainGridViewController:self];
    
    NSMutableArray *mutableArray = [[[self db] getTvSeriesArray] mutableCopy];
    if ([mutableArray count] > 0)
    {
        self.tvSeriesArray = mutableArray;
        NSLog(@"Got %d tv series from local DB", [self.tvSeriesArray count]);
    }
    else
    {
        [self setTvSeriesArray:[[NSMutableArray alloc] init]];
    }

    if ([[self tvSeriesArray] count] == 0)
    {
        [[self.delegate commManager] sendObjectWithString:[NSString stringWithFormat:@"tvSeries/top?userId=%@",[[self delegate] userId]] sendType:@"GET" body:nil completion:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            if (data.length > 0 && connectionError == nil)
            {
                NSError *jsonParsingError;
                NSDictionary *allTvSeries = [NSJSONSerialization JSONObjectWithData:data
                                                                            options:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments
                                                                              error:&jsonParsingError];
                if (jsonParsingError)
                {
                    NSLog(@"Error parsing tv series json!");
                    return;
                }
                
                for (NSDictionary *tvSeriesDictionary in allTvSeries) {
                    
                    TvSeries *tvSeries = [[TvSeries alloc] init];
                    
                    NSString *tvSeriesName = [tvSeriesDictionary objectForKey:@"Name"];
                    if ([tvSeriesName class] != [NSNull class])
                        [tvSeries setName:tvSeriesName];
                    
                    NSString *tvSeriesImagePath = [tvSeriesDictionary objectForKey:@"SeriesImagePath"];
                    if ([tvSeriesImagePath class] != [NSNull class])
                        [tvSeries setSeriesImagePath:tvSeriesImagePath];
                    
                    NSArray *episodes = [tvSeriesDictionary objectForKey:@"Episodes"];
                    if ([episodes class] != [NSNull class])
                    {
                        NSMutableArray *episodesArray = [[NSMutableArray alloc] init];
                        for (NSDictionary *dic in episodes)
                        {
                            Episode *ep = [[Episode alloc] initWithDictionary:dic];
                            [episodesArray addObject:ep];
                        }
                        [tvSeries setEpisodes:episodesArray];
                    }
                    
                    NSString *tvSeriesId = [tvSeriesDictionary objectForKey:@"TvSeriesID"];
                    if ([tvSeriesId class] != [NSNull class])
                        [tvSeries setID:[tvSeriesId longLongValue]];
                    
                    
                    [[self tvSeriesArray] addObject:tvSeries];
                }
            }
            else
            {
                NSLog(@"ERROR: MainGridViewController got a bad response from the server");
                NSLog(@"data.length: %d", data.length);
                NSLog(@"connectionError: %@", connectionError);
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
    
    [[self db] close];
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
        [imageView setImageWithURL:[NSURL URLWithString:[tvSeriesObject seriesImagePath]]
                       placeholderImage:[UIImage imageNamed:@"anonymous.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                           
                           if ([[self db] isTvSeriesExists:[tvSeriesObject name]] == false)
                           {
                               NSLog(@"Adding tv series %@ to DB", [tvSeriesObject name]);
                               sqlite3_int64 id = [[self db] addTvSeriesWithName:[tvSeriesObject name] seriesId:[tvSeriesObject ID] imagePath:[tvSeriesObject seriesImagePath] image:image];
                               NSLog(@"new added tv series id: %lld", id);
                           }
                       }];
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
            Episode *episode = [[tvSeriesObject episodes] firstObject];
            if (episode == nil)
            {
                NSLog(@"No episodes for this tv series!");
            }
            else
            {
                VideoPlayerViewController *videoPlayerViewController = (VideoPlayerViewController *)segue.destinationViewController;
                [videoPlayerViewController setEpisode:episode];
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
