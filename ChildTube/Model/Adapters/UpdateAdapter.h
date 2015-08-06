//
//  UpdateAdapter.h
//  IAmInToo
//
//  Created by mtg on 5/29/15.
//  Copyright (c) 2015 mindthegap. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface UpdateAdapter : NSObject

+ (id)sharedObject;



- (void)updateAllPlaylistsWithCompletion:(NoneBlock)completion failureBlock:(DictionaryAndErrorBlock)failureBlock;

@end
