//
//  CommManager.m
//  WeddingHelp
//
//  Created by MTG on 1/10/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import "CommManager.h"
#import "ServerMessageTypes.h"
#import <Foundation/NSJSONSerialization.h>

#define SERVER_HOST @"http://192.168.175.1:4297/"
#define SERVER_REST_HOST @"http://192.168.175.1:60086"


@implementation CommManager



- (void)sendObjectWithString:(NSString *)str sendType:(NSString *)sendType body:(NSData *)body completion:(CompletionBlock)callback
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", SERVER_REST_HOST, str]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    
    [request setHTTPMethod:sendType];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [body length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:body];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:callback];
}



@end
