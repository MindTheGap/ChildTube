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

@property (strong, nonatomic) NSMutableArray *selectedItems;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self setSelectedItems:[[NSMutableArray alloc] init]];
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
    if ([tvSeriesObject seriesImage] != nil)
    {
        [imageView setImage:[tvSeriesObject seriesImage]];
    }
    else
    {
        NSLog(@"Fetching image from path: %@", [tvSeriesObject seriesImagePath]);
        [imageView setImageWithURL:[NSURL URLWithString:[tvSeriesObject seriesImagePath]]
                  placeholderImage:[UIImage imageNamed:@"anonymous.png"]];
    }
    
    [checkMark setCheckMarkStyle:SSCheckMarkStyleGrayedOut];
    [checkMark setChecked:[tvSeriesObject checked]];
    
    [label setText:[tvSeriesObject name]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Determine the selected items by using the indexPath
    TvSeries *tvSeries = [[self tvSeriesResultsArray] objectAtIndex:indexPath.row];
    // Add the selected item into the array
    [[self selectedItems] addObject:tvSeries];
    
    int currentNum = [[[self numSelectedLabel] text] intValue];
    [[self numSelectedLabel] setText:[NSString stringWithFormat:@"%d",++currentNum]];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TvSeries *tvSeries = [[self tvSeriesResultsArray] objectAtIndex:indexPath.row];
    [[self selectedItems] removeObject:tvSeries];
    
    int currentNum = [[[self numSelectedLabel] text] intValue];
    [[self numSelectedLabel] setText:[NSString stringWithFormat:@"%d",--currentNum]];
}

- (IBAction)addSelectedButtonClicked:(id)sender
{
    if ([[self selectedItems] count] > 0)
    {
        
    }
}

@end
