//
//  RegisterAdapter.m
//  IAmInToo
//
//  Created by mtg on 5/29/15.
//  Copyright (c) 2015 mindthegap. All rights reserved.
//

#import "SharedHeaders.h"

#import "RegisterAdapter.h"

#import "MyDetails.h"

@implementation RegisterAdapter

#pragma mark - Singleton
+ (id)sharedObject {
    static RegisterAdapter *sharedDM = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDM = [[self alloc] init];
    });
    return sharedDM;
}

- (id)init {
    if (self = [super init]) {
        
    }
    
    return self;
}

#pragma mark - Methods
- (void)registerUser:(NSString *)email completion:(IdBlock)completionBlock failure:(NoneBlock)failureBlock
{
//    NSAssert(completionBlock, @"completionBlock cannot be nil");
//    
//    NSDictionary *dic = [[NSDictionary alloc] initWithObjects:@[phoneNumber] forKeys:@[@"phoneNumber"]];
//    [Helper sendObjectWithString:[NSString stringWithFormat:@"register/registerPhoneNumber"] sendType:@"POST" bodyObj:dic completion:^(NSDictionary *result) {
//        EMessageTypeFromServer type = [[result objectForKey:@"Type"] intValue];
//        
//        if (type & RegisterSuccessfully || type & VerificationCodeSent || type & Ok)
//        {
//            NSString *userId = [result objectForKey:@"UserId"];
//            
//            if (completionBlock) {
//                completionBlock(userId);
//            }
//        }
//        else
//        {
//            if (failureBlock) {
//                failureBlock();
//            }
//        }
//    } failureBlock:^(NSDictionary *result, NSError *connectionError) {
//        if (failureBlock) {
//            failureBlock();
//        }
//    }];
}

@end
