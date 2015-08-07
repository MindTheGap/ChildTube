//
//  VideoPlayerViewController.m
//  ChildTube
//
//  Created by mtg on 8/7/15.
//  Copyright (c) 2015 MTG. All rights reserved.
//

#import "SharedHeaders.h"

#import "VideoPlayerViewController.h"

#import "YTPlayerView.h"
#import <MediaPlayer/MediaPlayer.h>

#import "Playlist.h"
#import "Episode.h"

#define kVisibleAlphaForViews 0.75

@interface VideoPlayerViewController ()

@end

@implementation VideoPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.playerView.delegate = self;
    
    [self.topView setAlpha:kVisibleAlphaForViews];
    [self.bottomView setAlpha:kVisibleAlphaForViews];
    
    [self.mpVolumeView setBackgroundColor:[UIColor clearColor]];
    [self.mpVolumeView setShowsRouteButton:NO];
    
    UITapGestureRecognizer *coverViewGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverViewTouched:)];
    [self.coverView addGestureRecognizer:coverViewGestureRecognizer];
    
    [self playYoutubeVideoWithUrl:[self.episode urlPath]];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)coverViewTouched:(UITapGestureRecognizer *)recognizer
{
    if ([self.topView alpha]) {
        [UIView animateWithDuration:0.5 animations:^{
            [self.topView setAlpha:0.0];
            [self.bottomView setAlpha:0.0];
        }];
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            [self.topView setAlpha:kVisibleAlphaForViews];
            [self.bottomView setAlpha:kVisibleAlphaForViews];
        }];
    }
}

- (void)playYoutubeVideoWithUrl:(NSString *)urlPath
{
    NSDictionary *playerVars = @{
                                 @"playsinline" : @1,
                                 @"version" : @3,
                                 @"modestbranding" : @1,
                                 @"controls" : @0,
                                 @"showinfo" : @0,
                                 @"rel" : @0
                                 };
    
    NSLog(@"Playing video url path: %@", urlPath);
    [self.playerView loadWithVideoId:urlPath playerVars:playerVars];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playButtonTouched:(id)sender
{
    if ([self.playerView playerState] == kYTPlayerStatePlaying || [self.playerView playerState] == kYTPlayerStateBuffering) {
        NSLog(@"Changing pause button to play");
        [UIView animateWithDuration:0.5 animations:^{
            [self.playButton setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
        }];
        
        [self.playerView pauseVideo];
    } else {
        NSLog(@"Changing play button to pause");
        [UIView animateWithDuration:0.5 animations:^{
            [self.playButton setImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
        }];

        [self.playerView playVideo];
    }
}

- (IBAction)ffwButtonTouched:(id)sender
{
    
}

- (IBAction)rewButtonTouched:(id)sender
{
    
}

- (IBAction)soundButtonTouched:(id)sender
{
    
}

- (IBAction)doneButtonTouched:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)sliderValueChanged:(id)sender
{
    if (sender == self.seekSlider) {
        
    }
}

- (void)playerView:(YTPlayerView *)playerView didChangeToState:(YTPlayerState)state {
    switch (state) {
        case kYTPlayerStatePlaying:
            NSLog(@"Started playback");
            break;
        case kYTPlayerStatePaused:
            NSLog(@"Paused playback");
            break;
        default:
            break;
    }
}

- (void)playerViewDidBecomeReady:(YTPlayerView *)playerView
{
    [self.playerView playVideo];
}

- (void)playerView:(YTPlayerView *)playerView receivedError:(YTPlayerError)error
{
    NSLog(@"playerView:receivedError: %ld", error);
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidFinishLoad");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"webViewDidFailLoadWithError: %@", [error localizedDescription]);
}


@end
