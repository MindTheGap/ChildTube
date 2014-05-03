//
//  CommManager.h
//  WeddingHelp
//
//  Created by MTG on 1/10/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerMessageTypes.h"

typedef void(^CompletionBlock)(NSDictionary *);

@interface CommManager : NSObject


- (void)sendObject:(id)object completion:(CompletionBlock)callback;



@end
