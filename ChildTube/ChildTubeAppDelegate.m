//
//  ChildTubeAppDelegate.m
//  ChildTube
//
//  Created by MTG on 4/6/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import "ChildTubeAppDelegate.h"
#import <GooglePlus/GooglePlus.h>
#import <GoogleOpenSource/GoogleOpenSource.h>
#import "MainGridViewController.h"
#import "RegisterationViewController.h"
#import "MBProgressHUD.h"


@interface ChildTubeAppDelegate()

@property (strong, nonatomic) MainGridViewController *mainGridViewController;

@property (strong, nonatomic) RegisterationViewController *registerationViewController;

@property (strong, nonatomic) MBProgressHUD* hud;


@end

@implementation ChildTubeAppDelegate

static NSString * const kClientId = @"320066392243-egpg9sc1el7i3trnhlea3v64diefrses.apps.googleusercontent.com";

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.commManager = [[CommManager alloc] init];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self setIPhoneSB:[UIStoryboard storyboardWithName:@"Storyboard_iPhone"
                                                  bundle:nil]];
    
    self.mainGridViewController = [[self iPhoneSB] instantiateViewControllerWithIdentifier:@"MainGridViewControllerIdentifier"];
    [self setRegisterationViewController:[[self iPhoneSB] instantiateViewControllerWithIdentifier:@"RegistrationViewControllerStoryboardId"]];
    
    
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:self.registerationViewController];
    
    self.window.rootViewController = self.navigationController;
    
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
    
    
    BOOL result = [signIn trySilentAuthentication];
    NSLog(@"result: %d", result);
    if (result == YES)
    {
        [self showHud];
    }
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)showHud
{
    NSLog(@"showHud");
    if (self.hud != nil)
    {
        [self.hud hide:NO];
    }
    else
    {
        self.hud = [MBProgressHUD showHUDAddedTo:[self.registerationViewController view] animated:YES];
        self.hud.labelText = @"Signing In";
    }
}

- (void)hideHud
{
    NSLog(@"hideHud");
    [self.hud hide:YES];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application: (UIApplication *)application
            openURL: (NSURL *)url
  sourceApplication: (NSString *)sourceApplication
         annotation: (id)annotation
{
    return [GPPURLHandler handleURL:url
                  sourceApplication:sourceApplication
                         annotation:annotation];
}

- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth
                   error: (NSError *) error
{
    if (error) {
        NSLog(@"Received error %@ and auth object %@",error, auth);
        [self hideHud];

        // Do some error handling here.
    } else {
        [self refreshInterfaceBasedOnSignIn];
    }
}

-(void)refreshInterfaceBasedOnSignIn
{
    if ([[GPPSignIn sharedInstance] authentication]) {
        [self showHud];
        
        // The user is signed in.
        NSLog(@"calling mainGridViewController");
        [self setUserEmail:[[GPPSignIn sharedInstance] userEmail]];
        NSLog(@"Fetched Email: %@", [self userEmail]);
        
        [[self commManager] sendObjectWithString:[NSString stringWithFormat:@"register/%@",[self userEmail]] sendType:@"POST" body:nil completion:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            if (data.length > 0 && connectionError == nil)
            {
                NSError *jsonParsingError;
                NSDecimalNumber *number = [NSJSONSerialization JSONObjectWithData:data
                                                                            options:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments
                                                                              error:&jsonParsingError];
                if (jsonParsingError)
                {
                    NSLog(@"Error parsing tv series json!");
                    return;
                }
                
                [self setUserId:[NSString stringWithFormat:@"%@",number]];
                NSLog(@"got an answer after registration: %@", number);
                [self hideHud];
                [[self navigationController] pushViewController:[self mainGridViewController] animated:YES];
            }
        }];
        
        //self.signInButton.hidden = YES;
        // Perform other actions here, such as showing a sign-out button
    } else {
        NSLog(@"authentication object is nil!");
        NSLog(@"calling registerationViewController");

        [self hideHud];
        [[self navigationController] pushViewController:[self registerationViewController] animated:YES];
        //self.signInButton.hidden = NO;
        // Perform other actions here
    }
}

- (void)didDisconnectWithError:(NSError *)error
{
    if (error) {
        NSLog(@"Received error %@", error);
    } else {
        NSLog(@"The user is signed out and disconnected");
        [self hideHud];
        // The user is signed out and disconnected.
        // Clean up user data as specified by the Google+ terms.
    }
}





@end
