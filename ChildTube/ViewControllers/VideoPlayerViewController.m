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

@property (nonatomic, strong) NSTimer *timer;

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


    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [[self doneView] setAlpha:0.0];
    [[self controlsView] setAlpha:0.0];
    [UIView commitAnimations];
    
}

- (void)timerAction:(NSTimer*)theTimer {
    NSTimeInterval currentTime = [[self videoPlayerViewController].moviePlayer currentPlaybackTime];
    [[self playerSeekSlider] setValue:currentTime];
}


- (IBAction)buttonPressed:(id)sender {
    if (sender == self.playerPlayButton) {
        if (self.videoPlayerViewController.moviePlayer.playbackState == MPMoviePlaybackStatePlaying)
        {
            [self.videoPlayerViewController.moviePlayer pause];
            [self.timer invalidate];
            self.timer = nil;
            [self.playerPlayButton setTitle:@">" forState:UIControlStateNormal];
        }
        else if (self.videoPlayerViewController.moviePlayer.playbackState == MPMoviePlaybackStatePaused)
        {
            [self.videoPlayerViewController.moviePlayer play];
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
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
