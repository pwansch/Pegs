//
//  FlipsideViewController.h
//  Pegs
//
//  Created by Peter Wansch on 10/15/13.
//  Copyright (c) 2013 Peter Wansch. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

@interface FlipsideViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) id <FlipsideViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UISwitch *soundSwitch;
@property (strong, nonatomic) IBOutlet UIPickerView *layoutPicker;
@property (strong, nonatomic) NSArray *pickerData;
@property (strong, nonatomic) IBOutlet UITextView *textView;

- (IBAction)done:(id)sender;

@end
