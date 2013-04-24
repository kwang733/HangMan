//
//  SettingViewController.h
//  Hangman
//
//  Created by D.J on 4/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;
@interface SettingViewController : UIViewController
{
    ViewController * gameViewController;
}

- (id)initWithGameViewController:(ViewController *)gViewController;

@property (strong, nonatomic) IBOutlet UISlider *sliderWordLength;
@property (strong, nonatomic) IBOutlet UISlider *sliderIncorrectGuess;


@property (strong, nonatomic) IBOutlet UILabel *labelWordLength;
@property (strong, nonatomic) IBOutlet UILabel *labelIncorectGuess;

- (IBAction)onDone:(id)sender;

- (IBAction)onChangeWordLength:(id)sender;
- (IBAction)onChangeIncorrectGuess:(id)sender;



@end
