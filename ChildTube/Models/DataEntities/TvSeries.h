//
//  Wedding.h
//  WeddingHelp
//
//  Created by MTG on 1/11/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TvSeries : UICollectionViewCell

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *seriesImagePath;
@property (strong, nonatomic) UIImage  *seriesImage;
@property (assign) BOOL checked;

@end
