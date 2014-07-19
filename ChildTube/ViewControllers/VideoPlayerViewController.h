//
//  VideoPlayerViewController.h
//  ChildTube
//
//  Created by MTG on 5/16/14.
//  Copyright (c) 2014 MTG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoPlayerViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *playerView;
@property (weak, nonatomic) IBOutlet UIView *controlsView;
@property (weak, nonatomic) IBOutlet UIView *entireScreenView;
@property (weak, nonatomic) IBOutlet UISlider *playerSeekSlider;
@property (weak, nonatomic) IBOutlet UIButton *playerPlayButton;
@property (weak, nonatomic) IBOutlet UIButton *playerNextTrackButton;
@property (weak, nonatomic) IBOutlet UIButton *playerPrevTrackButton;
@property (weak, nonatomic) IBOutlet UIButton *playerMuteButton;
@property (weak, nonatomic) IBOutlet UISlider *playerVolumeSlider;

@property (weak, nonatomic) IBOutlet UIView *doneView;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;

@property (weak, nonatomic) IBOutlet UIButton *upperVideoViewButton;
@property (weak, nonatomic) IBOutlet UIButton *centerVideoViewButton;

@property (strong, nonatomic) NSString *urlPath;

@end
