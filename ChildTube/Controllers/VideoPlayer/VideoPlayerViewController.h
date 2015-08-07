//
//  VideoPlayerViewController.h
//  ChildTube
//
//  Created by mtg on 8/7/15.
//  Copyright (c) 2015 MTG. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YTPlayerView.h"

@class Playlist;
@class Episode;
@class YTPlayerView;
@class MPVolumeView;

@interface VideoPlayerViewController : UIViewController <UIWebViewDelegate, YTPlayerViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *coverView;

@property (weak, nonatomic) IBOutlet YTPlayerView *playerView;

@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *ffwButton;
@property (weak, nonatomic) IBOutlet UIButton *rewButton;
@property (weak, nonatomic) IBOutlet UIButton *soundButton;
@property (weak, nonatomic) IBOutlet MPVolumeView *mpVolumeView;
@property (weak, nonatomic) IBOutlet UISlider *seekSlider;

@property (weak, nonatomic) IBOutlet UIButton *doneButton;

@property (strong, nonatomic) Playlist *playlist;
@property (strong, nonatomic) Episode *episode;


@end
