//
//  InAppPurchaseMediator.m
//  IAmInToo
//
//  Created by mtg on 6/18/15.
//  Copyright (c) 2015 mindthegap. All rights reserved.
//

#import "SharedHeaders.h"

#import "InAppPurchaseMediator.h"

#import "InAppPurchaseAdapter.h"

#import "MyDetails.h"

@implementation InAppPurchaseMediator

#pragma mark - Singleton
+ (id)sharedObject {
    static InAppPurchaseMediator *sharedDM = nil;
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




#pragma mark - RMStoreReceiptVerificator

//- (void)verifyTransaction:(SKPaymentTransaction*)transaction
//                  success:(void (^)())successBlock
//                  failure:(void (^)(NSError *error))failureBlock
//{
//    NSLog(@"entered verifyTransaction:success:failure: on InAppPurchaseMediator");
//    NSURL *receiptUrl = [RMStore receiptURL];
//    if (!receiptUrl) {
//        [[RMStore defaultStore] refreshReceiptOnSuccess:^{
//            NSURL *receiptUrl = [RMStore receiptURL];
//            if (receiptUrl) {
//                [self verifyTranactionAux:transaction receiptUrl:receiptUrl success:successBlock failure:failureBlock];
//            } else {
//                NSLog(@"Can't get receipt URL (even after refresh) on refreshReceiptSuccess!");
//            }
//        } failure:^(NSError *error) {
//            NSLog(@"Can't get receipt URL (even after refresh) on refreshReceiptFailure with error: %@", [error localizedDescription]);
//        }];
//    } else {
//        [self verifyTranactionAux:transaction receiptUrl:receiptUrl success:successBlock failure:failureBlock];
//    }
//}
//
//- (void)verifyTranactionAux:(SKPaymentTransaction *)transaction receiptUrl:(NSURL *)receiptUrl success:(void (^)())successBlock failure:(void (^)(NSError *error))failureBlock
//{
//    NSLog(@"entered verifyTransactionAuc:receiptUrl:success:failure: on InAppPurchaseMediator");
//
//    [[InAppPurchaseAdapter sharedObject] purchaseWithTranscation:transaction productIdentifier:[transaction payment].productIdentifier receiptUrl:receiptUrl completion:^(id result) {
//        NSString *coinAmount = [result objectForKey:@"CoinAmount"];
//        if (coinAmount && [coinAmount class] != [NSNull class]) {
//            NSLog(@"Got a response for purchase with coinAmount (%d)!", [coinAmount intValue]);
//            [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
//                MyDetails *myDetails = [MyDetails MR_findFirstInContext:localContext];
//                
//                [[myDetails user] setCoinsValue:[coinAmount intValue]];
//            } completion:^(BOOL success, NSError *error) {
//                if (!success) {
//                    NSLog(@"Couldn't save in paymentQueue:updatedTransactions: with error: %@", [error localizedDescription]);
//                }
//                
//                successBlock();
//            }];
//        } else {
//            NSLog(@"Got a response for purchase without coinAmount!");
//            
//            successBlock();
//        }
//    } failureBlock:^(NSDictionary *result, NSError *connectionError) {
//        if (connectionError) {
//            [[[[iToast makeText:[NSString stringWithFormat:@"Couldn't get to server.\nconnection error: %@", [connectionError localizedDescription]]] setGravity:iToastGravityCenter] setDuration:5000] show];
//        } else {
//            [[[[iToast makeText:[NSString stringWithFormat:@"Server returned an error"]] setGravity:iToastGravityCenter] setDuration:5000] show];
//        }
//        
//        failureBlock([NSError errorWithDomain:@"IAmInToo" code:RMStoreErrorCodeUnableToCompleteVerification userInfo:nil]);
//    }];
//
//}
//





@end
