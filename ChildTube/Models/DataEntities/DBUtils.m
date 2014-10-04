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

@property (strong, nonatomic) NSString *filePath;

@end

@implementation DBUtils

- (void)deleteDb:(NSString *)databasePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    BOOL success = [fileManager removeItemAtPath:databasePath error:&error];
    if (success) {
        NSLog(@"Removed the DB");
    }
    else
    {
        NSLog(@"Could not delete file -:%@ ",[error localizedDescription]);
    }
}

- (DBUtils *)init
{
    // Get the documents directory
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = dirPaths[0];
    
    // Build the path to the database file
    self.filePath = [[NSString alloc]
                               initWithString: [docsDir stringByAppendingPathComponent:
                                                @"mainDB.db"]];
    [self setMainDB:[FMDatabase databaseWithPath:self.filePath]];
    
    [self deleteDb:self.filePath];
    
    if ([[self mainDB] open])
    {
        [self createTables];
    }
    else
    {
        NSLog(@"Couldn't open the DB file!");
    }
    
    return self;
}

- (void)createTables
{
    if ([[self mainDB] executeUpdate:
     @"CREATE TABLE IF NOT EXISTS TvSeries "
     "("
     "ID INTEGER PRIMARY KEY, "
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
     "ID INTEGER PRIMARY KEY, "
     "EpisodeNumber INTEGER, "
     "SeriesNumber INTEGER, "
     "UrlPath TEXT, "
     "TvSeriesID INTEGER, "
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

- (sqlite3_int64)addTvSeriesWithName:(NSString *)tvSeriesName seriesId:(sqlite3_int64)seriesId imagePath:(NSString *)imagePath image:(UIImage *)image
{
    if (tvSeriesName != nil && imagePath != nil && image != nil)
    {
        [[self mainDB] beginTransaction];
        if ([[self mainDB] executeUpdate:@"INSERT INTO TvSeries (ID, Name, SeriesImagePath, SeriesImage) VALUES (?,?,?,?)" withArgumentsInArray:@[[[NSNumber alloc] initWithLongLong:seriesId], tvSeriesName, imagePath, image]] == false)
        {
            NSLog(@"Couldn't add tv series with name %@. error message: %@", tvSeriesName, [[self mainDB] lastErrorMessage]);
            return -1;
        }
        [[self mainDB] commit];
        
        sqlite3_int64 newId = [[self mainDB] lastInsertRowId];
        NSLog(@"newId: %lld", newId);
        return newId;
    }
    else
    {
        NSLog(@"Some property of tv series was nil");
    }
    
    return -1;
}

- (sqlite3_int64)addEpisode:(int)episodeNumber episodeId:(NSNumber *)episodeId seriesNumber:(int)seriesNumber urlPath:(NSString *)urlPath tvSeriesID:(sqlite3_int64)tvSeriesID
{
    if ([[self mainDB] executeUpdate:@"INSERT INTO Episode (ID, EpisodeNumber, SeriesNumber, UrlPath, TvSeriesID) VALUES (?, ?, ?, ?)" withArgumentsInArray:@[episodeId, [[NSNumber alloc] initWithInt:episodeNumber], [[NSNumber alloc] initWithInt:seriesNumber], urlPath, [[NSNumber alloc] initWithLongLong:tvSeriesID]]] == false)
    {
        NSLog(@"Couldn't add episode number %d. error message: %@", episodeNumber, [[self mainDB] lastErrorMessage]);
        return -1;
    }

    
    return [[self mainDB] lastInsertRowId];
}








@end
