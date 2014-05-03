//
//  MainGridCollectionViewController.m
//  ChildTube
//
//  Created by MTG on 4/6/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import "MainGridCollectionViewController.h"
#import "MainCollectionViewCellObject.h"
#import "UIImageView+WebCache.h"


@interface MainGridCollectionViewController ()

@end

@implementation MainGridCollectionViewController

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
    
    [self setMainArray:[[NSMutableArray alloc] init]];
    MainCollectionViewCellObject *cellObject = [[MainCollectionViewCellObject alloc] init];
    [cellObject setImagePath:@"http://static.comicvine.com/uploads/original/11111/111111855/3130619-spongebob-spongebob-squarepants-33210738-2284-2140.jpg"];
    [cellObject setText:@"SpongeBob"];
    [[self mainArray] addObject:cellObject];
    
    MainCollectionViewCellObject *cellObject2 = [[MainCollectionViewCellObject alloc] init];
    [cellObject2 setImagePath:@"http://www.cartoonito.co.uk/sites/www.cartoonito.co.uk/files/imagecache/activity_print_preview/fireman-sam-number-matching.jpg"];
    [cellObject2 setText:@"Sam The Fireman"];
    [[self mainArray] addObject:cellObject2];

    MainCollectionViewCellObject *cellObject3 = [[MainCollectionViewCellObject alloc] init];
    [cellObject3 setImagePath:@"http://img2.wikia.nocookie.net/__cb20130517055944/doratheexplorer/images/e/ef/Dora_Marquez.jpg"];
    [cellObject3 setText:@"Dora"];
    [[self mainArray] addObject:cellObject3];

    
    MainCollectionViewCellObject *cellObject4 = [[MainCollectionViewCellObject alloc] init];
    [cellObject4 setImagePath:@""];
    [cellObject4 setText:@"SpongeBob"];
    [[self mainArray] addObject:cellObject4];

    
    MainCollectionViewCellObject *cellObject5 = [[MainCollectionViewCellObject alloc] init];
    [cellObject5 setImagePath:@"http:///3130619-spongebob-spongebob-squarepants-33210738-2284-2140.jpg"];
    [cellObject5 setText:@"SpongeBob"];
    [[self mainArray] addObject:cellObject5];

    
    MainCollectionViewCellObject *cellObject6 = [[MainCollectionViewCellObject alloc] init];
    [cellObject6 setImagePath:@"http://3130619-spongebob-spongebob-squarepants-33210738-2284-2140.jpg"];
    [cellObject6 setText:@"SpongeBob"];
    [[self mainArray] addObject:cellObject6];

    
    MainCollectionViewCellObject *cellObject7 = [[MainCollectionViewCellObject alloc] init];
    [cellObject7 setImagePath:@"http://img2.wikia.nocookie.net/__cb20130517055944/doratheexplorer/images/e/ef/Dora_Marquez.jpg"];
    [cellObject7 setText:@"Dora"];
    [[self mainArray] addObject:cellObject7];

    
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
    return [[self mainArray] count];
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MainCategoryCell" forIndexPath:indexPath];
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:100];
    UILabel *label = (UILabel *)[cell viewWithTag:200];
    
    MainCollectionViewCellObject *cellObject = [[self mainArray] objectAtIndex:[indexPath row]];
    if ([cellObject image] != nil)
    {
        [imageView setImage:[cellObject image]];
    }
    else
    {
        [imageView setImageWithURL:[NSURL URLWithString:[cellObject imagePath]]
                       placeholderImage:[UIImage imageNamed:@"anonymous.png"]];
    }
    
    [label setText:[cellObject text]];
    
    return cell;
}













@end
