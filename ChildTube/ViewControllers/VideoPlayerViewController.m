//
//  VideoPlayerViewController.m
//  ChildTube
//
//  Created by MTG on 5/16/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import "VideoPlayerViewController.h"
#import "XCDYouTubeKit.h"
#import "DataEntities.h"


@interface VideoPlayerViewController ()

@property (nonatomic, strong) XCDYouTubeVideoPlayerViewController *videoPlayerViewController;

@property (nonatomic, strong) NSTimer *hideControlsTimer;

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end

@implementation VideoPlayerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *urlPath = [[self episode] urlPath];
    NSLog(@"UrlPath = %@", urlPath);
    [[self episodeNameLabel] setText:[NSString stringWithFormat:@"%@ - Episode %@", [[self tvSeries] name], [[self episode] episodeNumber]]];
    [[self episodeNameLabel] setTextColor:[UIColor whiteColor]];
    
    [self setVideoPlayerViewController:[[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:urlPath]];
	[self videoPlayerViewController].preferredVideoQualities = @[ @(XCDYouTubeVideoQualitySmall240), @(XCDYouTubeVideoQualityMedium360) ];
    [[self videoPlayerViewController].view setFrame:CGRectMake([self.playerView frame].origin.x, [self.playerView frame].origin.y, [self.playerView frame].size.width, [self.playerView frame].size.height)];
    [[self playerView] insertSubview:[self videoPlayerViewController].view belowSubview:[self controlsView]];

    [[self videoPlayerViewController].moviePlayer setControlStyle:MPMovieControlStyleNone];

    [[self videoPlayerViewController] moviePlayer].shouldAutoplay = YES;
    [[self videoPlayerViewController].moviePlayer play];
    
    [self.playerPlayButton setTitle:@"||" forState:UIControlStateNormal];

    [[self seekCurrentTime] setText:@"00:00"];
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerUpdateSeekAction:) userInfo:nil repeats:YES];
    
    [self setActivityIndicator:[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge]];
    CGRect frame = [self activityIndicator].frame;
    NSLog(@"original frame is: %f,%f,%f,%f", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
    NSLog(@"view's frame is: %f,%f,%f,%f", [self entireScreenView].frame.origin.x, [self entireScreenView].frame.origin.y, [self entireScreenView].frame.size.width, [self entireScreenView].frame.size.height);
    frame.origin.x = CGRectGetMidX([self entireScreenView].frame) - CGRectGetWidth(frame) / 2.0f;
    frame.origin.y = CGRectGetMidY([self entireScreenView].frame) - CGRectGetHeight(frame) / 2.0f;
    [self activityIndicator].frame = frame;
    NSLog(@"original frame is: %f,%f,%f,%f", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);

    [[self entireScreenView] addSubview:[self activityIndicator]];
    
    [[self activityIndicator] startAnimating];
    
    [self hideControlsWithAnimation];
    
    [[self playerSeekSlider] addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sliderTapped:)]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePreloadDidFinish:)
                                                 name:MPMoviePlayerLoadStateDidChangeNotification
                                               object:[self videoPlayerViewController].moviePlayer];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(movieDurationAvailable:)
                                                 name:MPMovieDurationAvailableNotification
                                               object:[self videoPlayerViewController].moviePlayer];
    
}

- (void)movieDurationAvailable:(NSNotification *)notification
{
    NSTimeInterval duration = [(MPMoviePlayerController *)[notification object] duration];
    
    
    [[self seekEndTime] setText:[self timeIntervalToHmsFormat:duration]];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMovieDurationAvailableNotification
                                                  object:[self videoPlayerViewController].moviePlayer];
}

- (NSString *)timeIntervalToHmsFormat:(NSTimeInterval) interval
{
    NSInteger ti = (NSInteger)interval;
    NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600);
    if (hours > 0)
    {
        return [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
    }

    return [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
}

- (void)moviePreloadDidFinish:(NSNotification *)notification
{
    MPMoviePlayerController *moviePlayer = notification.object;
    MPMoviePlaybackState playbackState = moviePlayer.playbackState;
    
    if (playbackState == MPMovieLoadStatePlayable)
    {
        NSLog(@"playbackState == MPMovieLoadStatePlayable");
        [[self activityIndicator] stopAnimating];
    }
}

- (void)sliderTapped:(UIGestureRecognizer *)g
{
    UISlider* s = (UISlider*)g.view;
    if (s.highlighted)
        return; // tap on thumb, let slider deal with it
    CGPoint pt = [g locationInView: s];
    CGFloat percentage = pt.x / s.bounds.size.width;
    CGFloat delta = percentage * (s.maximumValue - s.minimumValue);
    CGFloat value = s.minimumValue + delta;
    [s setValue:value animated:YES];
    
    NSString *str=[NSString stringWithFormat:@"%.f",[[self playerSeekSlider] value]];
    NSLog(str);
    [[self videoPlayerViewController].moviePlayer setCurrentPlaybackTime:value];
}

- (void)timerUpdateSeekAction:(NSTimer*)theTimer
{
    NSTimeInterval currentTime = [[self videoPlayerViewController].moviePlayer currentPlaybackTime];
    [[self playerSeekSlider] setValue:currentTime];
    
    [[self seekCurrentTime] setText:[self timeIntervalToHmsFormat:currentTime]];
}

- (void)timerHideControlsAction:(NSTimer*)theTimer
{
    if (self.videoPlayerViewController.moviePlayer.playbackState == MPMoviePlaybackStatePlaying)
    {
        [self hideControlsWithAnimation];
    }
}

- (void)hideControlsWithAnimation
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [[self doneView] setAlpha:0.0];
    [[self controlsView] setAlpha:0.0];
    [[self episodeNameLabel] setAlpha:0.0];
    [UIView commitAnimations];
}

- (void)showControlsWithAnimation:(CGFloat)newAlpha
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [[self doneView] setAlpha:newAlpha];
    [[self controlsView] setAlpha:newAlpha];
    [[self episodeNameLabel] setAlpha:newAlpha];
    [UIView commitAnimations];
}


- (IBAction)buttonPressed:(id)sender {
    if (sender == self.playerPlayButton) {
        if (self.videoPlayerViewController.moviePlayer.playbackState == MPMoviePlaybackStatePlaying)
        {
            [self.videoPlayerViewController.moviePlayer pause];
            [self.playerPlayButton setTitle:@">" forState:UIControlStateNormal];
            [self removeHideControlsTimer];
        }
        else if (self.videoPlayerViewController.moviePlayer.playbackState == MPMoviePlaybackStatePaused)
        {
            [self.videoPlayerViewController.moviePlayer play];
            [self.playerPlayButton setTitle:@"||" forState:UIControlStateNormal];
            [self setHideControlsTimer];
        }
    } else if (sender == self.playerNextTrackButton) {
        NSLog(@"Loading next video in playlist");

    } else if (sender == self.playerPrevTrackButton) {
        NSLog(@"Loading previous video in playlist\n");

    }
    else if (sender == self.centerVideoViewButton || sender == self.upperVideoViewButton) {
        NSLog(@"Upper or center video view button was pressed!");
        CGFloat newAlpha = (1.0 - [[self doneView] alpha]);
        [self showControlsWithAnimation:newAlpha];
        
        if (newAlpha == 1.0)
        {
            [self setHideControlsTimer];
        }
    }
    else if (sender == self.doneButton)
    {
        NSLog(@"Done button was pressed!");
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)setHideControlsTimer
{
    [self removeHideControlsTimer];
    [self setHideControlsTimer:[NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(timerHideControlsAction:) userInfo:nil repeats:NO]];
}

- (void)removeHideControlsTimer
{
    [[self hideControlsTimer] invalidate];
    [self setHideControlsTimer:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
