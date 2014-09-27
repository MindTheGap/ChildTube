//
//  RegisterationViewController.h
//  ChildTube
//
//  Created by MTG on 9/27/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GooglePlus/GooglePlus.h"
#import "MainGridViewController.h"

@class GPPSignInButton;

@interface RegisterationViewController : UIViewController <GPPSignInDelegate>

@property (retain, nonatomic) IBOutlet GPPSignInButton *signInButton;

@property (strong, nonatomic) MainGridViewController *mainGridViewController;

@end
