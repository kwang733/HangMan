//
//  ConViewController.h
//  Hangman
//
//  Created by D.J on 4/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;
@interface ConViewController : UIViewController
{
    NSString * stringResult;
    
    ViewController * gameViewController;
}


@property (strong, nonatomic) NSString * stringResult;
@property (strong, nonatomic) IBOutlet UILabel *labelResult;

- (id)initWithGameViewController:(ViewController *)gViewController;


- (IBAction)onStart:(id)sender;
- (IBAction)onSetting:(id)sender;


@end
