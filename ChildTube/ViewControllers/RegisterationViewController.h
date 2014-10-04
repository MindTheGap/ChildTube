//
//  RegisterationViewController.h
//  ChildTube
//
//  Created by MTG on 9/27/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GooglePlus/GooglePlus.h"
#import "../ChildTubeAppDelegate.h"


@class GPPSignInButton;

@interface RegisterationViewController : UIViewController

@property (retain, nonatomic) IBOutlet GPPSignInButton *signInButton;

@property (strong, nonatomic) ChildTubeAppDelegate *delegate;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *signInGoogleActivityIndicator;


@end
