//
//  SettingViewController.m
//  Hangman
//
//  Created by D.J on 4/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SettingViewController.h"
#import "ViewController.h"

@implementation SettingViewController
@synthesize sliderWordLength;
@synthesize sliderIncorrectGuess;
@synthesize labelWordLength;
@synthesize labelIncorectGuess;


- (id)initWithGameViewController:(ViewController *)gViewController
{
    self = [super initWithNibName:@"SettingViewController" bundle:nil];
    if( self != nil )
    {
        gameViewController = gViewController;
    }
    
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    sliderWordLength.maximumValue = gameViewController.nMaxLength;
    sliderWordLength.minimumValue = 1;
    sliderWordLength.value = gameViewController.nWordLength;
    
    sliderIncorrectGuess.maximumValue = 26;
    sliderIncorrectGuess.minimumValue = 1;
    sliderIncorrectGuess.value = gameViewController.nIncorrectCount;
    
    labelWordLength.text = [NSString stringWithFormat:@"%d", (int)sliderWordLength.value];
    labelIncorectGuess.text = [NSString stringWithFormat:@"%d", (int)sliderIncorrectGuess.value];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setSliderWordLength:nil];
    [self setSliderIncorrectGuess:nil];
    [self setLabelWordLength:nil];
    [self setLabelIncorectGuess:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)onDone:(id)sender 
{
    gameViewController.nWordLength = (int)sliderWordLength.value;
    gameViewController.nIncorrectCount = (int)sliderIncorrectGuess.value;
    
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)onChangeWordLength:(id)sender 
{
    labelWordLength.text = [NSString stringWithFormat:@"%d", (int)sliderWordLength.value];
}

- (IBAction)onChangeIncorrectGuess:(id)sender 
{
    labelIncorectGuess.text = [NSString stringWithFormat:@"%d", (int)sliderIncorrectGuess.value];        
}
@end
