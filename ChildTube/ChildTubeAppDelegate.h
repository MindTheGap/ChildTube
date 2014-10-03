//
//  ChildTubeAppDelegate.h
//  ChildTube
//
//  Created by MTG on 4/6/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommManager.h"
#import <GoogleOpenSource/GoogleOpenSource.h>
#import <GooglePlus/GooglePlus.h>


@interface ChildTubeAppDelegate : UIResponder <UIApplicationDelegate,GPPSignInDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) CommManager *commManager;

@property (strong, nonatomic) UIStoryboard *iPhoneSB;

@property (strong, nonatomic) NSString *userId;

@property (strong, nonatomic) NSString *userEmail;

@property (strong, nonatomic) UINavigationController *navigationController;





@end
