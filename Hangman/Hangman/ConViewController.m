#import "ConViewController.h"
#import "SettingViewController.h"
#import "ViewController.h"


@implementation ConViewController
@synthesize labelResult;
@synthesize stringResult;


- (id)initWithGameViewController:(ViewController *)gViewController
{
    self = [super initWithNibName:@"ConViewController" bundle:nil];
    if( self != nil )
    {
        gameViewController = gViewController;
        stringResult = nil;        
    }
    
    return self;    
}

- (IBAction)onStart:(id)sender 
{
    [self dismissModalViewControllerAnimated:YES];
    
    [NSTimer scheduledTimerWithTimeInterval:0.5f target:gameViewController selector:@selector(onStart:) userInfo:nil repeats:NO];
    
}

- (IBAction)onSetting:(id)sender 
{
//    [self dismissModalViewControllerAnimated:YES];
//    [NSTimer scheduledTimerWithTimeInterval:0.2f target:gameViewController selector:@selector(onSetting:) userInfo:nil repeats:NO];
    
    SettingViewController * settingViewController = [[SettingViewController alloc] initWithGameViewController:gameViewController];
    settingViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:settingViewController animated:YES];
    
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
    
    
    labelResult.text = stringResult;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setLabelResult:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
