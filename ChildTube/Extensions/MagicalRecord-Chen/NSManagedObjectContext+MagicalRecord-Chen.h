//
//  NSManagedObjectContext+MagicalRecord.h
//  IAmInToo
//
//  Created by mtg on 5/29/15.
//  Copyright (c) 2015 mindthegap. All rights reserved.
//

#import "SharedHeaders.h"

#import <Foundation/Foundation.h>

@class NSManagedObjectContext;

@interface NSManagedObjectContext (MagicalRecord)

+ (void) MR_setDefaultContext:(NSManagedObjectContext *)moc;
+ (void) MR_setRootSavingContext:(NSManagedObjectContext *)context;

@end
