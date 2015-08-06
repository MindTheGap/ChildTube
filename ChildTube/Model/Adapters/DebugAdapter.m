//
//  DebugAdapter.m
//  IAmInToo
//
//  Created by mtg on 5/30/15.
//  Copyright (c) 2015 mindthegap. All rights reserved.
//

#import "SharedHeaders.h"

#import "DebugAdapter.h"

@implementation DebugAdapter

#pragma mark - Singleton
+ (id)sharedObject {
    static DebugAdapter *sharedDM = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDM = [[self alloc] init];
    });
    return sharedDM;
}

- (id)init {
    if (self = [super init]) {
        
    }
    
    return self;
}

#pragma mark - Methods

- (void)truncateAllTablesInServer
{
    [Helper sendObjectWithString:@"register/truncateAll" sendType:@"GET" body:nil completion:^(NSDictionary *result) {
        [[[[iToast makeText:@"Data truncated on server!"] setGravity:iToastGravityCenter] setDuration:2000] show];
    } failureBlock:^(NSDictionary *result, NSError *connectionError) {
        [[[[iToast makeText:[NSString stringWithFormat:@"Error: %@", [connectionError localizedDescription]]] setGravity:iToastGravityCenter] setDuration:4000] show];
    }];
}



@end
