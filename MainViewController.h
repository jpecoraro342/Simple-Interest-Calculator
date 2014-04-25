//
//  MainViewController.h
//  Simple Interest Calculator
//
//  Created by Joseph Pecoraro on 7/1/13.
//  Copyright (c) 2013 Joseph Pecoraro. All rights reserved.
//

#import "FlipsideViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, UIPopoverControllerDelegate> {
    float r, n, t, p, a, c;
}

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;

@property (weak, nonatomic) IBOutlet UITextField *rate;
@property (weak, nonatomic) IBOutlet UITextField *numberCompounds;
@property (weak, nonatomic) IBOutlet UITextField *length;
@property (weak, nonatomic) IBOutlet UITextField *principle;
@property (weak, nonatomic) IBOutlet UILabel *finalValue;
@property (weak, nonatomic) IBOutlet UITextField *annualAddition;
@property (weak, nonatomic) IBOutlet UISegmentedControl *continuousCompound;

- (void) solve;
- (void) calculate;
- (void) calculateWithAddition;
- (void) calculateContinuous;
- (void) moveViewUp;
- (void) moveViewDown;
- (void) textFieldDidBeginEditing:(UITextField *)sender;
- (void) dismissKeyboard;

@end