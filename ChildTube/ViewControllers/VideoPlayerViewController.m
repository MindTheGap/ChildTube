//
//  VideoPlayerViewController.m
//  ChildTube
//
//  Created by MTG on 5/16/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import "VideoPlayerViewController.h"
#import "XCDYouTubeKit.h"


@interface VideoPlayerViewController ()

@property (nonatomic, strong) XCDYouTubeVideoPlayerViewController *videoPlayerViewController;

@property (nonatomic, strong) NSTimer *seekTimer;

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end

@implementation VideoPlayerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

//    [self setVideoPlayerViewController:[[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:@"WhZFNH_A1qA"]];
    [self setVideoPlayerViewController:[[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:@"tX8OJQqicFw"]];
	[self videoPlayerViewController].preferredVideoQualities = @[ @(XCDYouTubeVideoQualitySmall240), @(XCDYouTubeVideoQualityMedium360) ];
    [[self videoPlayerViewController].view setFrame:CGRectMake([self.playerView frame].origin.x, [self.playerView frame].origin.y, [self.playerView frame].size.width, [self.playerView frame].size.height)];
    [[self playerView] insertSubview:[self videoPlayerViewController].view belowSubview:[self controlsView]];

    [[self videoPlayerViewController].moviePlayer setControlStyle:MPMovieControlStyleNone];

    [[self videoPlayerViewController] moviePlayer].shouldAutoplay = YES;
    [[self videoPlayerViewController].moviePlayer play];

    self.seekTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerUpdateSeekAction:) userInfo:nil repeats:YES];
    
    [self setActivityIndicator:[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge]];
    CGRect frame = [self activityIndicator].frame;
    NSLog(@"original frame is: %f,%f,%f,%f", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
    NSLog(@"view's frame is: %f,%f,%f,%f", [self entireScreenView].frame.origin.x, [self entireScreenView].frame.origin.y, [self entireScreenView].frame.size.width, [self entireScreenView].frame.size.height);
    
    frame.origin.x = CGRectGetMidX([self entireScreenView].frame);
    frame.origin.y = CGRectGetMidY([self entireScreenView].frame);
    [self activityIndicator].frame = frame;
    NSLog(@"original frame is: %f,%f,%f,%f", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);

    [[self entireScreenView] addSubview:[self activityIndicator]];
    
    [[self activityIndicator] startAnimating];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [[self doneView] setAlpha:0.0];
    [[self controlsView] setAlpha:0.0];
    [UIView commitAnimations];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePreloadDidFinish:)
                                                 name:MPMoviePlayerLoadStateDidChangeNotification
                                               object:[self videoPlayerViewController].moviePlayer];
    
    
}

- (void)moviePreloadDidFinish:(NSNotification *)notification
{
    MPMoviePlayerController *moviePlayer = notification.object;
    MPMoviePlaybackState playbackState = moviePlayer.playbackState;
    
    if (playbackState == MPMovieLoadStatePlayable)
    {
        NSLog(@"playbackState == MPMovieLoadStatePlayable");
//        [[self activityIndicator] stopAnimating];
    }
}

- (void)timerUpdateSeekAction:(NSTimer*)theTimer
{
    NSTimeInterval currentTime = [[self videoPlayerViewController].moviePlayer currentPlaybackTime];
    [[self playerSeekSlider] setValue:currentTime];
}

- (void)timerHideControlsAction:(NSTimer*)theTimer
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [[self doneView] setAlpha:0.0];
    [[self controlsView] setAlpha:0.0];
    [UIView commitAnimations];
}


- (IBAction)buttonPressed:(id)sender {
    if (sender == self.playerPlayButton) {
        if (self.videoPlayerViewController.moviePlayer.playbackState == MPMoviePlaybackStatePlaying)
        {
            [self.videoPlayerViewController.moviePlayer pause];
            [self.seekTimer invalidate];
            self.seekTimer = nil;
            [self.playerPlayButton setTitle:@">" forState:UIControlStateNormal];
        }
        else if (self.videoPlayerViewController.moviePlayer.playbackState == MPMoviePlaybackStatePaused)
        {
            [self.videoPlayerViewController.moviePlayer play];
            self.seekTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerUpdateSeekAction:) userInfo:nil repeats:YES];
            [self.playerPlayButton setTitle:@"||" forState:UIControlStateNormal];
        }
    } else if (sender == self.playerNextTrackButton) {
        NSLog(@"Loading next video in playlist");

    } else if (sender == self.playerPrevTrackButton) {
        NSLog(@"Loading previous video in playlist\n");

    }
    else if (sender == self.centerVideoViewButton || sender == self.upperVideoViewButton) {
        NSLog(@"Upper or center video view button was pressed!");
        CGFloat newAlpha = (1.0 - [[self doneView] alpha]);
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        [[self doneView] setAlpha:newAlpha];
        [[self controlsView] setAlpha:newAlpha];
        [UIView commitAnimations];
        
        if (newAlpha == 1.0)
        {
            [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(timerHideControlsAction:) userInfo:nil repeats:NO];
        }
    }
    else if (sender == self.doneButton)
    {
        NSLog(@"Done button was pressed!");
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
