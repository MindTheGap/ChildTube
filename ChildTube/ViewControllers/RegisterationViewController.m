//
//  RegisterationViewController.m
//  ChildTube
//
//  Created by MTG on 9/27/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import "RegisterationViewController.h"
#import <GoogleOpenSource/GoogleOpenSource.h>
#import <GooglePlus/GooglePlus.h>


@implementation RegisterationViewController

static NSString * const kClientId = @"320066392243-egpg9sc1el7i3trnhlea3v64diefrses.apps.googleusercontent.com";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GPPSignIn *signIn = [GPPSignIn sharedInstance];
    signIn.shouldFetchGooglePlusUser = YES;
    signIn.shouldFetchGoogleUserEmail = YES;  // Uncomment to get the user's email
    
    // You previously set kClientId in the "Initialize the Google+ client" step
    signIn.clientID = kClientId;
    
    // Uncomment one of these two statements for the scope you chose in the previous step
    //signIn.scopes = @[ kGTLAuthScopePlusLogin ];  // "https://www.googleapis.com/auth/plus.login" scope
    signIn.scopes = @[ @"profile" ];            // "profile" scope
    
    // Optional: declare signIn.actions, see "app activities"
    signIn.delegate = self;
    
    [self setMainGridViewController:[[MainGridViewController alloc] init]];
    
    
    [signIn trySilentAuthentication];
}

- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth
                   error: (NSError *) error
{
    NSLog(@"Received error %@ and auth object %@",error, auth);
    if (error) {
        // Do some error handling here.
    } else {
        [self refreshInterfaceBasedOnSignIn];
    }
}

- (void)presentSignInViewController:(UIViewController *)viewController
{
    // This is an example of how you can implement it if your app is navigation-based.
    [[self navigationController] pushViewController:viewController animated:YES];
}

-(void)refreshInterfaceBasedOnSignIn
{
    if ([[GPPSignIn sharedInstance] authentication]) {
        // The user is signed in.
        [[self mainGridViewController] setUserId:[[GPPSignIn sharedInstance] userID]];
        [[self mainGridViewController] setUserEmail:[[GPPSignIn sharedInstance] userEmail]];
        [[self navigationController] pushViewController:[self mainGridViewController] animated:YES];
        //self.signInButton.hidden = YES;
        // Perform other actions here, such as showing a sign-out button
    } else {
        //self.signInButton.hidden = NO;
        // Perform other actions here
    }
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

- (void)didDisconnectWithError:(NSError *)error
{
    if (error) {
        NSLog(@"Received error %@", error);
    } else {
        // The user is signed out and disconnected.
        // Clean up user data as specified by the Google+ terms.
    }
}

@end
