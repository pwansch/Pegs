//
//  MainViewController.h
//  Pegs
//
//  Created by Peter Wansch on 10/15/13.
//  Copyright (c) 2013 Peter Wansch. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import "FlipsideViewController.h"

#define kVersionKey			@"version"
#define kSoundKey			@"sound"
#define kLayoutKey			@"layout"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, UIPopoverControllerDelegate, UIActionSheetDelegate>

@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;
@property (strong, nonatomic) IBOutlet UIButton *gameButton;
@property (strong, nonatomic) IBOutlet UIButton *undoButton;
@property (strong, nonatomic) IBOutlet UIButton *infoButton;
@property (assign, nonatomic) SystemSoundID newId;
@property (assign, nonatomic) SystemSoundID illegalId;
@property (assign, nonatomic) SystemSoundID wonId;
@property (assign, nonatomic) SystemSoundID lostId;
@property (assign, nonatomic) SystemSoundID undoId;
@property (assign, nonatomic) SystemSoundID pickupId;
@property (assign, nonatomic) SystemSoundID placeId;
@property (assign, nonatomic) short layout;
@property (assign, nonatomic) BOOL m_sound;
@property (assign, nonatomic) BOOL fGameOver;
@property (assign, nonatomic) BOOL fUndo;
@property (assign, nonatomic) short sCount;
@property (assign, nonatomic) BOOL fGrabbed;
@property (assign, nonatomic) short sGrabbedX;
@property (assign, nonatomic) short sGrabbedY;
@property (assign, nonatomic) short sGrabbedFirstX;
@property (assign, nonatomic) short sGrabbedFirstY;
@property (assign, nonatomic) short sDroppedX;
@property (assign, nonatomic) short sDroppedY;
@property (assign, nonatomic) short inGrabbedX;
@property (assign, nonatomic) short inGrabbedY;

- (IBAction)newGame:(id)sender;
- (IBAction)undo:(id)sender;
- (void)playSound:(SystemSoundID)soundID;

@end
