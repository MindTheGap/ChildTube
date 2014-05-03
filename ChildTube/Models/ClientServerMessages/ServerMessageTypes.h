//
//  ServerMessageTypes.h
//  WeddingHelp
//
//  Created by MTG on 1/11/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerMessageTypes : NSObject

enum CommandType
{
    GetTvSeriesDetails,
    SearchPhrase
};

enum ResponseFromServer
{
    OK,
    Error
};

@end
