//
//  DBUtils.m
//  ChildTube
//
//  Created by MTG on 8/7/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import "DBUtils.h"
#import "FMDatabase.h"
#import "TvSeries.h"

@interface DBUtils()

@property (nonatomic) FMDatabase *mainDB;

@end

@implementation DBUtils

- (DBUtils *)init
{
    // Get the documents directory
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = dirPaths[0];
    
    // Build the path to the database file
    NSString *databasePath = [[NSString alloc]
                               initWithString: [docsDir stringByAppendingPathComponent:
                                                @"mainDB.db"]];
    
    [self setMainDB:[FMDatabase databaseWithPath:databasePath]];
    if ([[self mainDB] open] == false)
    {
        NSLog(@"Couldn't open the DB file!");
    }
    else
    {
        [self createTables];
    }
    
    return self;
}

- (void)createTables
{
    if ([[self mainDB] executeUpdate:
     @"CREATE TABLE IF NOT EXISTS TvSeries "
     "("
     "ID INTEGER PRIMARY KEY AUTOINCREMENT, "
     "Name TEXT, "
     "SeriesImagePath TEXT, "
     "SeriesImage BLOB"
     ");"] == false)
    {
        NSLog(@"Couldn't add table TvSeries. error message: %@", [[self mainDB] lastErrorMessage]);
    }
    
    if ([[self mainDB] executeUpdate:
     @"CREATE TABLE IF NOT EXISTS Episode "
     "("
     "ID INTEGER PRIMARY KEY AUTOINCREMENT, "
     "EpisodeNumber INTEGER, "
     "SeriesNumber INTEGER, "
     "UrlPath TEXT, "
     "FOREIGN KEY (TvSeriesID) REFERENCES TvSeries (ID) "
     ");"] == false)
    {
        NSLog(@"Couldn't add table Episode. error message: %@", [[self mainDB] lastErrorMessage]);
    }
}

- (void)close
{
    [[self mainDB] close];
}

- (NSArray *)getTvSeriesArray
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    FMResultSet *s = [[self mainDB] executeQuery:@"SELECT * FROM TvSeries"];
    while ([s next])
    {
        TvSeries *tvSeries = [[TvSeries alloc] init];
        [tvSeries setName:[s stringForColumn:@"Name"]];
        [tvSeries setSeriesImagePath:[s stringForColumn:@"SeriesImagePath"]];

        [arr addObject:tvSeries];
    }
    
    return arr;
}

- (BOOL)isTvSeriesExists:(NSString *)tvSeriesName
{
    FMResultSet *s = [[self mainDB] executeQueryWithFormat:@"SELECT * FROM TvSeries WHERE Name=%@", tvSeriesName];
    if ([s next]) {
        return true;
    }
    
    return false;
}

- (sqlite3_int64)addTvSeriesWithName:(NSString *)tvSeriesName imagePath:(NSString *)imagePath image:(UIImage *)image
{
    if ([[self mainDB] executeUpdateWithFormat:@"INSERT INTO TvSeries VALUES (%@,%@,%@)", tvSeriesName, imagePath, image] == false)
    {
        NSLog(@"Couldn't add tv series with name %@. error message: %@", tvSeriesName, [[self mainDB] lastErrorMessage]);
        return -1;
    }
    
    return [[self mainDB] lastInsertRowId];
}

- (sqlite3_int64)addEpisode:(int)episodeNumber seriesNumber:(int)seriesNumber urlPath:(NSString *)urlPath tvSeriesID:(sqlite3_int64)tvSeriesID
{
    if ([[self mainDB] executeUpdateWithFormat:@"INSERT INTO Episode VALUES (%d,%d,%@,%lld)", episodeNumber, seriesNumber, urlPath, tvSeriesID] == false)
    {
        NSLog(@"Couldn't add episode number %d. error message: %@", episodeNumber, [[self mainDB] lastErrorMessage]);
        return -1;
    }
    
    return [[self mainDB] lastInsertRowId];
}








@end
