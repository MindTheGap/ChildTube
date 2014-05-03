//
//  ChildTubeAppDelegate.h
//  ChildTube
//
//  Created by MTG on 4/6/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommManager.h"

@interface ChildTubeAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) CommManager *commManager;


@end
