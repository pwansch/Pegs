//
//  FlipsideViewController.m
//  Pegs
//
//  Created by Peter Wansch on 10/15/13.
//  Copyright (c) 2013 Peter Wansch. All rights reserved.
//

#import "FlipsideViewController.h"
#import "MainViewController.h"
#import "Algorithm.h"

@interface FlipsideViewController ()

@end

@implementation FlipsideViewController

- (void)awakeFromNib
{
    self.preferredContentSize = CGSizeMake(320.0, 568.0);
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
	// Load settings
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	self.soundSwitch.on = [defaults boolForKey:kSoundKey];
    self.textView.editable = NO;
    self.pickerData = [[NSArray alloc] initWithObjects:@"Cross", @"Plus", @"Fireplace", @"Up Arrow", @"Pyramid", @"Diamond", @"Solitaire", nil];
    NSInteger row = 0;
    switch ([defaults integerForKey:kLayoutKey]) {
        case CROSS:
            row = 0;
            break;
        case PLUS:
            row = 1;
            break;
        case FIREPLACE:
            row = 2;
            break;
        case UPARROW:
            row = 3;
            break;
        case PYRAMID:
            row = 4;
            break;
        case DIAMOND:
            row = 5;
            break;
        case SOLITAIRE:
            row = 6;
            break;
    }
    [self.layoutPicker selectRow:row inComponent:0 animated:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    NSRange r = {0,0};
    [self.textView scrollRangeToVisible:r];
    [super viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.pickerData count];
}

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.pickerData objectAtIndex:row];
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
	// Save settings and write to disk
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setBool:self.soundSwitch.on forKey:kSoundKey];
    NSInteger row = [self.layoutPicker selectedRowInComponent:0];
    short layout;
    switch (row) {
        case 0:
            layout = CROSS;
            break;
        case 1:
            layout = PLUS;
            break;
        case 2:
            layout = FIREPLACE;
            break;
        case 3:
            layout = UPARROW;
            break;
        case 4:
            layout = PYRAMID;
            break;
        case 5:
            layout = DIAMOND;
            break;
        case 6:
            layout = SOLITAIRE;
            break;
    }
    [defaults setInteger:layout forKey:kLayoutKey];
	[defaults synchronize];
    [self.delegate flipsideViewControllerDidFinish:self];
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view
	self.soundSwitch = nil;
    self.layoutPicker = nil;
    self.pickerData = nil;
    self.textView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return YES;
    } else {
        return (interfaceOrientation !=	UIInterfaceOrientationPortraitUpsideDown);
    }
}

@end
