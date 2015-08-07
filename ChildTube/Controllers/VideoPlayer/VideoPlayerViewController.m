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

#import "Playlist.h"
#import "Episode.h"

#define youtubeVideoPlayUrl2 @"<html><body style='margin:0px;padding:0px;'><script type='text/javascript' src='http://www.youtube.com/iframe_api'></script><script type='text/javascript'>function onYouTubeIframeAPIReady(){ytplayer=new YT.Player('playerId',{events:{onReady:onPlayerReady}})}function onPlayerReady(a){ a.target.playVideo(); }</script><iframe id='playerId' type='text/html' width='%f' height='%f' src='http://www.youtube.com/embed/%@?enablejsapi=1&rel=0&playsinline=1&autoplay=1&version=3&modestbranding=0&controls=0&showinfo=0' frameborder='0'></body></html>"


@interface VideoPlayerViewController ()

@property (strong, nonatomic) Episode *currentEpisode;

@property (strong, nonatomic) NSArray *allEpisodes;

@end

@implementation VideoPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.allEpisodes = [[self.playlist episodes] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"id" ascending:YES]]];
    
    self.currentEpisode = [self.allEpisodes firstObject];
    
    self.playerView.delegate = self;
}

- (void)playYoutubeVideoWithUrl:(NSString *)urlPath
{
    NSDictionary *playerVars = @{
                                 @"playsinline" : @1,
                                 @"autoplay" : @1,
                                 @"modestbranding" : @0,
                                 @"controls" : @0,
                                 @"showinfo" : @0,
                                 @"rel" : @0
                                 };
    [self.playerView loadWithVideoId:urlPath playerVars:playerVars];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)doneButtonTouched:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)sliderValueChanged:(id)sender
{
    if (sender == self.volSlider) {
        
    } else if (sender == self.seekSlider) {
        
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
