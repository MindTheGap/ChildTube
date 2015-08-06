//
//  IAPAppleAdapter.m
//  IAmInToo
//
//  Created by mtg on 6/13/15.
//  Copyright (c) 2015 mindthegap. All rights reserved.
//

#import "SharedHeaders.h"

#import "InAppPurchaseAdapter.h"

#import "MyDetails.h"

@interface InAppPurchaseAdapter()



@end

@implementation InAppPurchaseAdapter

#pragma mark - Singleton
+ (id)sharedObject {
    static InAppPurchaseAdapter *sharedDM = nil;
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
//- (void)purchaseWithTranscation:(SKPaymentTransaction *)paymentTransaction productIdentifier:(NSString *)productIdentifier receiptUrl:(NSURL *)receiptUrl completion:(IdBlock)completionBlock failureBlock:(DictionaryAndErrorBlock)failureBlock
//{
//    NSLog(@"entered purchaseWithTranscation on InAppPurchaseAdapter");
//
//    MyDetails *myDetails = [MyDetails MR_findFirst];
//    NSAssert(myDetails, @"myDetails cannot be nil. Something is wrong...");
//
//    NSData *receiptData = [NSData dataWithContentsOfURL:receiptUrl];
//    if (!receiptData) {
//        NSLog(@"No local receipt -- handle the error");
//        return;
//    }
//    
//    NSString *receiptDataStr = [receiptData base64EncodedStringWithOptions:0];
//    
//    NSDictionary *dic = [[NSDictionary alloc] initWithObjects:@[productIdentifier,[paymentTransaction transactionIdentifier],receiptDataStr] forKeys:@[@"productId",@"transcationId",@"receiptData"]];
//    [Helper sendObjectWithString:[NSString stringWithFormat:@"iap/purchase?userId=%lld",
//                                  [[myDetails user] idValue],
//                                  nil, nil] sendType:@"POST" bodyObj:dic completion:^(NSDictionary *result) {
//        if (completionBlock) {
//            completionBlock(result);
//        }
//    } failureBlock:^(NSDictionary *result, NSError *connectionError) {
//        if (failureBlock) {
//            failureBlock(result, connectionError);
//        }
//    }];
//}
//
//- (void)getAllProductsWithCompletion:(IdBlock)completionBlock failureBlock:(DictionaryAndErrorBlock)failureBlock
//{
//    MyDetails *myDetails = [MyDetails MR_findFirst];
//    NSAssert(myDetails, @"myDetails cannot be nil. Something is wrong...");
//    
//    NSDictionary *dic = [[NSDictionary alloc] init];
//    [Helper sendObjectWithString:[NSString stringWithFormat:@"iap/getPurchases?userId=%lld",
//                                  [[myDetails user] idValue],
//                                  nil, nil] sendType:@"POST" bodyObj:dic completion:^(NSDictionary *result) {
//        
//        NSArray *objects = [result objectForKey:@"MultipleMessages"];
//        
//        completionBlock(objects);
//    } failureBlock:^(NSDictionary *result, NSError *connectionError) {
//        if (failureBlock) {
//            failureBlock(result, connectionError);
//        }
//    }];
//}
//





@end
