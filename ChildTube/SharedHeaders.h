//
//  SharedHeaders.h
//  IAmInToo
//
//  Created by mtg on 5/29/15.
//  Copyright (c) 2015 mindthegap. All rights reserved.
//

// forward declarations
@class NSArray;
@class NSError;
@class NSDictionary;

// callback definitions
typedef void(^ArrayBlock)(NSArray *array);
typedef void(^IdBlock)(id result);
typedef void(^ErrorBlock)(NSError *error);
typedef void(^NoneBlock)();
typedef void(^DictionaryBlock)(NSDictionary *result);
typedef void(^DictionaryAndErrorBlock)(NSDictionary *result, NSError *connectionError);

// imports
#import <Foundation/Foundation.h>

#import "Helper.h"
#import "ChildTubeAppDelegate.h"
#import "NSManagedObjectContext+MagicalRecord-Chen.h"
#import "MessageTypeFromServerEnum.h"

#import "RMStore.h"
#import "iToast.h"
#import "UIImageView+WebCache.h"
#import "MRProgress.h"
#import <MagicalRecord/MagicalRecord.h>
#import "UIImageView+UCZProgressView.h"
