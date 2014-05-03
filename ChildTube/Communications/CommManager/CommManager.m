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

#define SERVER_HOST @"http://192.168.94.1:4296/"


@implementation CommManager

- (void)sendCommandString:(NSString *)jsonString jsonData:(NSData *)jsonData completion:(CompletionBlock)callback
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:SERVER_HOST]];
    [request setValue:jsonString forHTTPHeaderField:@"json"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:jsonData];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSLog(@"Sending command message: %@", jsonString);
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if ([data length] > 0 && error == nil)
         {
             NSLog(@"Got response from server. calling callback");
             
             NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
             
             callback(json);
         }
         else if ([data length] == 0 && error == nil)
         {
             NSLog(@"data length is zero and no error");
         }
         else if (error != nil && error.code == NSURLErrorTimedOut)
         {
             NSLog(@"error code is timed out");
         }
         else if (error != nil)
         {
             NSLog(@"error is: %@" , [error localizedDescription]);
         }
     }];
}



- (void)sendObject:(id)object completion:(CompletionBlock)callback
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:0 // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    if (! jsonData) {
        NSLog(@"Trying to send command and got an error while trying to parse to json: %@", error);
        
        return;
    }
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [self sendCommandString:jsonString jsonData:jsonData completion:callback];
}



@end
