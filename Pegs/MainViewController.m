//
//  MainViewController.m
//  Pegs
//
//  Created by Peter Wansch on 10/15/13.
//  Copyright (c) 2013 Peter Wansch. All rights reserved.
//

#import "MainViewController.h"
#import "MainView.h"

@interface MainViewController ()
- (void)initializeGame;
@end

@implementation MainViewController

@synthesize newId;
@synthesize illegalId;
@synthesize wonId;
@synthesize lostId;
@synthesize undoId;
@synthesize pickupId;
@synthesize placeId;

// Global variables
short asCROSS[DIVISIONS][DIVISIONS] =
    {EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,
    EMPTY,EMPTY,EMPTY,BOARD,BOARD,BOARD,EMPTY,EMPTY,EMPTY,
    EMPTY,EMPTY,EMPTY,BOARD,BOARD,BOARD,EMPTY,EMPTY,EMPTY,
    EMPTY,BOARD,BOARD,BOARD,BOARD,PIECE,BOARD,BOARD,EMPTY,
    EMPTY,BOARD,BOARD,PIECE,PIECE,PIECE,PIECE,BOARD,EMPTY,
    EMPTY,BOARD,BOARD,BOARD,BOARD,PIECE,BOARD,BOARD,EMPTY,
    EMPTY,EMPTY,EMPTY,BOARD,BOARD,BOARD,EMPTY,EMPTY,EMPTY,
    EMPTY,EMPTY,EMPTY,BOARD,BOARD,BOARD,EMPTY,EMPTY,EMPTY,
    EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY};
short asPLUS[DIVISIONS][DIVISIONS] =
    {EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,
    EMPTY,EMPTY,EMPTY,BOARD,BOARD,BOARD,EMPTY,EMPTY,EMPTY,
    EMPTY,EMPTY,EMPTY,BOARD,PIECE,BOARD,EMPTY,EMPTY,EMPTY,
    EMPTY,BOARD,BOARD,BOARD,PIECE,BOARD,BOARD,BOARD,EMPTY,
    EMPTY,BOARD,PIECE,PIECE,PIECE,PIECE,PIECE,BOARD,EMPTY,
    EMPTY,BOARD,BOARD,BOARD,PIECE,BOARD,BOARD,BOARD,EMPTY,
    EMPTY,EMPTY,EMPTY,BOARD,PIECE,BOARD,EMPTY,EMPTY,EMPTY,
    EMPTY,EMPTY,EMPTY,BOARD,BOARD,BOARD,EMPTY,EMPTY,EMPTY,
    EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY};
short asFIREPLACE[DIVISIONS][DIVISIONS] =
    {EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,
    EMPTY,EMPTY,EMPTY,BOARD,BOARD,BOARD,EMPTY,EMPTY,EMPTY,
    EMPTY,EMPTY,EMPTY,BOARD,BOARD,BOARD,EMPTY,EMPTY,EMPTY,
    EMPTY,BOARD,BOARD,BOARD,PIECE,PIECE,PIECE,PIECE,EMPTY,
    EMPTY,BOARD,BOARD,BOARD,BOARD,PIECE,PIECE,PIECE,EMPTY,
    EMPTY,BOARD,BOARD,BOARD,PIECE,PIECE,PIECE,PIECE,EMPTY,
    EMPTY,EMPTY,EMPTY,BOARD,BOARD,BOARD,EMPTY,EMPTY,EMPTY,
    EMPTY,EMPTY,EMPTY,BOARD,BOARD,BOARD,EMPTY,EMPTY,EMPTY,
    EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY};
short asUPARROW[DIVISIONS][DIVISIONS] =
    {EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,
    EMPTY,EMPTY,EMPTY,BOARD,BOARD,BOARD,EMPTY,EMPTY,EMPTY,
    EMPTY,EMPTY,EMPTY,BOARD,BOARD,PIECE,EMPTY,EMPTY,EMPTY,
    EMPTY,PIECE,PIECE,BOARD,BOARD,PIECE,PIECE,BOARD,EMPTY,
    EMPTY,PIECE,PIECE,PIECE,PIECE,PIECE,PIECE,PIECE,EMPTY,
    EMPTY,PIECE,PIECE,BOARD,BOARD,PIECE,PIECE,BOARD,EMPTY,
    EMPTY,EMPTY,EMPTY,BOARD,BOARD,PIECE,EMPTY,EMPTY,EMPTY,
    EMPTY,EMPTY,EMPTY,BOARD,BOARD,BOARD,EMPTY,EMPTY,EMPTY,
    EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY};
short asPYRAMID[DIVISIONS][DIVISIONS] =
    {EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,
    EMPTY,EMPTY,EMPTY,PIECE,BOARD,BOARD,EMPTY,EMPTY,EMPTY,
    EMPTY,EMPTY,EMPTY,PIECE,PIECE,BOARD,EMPTY,EMPTY,EMPTY,
    EMPTY,BOARD,BOARD,PIECE,PIECE,PIECE,BOARD,BOARD,EMPTY,
    EMPTY,BOARD,BOARD,PIECE,PIECE,PIECE,PIECE,BOARD,EMPTY,
    EMPTY,BOARD,BOARD,PIECE,PIECE,PIECE,BOARD,BOARD,EMPTY,
    EMPTY,EMPTY,EMPTY,PIECE,PIECE,BOARD,EMPTY,EMPTY,EMPTY,
    EMPTY,EMPTY,EMPTY,PIECE,BOARD,BOARD,EMPTY,EMPTY,EMPTY,
    EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY};
short asDIAMOND[DIVISIONS][DIVISIONS] =
    {EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,
    EMPTY,EMPTY,EMPTY,BOARD,PIECE,BOARD,EMPTY,EMPTY,EMPTY,
    EMPTY,EMPTY,EMPTY,PIECE,PIECE,PIECE,EMPTY,EMPTY,EMPTY,
    EMPTY,BOARD,PIECE,PIECE,PIECE,PIECE,PIECE,BOARD,EMPTY,
    EMPTY,PIECE,PIECE,PIECE,BOARD,PIECE,PIECE,PIECE,EMPTY,
    EMPTY,BOARD,PIECE,PIECE,PIECE,PIECE,PIECE,BOARD,EMPTY,
    EMPTY,EMPTY,EMPTY,PIECE,PIECE,PIECE,EMPTY,EMPTY,EMPTY,
    EMPTY,EMPTY,EMPTY,BOARD,PIECE,BOARD,EMPTY,EMPTY,EMPTY,
    EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY};
short asSOLITAIRE[DIVISIONS][DIVISIONS] =
    {EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,
    EMPTY,EMPTY,EMPTY,PIECE,PIECE,PIECE,EMPTY,EMPTY,EMPTY,
    EMPTY,EMPTY,EMPTY,PIECE,PIECE,PIECE,EMPTY,EMPTY,EMPTY,
    EMPTY,PIECE,PIECE,PIECE,PIECE,PIECE,PIECE,PIECE,EMPTY,
    EMPTY,PIECE,PIECE,PIECE,BOARD,PIECE,PIECE,PIECE,EMPTY,
    EMPTY,PIECE,PIECE,PIECE,PIECE,PIECE,PIECE,PIECE,EMPTY,
    EMPTY,EMPTY,EMPTY,PIECE,PIECE,PIECE,EMPTY,EMPTY,EMPTY,
    EMPTY,EMPTY,EMPTY,PIECE,PIECE,PIECE,EMPTY,EMPTY,EMPTY,
    EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY,EMPTY};

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // Create system sounds
    NSString *path = [[NSBundle mainBundle] pathForResource:@"new" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &newId);
    path = [[NSBundle mainBundle] pathForResource:@"illegal" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &illegalId);
    path = [[NSBundle mainBundle] pathForResource:@"won" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &wonId);
    path = [[NSBundle mainBundle] pathForResource:@"lost" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &lostId);
    path = [[NSBundle mainBundle] pathForResource:@"undo" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &undoId);
    path = [[NSBundle mainBundle] pathForResource:@"pickup" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &pickupId);
    path = [[NSBundle mainBundle] pathForResource:@"place" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &placeId);
    
    // Initialize settings
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.m_sound = [defaults boolForKey:kSoundKey];
    self.layout = [defaults integerForKey:kLayoutKey];

    // Initialize variables
    [self initializeGame];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Change the location of the buttons
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        self.gameButton.frame = CGRectMake(20, self.view.bounds.size.height - 79, 60, 30);
        self.undoButton.frame = CGRectMake(20, self.view.bounds.size.height - 44, 60, 30);
    } else {
        self.gameButton.frame = CGRectMake(20, self.view.bounds.size.height - 44, 60, 30);
        self.undoButton.frame = CGRectMake(88, self.view.bounds.size.height - 44, 60, 30);
    }
    
	// Draw the view
	[self.view setNeedsDisplay];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Flipside View Controller

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
	// Save the settings and start a new game if requested
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.m_sound = [defaults boolForKey:kSoundKey];
    short layout = [defaults integerForKey:kLayoutKey];
    if (self.layout != layout) {
        self.layout = layout;
        [self newGame:controller];
    }
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
        self.flipsidePopoverController = nil;
    }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.flipsidePopoverController = nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            UIPopoverController *popoverController = [(UIStoryboardPopoverSegue *)segue popoverController];
            self.flipsidePopoverController = popoverController;
            popoverController.delegate = self;
        }
    }
}

- (IBAction)togglePopover:(id)sender
{
    if (self.flipsidePopoverController) {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
        self.flipsidePopoverController = nil;
    } else {
        [self performSegueWithIdentifier:@"showAlternate" sender:sender];
    }
}

- (IBAction)newGame:(id)sender
{
    if(!self.fGameOver) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Do you want to start a new game?" delegate:self cancelButtonTitle:@"No" destructiveButtonTitle:@"Yes" otherButtonTitles:nil];
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [sender isKindOfClass:[FlipsideViewController class]]) {
            FlipsideViewController *controller = sender;
            [actionSheet showInView:controller.view];
        } else {
            [actionSheet showInView:self.view];
        }
    } else {
        [self initializeGame];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex != [actionSheet cancelButtonIndex]) {
        [self initializeGame];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
	// Release any retained subviews of the main view
	self.gameButton = nil;
    self.undoButton = nil;
    self.infoButton = nil;
    self.flipsidePopoverController = nil;
    MainView *mainView = (MainView *)self.view;
    mainView.grabbedPeg = nil;
    
    // Dispose sounds
    AudioServicesDisposeSystemSoundID(newId);
    AudioServicesDisposeSystemSoundID(illegalId);
    AudioServicesDisposeSystemSoundID(wonId);
    AudioServicesDisposeSystemSoundID(lostId);
    AudioServicesDisposeSystemSoundID(undoId);
    AudioServicesDisposeSystemSoundID(pickupId);
    AudioServicesDisposeSystemSoundID(placeId);
}

- (void) playSound:(SystemSoundID)soundID
{
	if (self.m_sound) {
		AudioServicesPlaySystemSound(soundID);
	}
}

- (void)initializeGame
{
    MainView *mainView = (MainView *)self.view;
    
	// Play the new game sound
	[self playSound:newId];
    
	// Initialize the game
    self.fGameOver = NO;
	self.fGrabbed = NO;
    mainView.grabbedPeg.hidden = YES;
    self.fUndo = NO;
    self.undoButton.hidden = NO;
    
    // Initialize board
    Board boardIni;
    switch (self.layout) {
        case CROSS:
			for (int x = 0; x < DIVISIONS; x++)
				for (int y = 0; y < DIVISIONS; y++)
					boardIni.fState[x][y] = asCROSS[x][y];
            break;
        case PLUS:
			for (int x = 0; x < DIVISIONS; x++)
				for (int y = 0; y < DIVISIONS; y++)
					boardIni.fState[x][y] = asPLUS[x][y];
            break;
        case FIREPLACE:
			for (int x = 0; x < DIVISIONS; x++)
				for (int y = 0; y < DIVISIONS; y++)
					boardIni.fState[x][y] = asFIREPLACE[x][y];
            break;
        case UPARROW:
			for (int x = 0; x < DIVISIONS; x++)
				for (int y = 0; y < DIVISIONS; y++)
					boardIni.fState[x][y] = asUPARROW[x][y];
            break;
        case PYRAMID:
			for (int x = 0; x < DIVISIONS; x++)
				for (int y = 0; y < DIVISIONS; y++)
					boardIni.fState[x][y] = asPYRAMID[x][y];
            break;
        case DIAMOND:
			for (int x = 0; x < DIVISIONS; x++)
				for (int y = 0; y < DIVISIONS; y++)
					boardIni.fState[x][y] = asDIAMOND[x][y];
            break;
        case SOLITAIRE:
			for (int x = 0; x < DIVISIONS; x++)
				for (int y = 0; y < DIVISIONS; y++)
					boardIni.fState[x][y] = asSOLITAIRE[x][y];
            break;
    }
    mainView.board = boardIni;
    self.sCount = self.layout;
    mainView.text = [[NSString alloc] initWithFormat: @"Drag a peg to jump over an adjacent peg."];
    
	// Draw the view
	[mainView setNeedsDisplay];
}

- (IBAction)undo:(id)sender
{
    if(!self.fGameOver && self.fUndo) {
        MainView *mainView = (MainView *)self.view;
        
        // undo the last move
        [self playSound:undoId];
        PBoard pBoard = [mainView getBoardPointer];
        pBoard->fState[self.sGrabbedFirstX][self.sGrabbedFirstY] = PIECE;
        [mainView setNeedsDisplayInRect:[mainView boardRect:self.sGrabbedFirstX :self.sGrabbedFirstY]];
        pBoard->fState[self.inGrabbedX][self.inGrabbedY] = PIECE;
        [mainView setNeedsDisplayInRect:[mainView boardRect:self.inGrabbedX :self.inGrabbedY]];
        pBoard->fState[self.sDroppedX][self.sDroppedY] = BOARD;
        [mainView setNeedsDisplayInRect:[mainView boardRect:self.sDroppedX :self.sDroppedY]];
        self.sCount++;
        self.fUndo = NO;
    }
    else {
        // Unable to show undo
        [self playSound:illegalId];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	if (!self.fGameOver) {
        MainView *mainView = (MainView *)self.view;
		// calculate coordinates
        short x = [mainView getTouchXIndex:touches];
        short y = [mainView getTouchYIndex:touches];
        if (x >= 0 && x < DIVISIONS && y >= 0 && y < DIVISIONS && !self.fGrabbed && mainView.board.fState[x][y] == PIECE) {
            [self playSound:pickupId];
            // Take piece away
            self.fGrabbed = YES;
            self.sGrabbedX = x;
            self.sGrabbedY = y;
            mainView.grabbedPeg.frame = [mainView boardRect:self.sGrabbedX :self.sGrabbedY];
            mainView.grabbedPeg.hidden = NO;
            PBoard pBoard = [mainView getBoardPointer];
            pBoard->fState[self.sGrabbedX][self.sGrabbedY] = BOARD;
            [mainView setNeedsDisplayInRect:[mainView boardRect:self.sGrabbedX :self.sGrabbedY]];
            
        } else {
            [self playSound:illegalId];
        }
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	if (!self.fGameOver && self.fGrabbed) {
        // A peg was picked up
        MainView *mainView = (MainView *)self.view;
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:mainView];
        CGRect frame = mainView.grabbedPeg.frame;
        frame.origin.x = point.x - (frame.size.width / 2);
        frame.origin.y = point.y - (frame.size.height / 2);
        mainView.grabbedPeg.frame = frame;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.fGrabbed && !self.fGameOver) {
        MainView *mainView = (MainView *)self.view;
		// calculate coordinates
		short GrabbedX = [mainView getTouchXIndex:touches];
		short GrabbedY = [mainView getTouchYIndex:touches];
        self.fGrabbed = NO;
        mainView.grabbedPeg.hidden = YES;
        
		// Has the mouse pointer been released inside the window
        if (GrabbedX > 0 && GrabbedX < DIVISIONS && GrabbedY > 0 && GrabbedY < DIVISIONS && mainView.board.fState[GrabbedX][GrabbedY] == BOARD) {
			// ist der Zug gueltig
			if ((GrabbedX != self.sGrabbedX || GrabbedY != self.sGrabbedY) &&
				((GrabbedX == self.sGrabbedX && GrabbedY == (self.sGrabbedY + 2) && mainView.board.fState[self.sGrabbedX][self.sGrabbedY + 1] == PIECE) ||
                 (GrabbedY == self.sGrabbedY && GrabbedX == (self.sGrabbedX + 2) && mainView.board.fState[self.sGrabbedX + 1][self.sGrabbedY] == PIECE) ||
                 (GrabbedX == self.sGrabbedX && GrabbedY == (self.sGrabbedY - 2) && mainView.board.fState[self.sGrabbedX][self.sGrabbedY - 1] == PIECE) ||
                 (GrabbedY == self.sGrabbedY && GrabbedX == (self.sGrabbedX - 2) && mainView.board.fState[self.sGrabbedX - 1][self.sGrabbedY] == PIECE))) {
                [self playSound:placeId];
				self.sGrabbedFirstX = self.sGrabbedX;
				self.sGrabbedFirstY = self.sGrabbedY;
				self.sDroppedX = GrabbedX;
				self.sDroppedY = GrabbedY;
                
				// Drop new piece
                PBoard pBoard = [mainView getBoardPointer];
                pBoard->fState[GrabbedX][GrabbedY] = PIECE;
                [mainView setNeedsDisplayInRect:[mainView boardRect:GrabbedX :GrabbedY]];
                
				// Remove piece in between
				// horizontal move
				if (GrabbedX == self.sGrabbedX)
					self.inGrabbedX = GrabbedX;
				// vertical move
				if (GrabbedY == self.sGrabbedY)
					self.inGrabbedY = GrabbedY;
				if (GrabbedX > self.sGrabbedX)
					self.inGrabbedX = GrabbedX - 1;
				if (GrabbedX < self.sGrabbedX)
					self.inGrabbedX = GrabbedX + 1;
				if (GrabbedY > self.sGrabbedY)
					self.inGrabbedY = GrabbedY - 1;
				if (GrabbedY < self.sGrabbedY)
					self.inGrabbedY = GrabbedY + 1;
                    
                pBoard->fState[self.inGrabbedX][self.inGrabbedY] = BOARD;
                [mainView setNeedsDisplayInRect:[mainView boardRect:self.inGrabbedX :self.inGrabbedY]];
				self.sCount --;
				self.fUndo = YES;
                
				// gewonnen, oder das Spiel ist vorbei
				if (self.sCount == 1 || IsOver(pBoard))
				{
					if (self.sCount == 1)
                        [self playSound:wonId];
					else
                        [self playSound:lostId];
					self.fGameOver = YES;
                    self.undoButton.hidden = YES;
                    
					// set display text
					if (self.sCount == 1)
                        mainView.text = [[NSString alloc] initWithFormat: @"You won."];
					else
						mainView.text = [[NSString alloc] initWithFormat: @"You lost."];
				} else {
                    mainView.text = [[NSString alloc] initWithFormat: @""];
                }

                // display text
                [mainView invalidateText];
			}
			else
			{
				[self playSound:illegalId];
				
                // restore old board
                PBoard pBoard = [mainView getBoardPointer];
                pBoard->fState[self.sGrabbedX][self.sGrabbedY] = PIECE;
                [mainView setNeedsDisplayInRect:[mainView boardRect:self.sGrabbedX :self.sGrabbedY]];
			}
		}
		else
		{
			[self playSound:illegalId];
            
			// restore old board
            PBoard pBoard = [mainView getBoardPointer];
            pBoard->fState[self.sGrabbedX][self.sGrabbedY] = PIECE;
            [mainView setNeedsDisplayInRect:[mainView boardRect:self.sGrabbedX :self.sGrabbedY]];
		}
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return YES;
    } else {
        return (interfaceOrientation !=	UIInterfaceOrientationPortraitUpsideDown);
    }
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    // Dismiss popover if it is displayed
    if (self.flipsidePopoverController != nil) {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
        self.flipsidePopoverController = nil;
    }
    
    // Change the location of the buttons
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
        self.gameButton.frame = CGRectMake(20, self.view.bounds.size.height - 79, 60, 30);
        self.undoButton.frame = CGRectMake(20, self.view.bounds.size.height - 44, 60, 30);
    } else {
        self.gameButton.frame = CGRectMake(20, self.view.bounds.size.height - 44, 60, 30);
        self.undoButton.frame = CGRectMake(88, self.view.bounds.size.height - 44, 60, 30);
    }
}

@end
