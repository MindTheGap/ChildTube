//
//  VideoPlayerViewController.h
//  ChildTube
//
//  Created by mtg on 8/7/15.
//  Copyright (c) 2015 MTG. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Playlist;
@class YTPlayerView;

@interface VideoPlayerViewController : UIViewController <UIWebViewDelegate, YTPlayerViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (weak, nonatomic) IBOutlet YTPlayerView *playerView;

@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *ffwButton;
@property (weak, nonatomic) IBOutlet UIButton *rewButton;
@property (weak, nonatomic) IBOutlet UIButton *soundButton;
@property (weak, nonatomic) IBOutlet UISlider *volSlider;
@property (weak, nonatomic) IBOutlet UISlider *seekSlider;

@property (weak, nonatomic) IBOutlet UIButton *doneButton;

@property (strong, nonatomic) Playlist *playlist;

@end
