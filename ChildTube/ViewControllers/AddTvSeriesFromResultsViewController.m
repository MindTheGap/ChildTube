//
//  AddTvSeriesFromResultsViewController.m
//  ChildTube
//
//  Created by MTG on 5/3/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import "AddTvSeriesFromResultsViewController.h"
#import "SSCheckMark.h"
#import "DataEntities.h"
#import "UIImageView+WebCache.h"

@interface AddTvSeriesFromResultsViewController ()

@property (strong, nonatomic) NSMutableArray *selectedTvSeries;
@property (assign, nonatomic) int numSelected;

@end

@implementation AddTvSeriesFromResultsViewController

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
    [self.navigationController setToolbarHidden:YES animated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self setSelectedTvSeries:[[NSMutableArray alloc] init]];
    [[self collectionView] setAllowsMultipleSelection:YES];
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
    return [[self tvSeriesResultsArray] count];
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AddToTvSeriesFromResultsCell" forIndexPath:indexPath];
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:100];
    UILabel *label = (UILabel *)[cell viewWithTag:200];
    SSCheckMark *checkMark = (SSCheckMark *)[cell viewWithTag:300];
    
    TvSeries *tvSeriesObject = [[self tvSeriesResultsArray] objectAtIndex:[indexPath row]];
    
    NSLog(@"got in to cell for item %d with checked: %d", [indexPath row], [tvSeriesObject checked]);
    
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
    
    [checkMark setCheckMarkStyle:SSCheckMarkStyleGrayedOut];
    [checkMark setChecked:[tvSeriesObject checked]];
    NSLog(@"Changed to cell for item %d with checked: %d", [indexPath row], [tvSeriesObject checked]);
    
    [label setText:[tvSeriesObject name]];
    
    if ([tvSeriesObject checked] == YES)
    {
        [cell setSelected:YES];
        [collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    }
    else
    {
        [cell setSelected:NO];
        [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Determine the selected items by using the indexPath
    TvSeries *tvSeries = [[self tvSeriesResultsArray] objectAtIndex:indexPath.row];
    // Add the selected item into the array
    [[self selectedTvSeries] addObject:tvSeries];
    [tvSeries setChecked:YES];
    
    [collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
    
    [self setNumSelected:[self numSelected] + 1];
    [self setTitle:[NSString stringWithFormat:@"Selected (%d)", [self numSelected]]];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TvSeries *tvSeries = [[self tvSeriesResultsArray] objectAtIndex:indexPath.row];
    [[self selectedTvSeries] removeObject:tvSeries];
    [tvSeries setChecked:NO];
    
    [collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
    
    [self setNumSelected:[self numSelected] - 1];
    if ([self numSelected] >= 1)
    {
        [self setTitle:[NSString stringWithFormat:@"Selected (%d)", [self numSelected]]];
    }
    else
    {
        [self setTitle:@"Adding"];
    }
}

- (IBAction)addSelectedButtonClicked:(id)sender
{
    if ([self numSelected] > 0)
    {
        [[self mainGridViewController] setResultFromAddSelectedViewController:[self selectedTvSeries]];
        [[self navigationController] popToRootViewControllerAnimated:YES];
    }
}

@end
