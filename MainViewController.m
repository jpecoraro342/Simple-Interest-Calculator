//
//  MainViewController.m
//  Simple Interest Calculator
//
//  Created by Joseph Pecoraro on 7/1/13.
//  Copyright (c) 2013 Joseph Pecoraro. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize rate, numberCompounds, length, principle, annualAddition;
@synthesize finalValue;
@synthesize continuousCompound;

- (void)viewDidLoad
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

#pragma mark - Flipside View Controller

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
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

- (IBAction)solve:(id)sender {
    r = [rate.text floatValue]/100.0;
    n = [numberCompounds.text floatValue];
    t = [length.text floatValue];
    p = [principle.text floatValue];
    c = [annualAddition.text floatValue];
    
    if ([continuousCompound selectedSegmentIndex] == 0) {
        [self calculateContinuous];
    }
    else if (c == 0) {
        [self calculate];
    }
    else {
        [self calculateWithAddition];
    }
    
    finalValue.text = [NSString stringWithFormat:@"%.2f", a];
}

- (void)calculate {
    a = (r / n) + 1;
    a = powf(a, t*n);
    a = p * a;
}

- (void)calculateWithAddition {
    r = (r/n) + 1;
    c = c/n;
    a = p;
    for (int i = 0; i < (int)t*n; i ++) {
        a = a*r;
        a += c;
    }
}

- (void)calculateContinuous {
    c = c/12.0; //monthly addition
    a=p;
    for (int i = 0; i < (int)(t*12); i ++) {
        a = a*powf(M_E, r/12.0);
        a += c;
    }
}

-(void)dismissKeyboard {
    [rate resignFirstResponder];
    [numberCompounds resignFirstResponder];
    [length resignFirstResponder];
    [principle resignFirstResponder];
    [annualAddition resignFirstResponder];
    
    if (self.view.frame.origin.y < 0) {
        [self moveViewDown];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    if ([sender isEqual:annualAddition])
    {
        [self moveViewUp];
    }
}

-(void)moveViewUp {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y - 70, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}

-(void)moveViewDown {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + 70, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}

@end
