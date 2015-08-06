//
//  DebugAdapter.h
//  IAmInToo
//
//  Created by mtg on 5/30/15.
//  Copyright (c) 2015 mindthegap. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DebugAdapter : NSObject

+ (id)sharedObject;


- (void)truncateAllTablesInServer;


@end
