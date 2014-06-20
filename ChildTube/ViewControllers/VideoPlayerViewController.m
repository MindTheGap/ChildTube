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

@end

@implementation VideoPlayerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

//    [self.playerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
//    self.urlPath = @"http://www.nosajsolomon.com/video.mp4";
//    self.urlPath = @"http://www.youtube.com/watch?v=WhZFNH_A1qA";
//	NSURL *movieURL = [NSURL URLWithString:[self urlPath]];
  
    [self setVideoPlayerViewController:[[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:@"WhZFNH_A1qA"]];
	[self videoPlayerViewController].preferredVideoQualities = @[ @(XCDYouTubeVideoQualitySmall240), @(XCDYouTubeVideoQualityMedium360) ];
    [[self videoPlayerViewController].view setFrame:CGRectMake([self.playerView frame].origin.x, [self.playerView frame].origin.y, [self.playerView frame].size.width, [self.playerView frame].size.height)];
    [[self playerView] insertSubview:[self videoPlayerViewController].view belowSubview:[self controlsView]];

    [[self videoPlayerViewController].moviePlayer setControlStyle:MPMovieControlStyleNone];

    [[self videoPlayerViewController].moviePlayer play];
    
//    self.videoPlayerViewController = [[MPMoviePlayerViewController alloc] initWithContentURL:movieURL];
//    
//    [self.playerView addSubview:self.videoPlayerViewController.view];
//
//    [self.videoPlayerViewController.moviePlayer prepareToPlay];
//	
//	self.videoPlayerViewController.moviePlayer.shouldAutoplay = YES;
//    
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
