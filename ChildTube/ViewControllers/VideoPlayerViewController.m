//
//  VideoPlayerViewController.m
//  ChildTube
//
//  Created by MTG on 5/16/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import "VideoPlayerViewController.h"
#import "XCDYouTubeVideoPlayerViewController.h"

@interface VideoPlayerViewController ()

@property (nonatomic, strong) XCDYouTubeVideoPlayerViewController *videoPlayerViewController;

@end

@implementation VideoPlayerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.playerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self.videoPlayerViewController setPreferredVideoQualities:@[ @(XCDYouTubeVideoQualitySmall240) ]];
	
	self.videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:[self urlPath]];
	
	[self.videoPlayerViewController presentInView:self.playerView];
	
    [self.videoPlayerViewController.moviePlayer prepareToPlay];
	
	self.videoPlayerViewController.moviePlayer.shouldAutoplay = YES;
    
    [self.videoPlayerViewController.moviePlayer setControlStyle:MPMovieControlStyleNone];
}

- (IBAction)buttonPressed:(id)sender {
    if (sender == self.playerPlayButton) {
        if (self.videoPlayerViewController.moviePlayer.playbackState == MPMoviePlaybackStatePlaying)
        {
            [self.videoPlayerViewController.moviePlayer pause];
            [self.playerPlayButton setTitle:@">" forState:UIControlStateNormal];
        }
        else if (self.videoPlayerViewController.moviePlayer.playbackState == MPMoviePlaybackStatePaused)
        {
            [self.videoPlayerViewController.moviePlayer play];
            [self.playerPlayButton setTitle:@"||" forState:UIControlStateNormal];
        }
    } else if (sender == self.playerNextTrackButton) {
        NSLog(@"Loading next video in playlist");

    } else if (sender == self.playerPrevTrackButton) {
        NSLog(@"Loading previous video in playlist\n");

    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
