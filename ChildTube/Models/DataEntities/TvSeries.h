//
//  Wedding.h
//  WeddingHelp
//
//  Created by MTG on 1/11/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface TvSeries : UICollectionViewCell

@property (assign, nonatomic) sqlite3_int64 ID;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *seriesImagePath;
@property (strong, nonatomic) UIImage  *seriesImage;
@property (strong, nonatomic) NSArray *episodes;
@property (assign) BOOL checked;

@end
