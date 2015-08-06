//
//  RegisterAdapter.h
//  IAmInToo
//
//  Created by mtg on 5/29/15.
//  Copyright (c) 2015 mindthegap. All rights reserved.
//

#import <Foundation/Foundation.h>




@interface RegisterAdapter : NSObject

+ (id)sharedObject;




- (void)registerUser:(NSString *)email completion:(IdBlock)completionBlock failure:(NoneBlock)failureBlock;

@end
