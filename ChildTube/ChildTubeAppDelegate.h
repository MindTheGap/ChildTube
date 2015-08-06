//
//  ChildTubeAppDelegate.h
//  ChildTube
//
//  Created by MTG on 4/6/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *kNormalRunUserDefaults = @"ChildTubeNormalRun";


@interface ChildTubeAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UIStoryboard *iPhoneSB;

@property (strong, nonatomic) NSManagedObjectContext *privateQueueSaveObjectContext;
@property (strong, nonatomic) NSManagedObjectContext *mainQueueObjectContext;



@end
