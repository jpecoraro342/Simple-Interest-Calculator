//
//  FlipsideViewController.h
//  Simple Interest Calculator
//
//  Created by Joseph Pecoraro on 7/1/13.
//  Copyright (c) 2013 Joseph Pecoraro. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

@interface FlipsideViewController : UIViewController

@property (weak, nonatomic) id <FlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
