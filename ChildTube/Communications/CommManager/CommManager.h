//
//  CommManager.h
//  WeddingHelp
//
//  Created by MTG on 1/10/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerMessageTypes.h"

typedef void(^CompletionBlock)(NSURLResponse *response,
                               NSData *data, NSError *connectionError);


@interface CommManager : NSObject


-(void)sendObjectWithString:(NSString *)str sendType:(NSString *)sendType body:(NSData *)body completion:(CompletionBlock)callback;


@end
