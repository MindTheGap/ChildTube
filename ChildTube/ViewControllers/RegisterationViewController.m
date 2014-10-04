//
//  RegisterationViewController.m
//  ChildTube
//
//  Created by MTG on 9/27/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import "RegisterationViewController.h"

@interface RegisterationViewController()


@end

@implementation RegisterationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = (ChildTubeAppDelegate *)[[UIApplication sharedApplication] delegate];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setToolbarHidden:YES animated:NO];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setToolbarHidden:YES animated:NO];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)signOut
{
    [[GPPSignIn sharedInstance] signOut];
}

// TODO: I need to make the option for the user to disconnect from Google+ services in this application
// so I will call this method from a UIButton and then send to server the disconnection details
- (void)disconnect
{
    [[GPPSignIn sharedInstance] disconnect];
}


@end
