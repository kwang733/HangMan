#import "ViewController.h"
#import "SettingViewController.h"
#import "ConViewController.h"


@implementation ViewController

@synthesize labelIncorrectCount;
@synthesize labelDescription;
@synthesize text;
@synthesize currentKey;
@synthesize currentArray;

@synthesize nMaxLength;
@synthesize nWordLength;
@synthesize nIncorrectCount;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //////////////////////////////////////////////////////////////////////////////////////
    NSNumber * num = [[NSUserDefaults standardUserDefaults] objectForKey:@"WordLength"];
    if( num == nil )
        nWordLength = 7;
    else
        nWordLength = [num intValue];
    
    num = [[NSUserDefaults standardUserDefaults] objectForKey:@"IncorrectGuess"];
    if( num == nil )
        nIncorrectCount = 12;
    else
        nIncorrectCount = [num intValue];
    //////////////////////////////////////////////////////////////////////////////////////
    
    NSString * strPath = [[NSBundle mainBundle] pathForResource:@"words" ofType:@"plist"];
    wordArray = [[NSArray alloc] initWithContentsOfFile:strPath];

    nMaxLength = 0;
	for( NSUInteger index = 0 ; index < [wordArray count] ; index++ )
    {
        if( nMaxLength < [[wordArray objectAtIndex:index] length] )
            nMaxLength = [[wordArray objectAtIndex:index] length];
    }
   
    currentArray = [[NSMutableArray alloc] init];
    
    text.delegate = self;
    
    [self reset];
    
}

- (void)reset
{
    NSUInteger i;
    NSString * strTemp = @"";
    
    nCurrentWordLength = nWordLength;
    nCurrentIncorrectCount = nIncorrectCount;    
    
    for( i = 0 ; i < 26 ; i++ )
    {
        bPressed[i] = NO;
    }
    
    for( i = 0 ; i < nCurrentWordLength ; i++ )
        strTemp = [NSString stringWithFormat:@"_ %@", strTemp];
    self.currentKey = strTemp;
    
    text.text = currentKey;
    
    [currentArray removeAllObjects];
    for( i = 0 ; i < [wordArray count] ; i++ )
    {
        strTemp = [wordArray objectAtIndex:i];
        if( [strTemp length] == nCurrentWordLength )
        {
            [currentArray addObject:strTemp];
        }
    }
    
    NSString * tmpString = [NSString stringWithFormat:@"%d", nCurrentWordLength];
    
    tmpString = [NSString stringWithFormat:@"%d", nCurrentIncorrectCount];
    labelIncorrectCount.text = tmpString;
    
    labelDescription.text = @"";
    
	[text becomeFirstResponder];
}

- (NSString *)makeKeyString:(NSString *)word letter:(NSString *)strLetter
{
    char * strWord = (char *)[word UTF8String];
    char * letter = (char *)[strLetter UTF8String];
    
    char * strKey = new char[strlen(strWord) + 1];
    strcpy(strKey, strWord);
    
    for( int i = 0 ; i < strlen(strKey) ; i++ )
    {
        if( (strKey[i] != letter[0]) &&
            (strKey[i] != letter[0] - 0x20) )
        {
            strKey[i] = '_';
        }
    }
    
    NSString * retString = [NSString stringWithUTF8String:strKey];
    
    delete strKey;
        
    return retString;
    
}

#pragma mark - 

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    NSString * strPressed = [[string substringFromIndex:[string length] - 1] lowercaseString];
    
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
    NSUInteger i;
    
    char * cstrPressed = (char *)[strPressed UTF8String];
    
    if ((cstrPressed[0] < 0x61) || (cstrPressed[0] > 0x7A))
    {
        labelDescription.text = @"You pressed invalid key.";
        return NO;
    }
    if(bPressed[ cstrPressed[0] - 0x61 ] == YES )
    {
        labelDescription.text = @"You have already pressed the key.";
        return NO;
    }
    
    bPressed[ cstrPressed[0] - 0x61 ] = YES;
    
    labelDescription.text = [NSString stringWithFormat:@"You pressed '%@'", strPressed];
    //////////////////////////////////////////////////////////////////////////////////////////
    for( i = 0 ; i < [currentArray count] ; i++ )
    {
        NSString * word = [currentArray objectAtIndex:i];
        NSString * key = [self makeKeyString:word letter:strPressed];
        
        NSMutableArray * array = [dic objectForKey:key];
        if( array == nil )
        {
            array = [NSMutableArray arrayWithObject:word];
            [dic setObject:array forKey:key];
        }
        else
        {
            [array addObject:word];
            [dic setObject:array forKey:key];
        }
    }
    

    //////////////////////////////////////////////////////////////////////////////////////////    
    NSArray * allKeys = [dic allKeys];
    

    int max = 0;
    NSString * maxKey;
    for( i = 0 ; i < [allKeys count] ; i++ )
    {
        NSMutableArray * theArray = [dic objectForKey:[allKeys objectAtIndex:i]];
            
        
        if( max < [theArray count] )
        {
            maxKey = [allKeys objectAtIndex:i];
            max = [theArray count];
        }
    }

    //////////////////////////////////////////////////////////////////////////////////////////    
    char * cstrCurKey = (char *)[currentKey UTF8String];
    char * cstrMaxKey = (char *)[maxKey UTF8String];
    char * cstrNewKey = new char[strlen(cstrCurKey) + 1];
    strcpy(cstrNewKey, cstrCurKey);
    for( int i = 0 ; i < strlen(cstrMaxKey) ; i++ )
    {
        if( cstrMaxKey[i] != '_' )
            cstrNewKey[i * 2] = cstrMaxKey[i];
    }
    self.currentKey = [NSString stringWithUTF8String:cstrNewKey];
    delete cstrNewKey;
    
    text.text = currentKey;

    //////////////////////////////////////////////////////////////////////////////////////////    
    NSMutableArray * maxArray = [dic objectForKey:maxKey];
    self.currentArray = maxArray;

    //////////////////////////////////////////////////////////////////////////////////////////
    
        if( [maxKey rangeOfString:[strPressed uppercaseString]].location == NSNotFound )
        {
            nCurrentIncorrectCount--;
            labelIncorrectCount.text = [NSString stringWithFormat:@"%d", nCurrentIncorrectCount];
            
            if( nCurrentIncorrectCount == 0 )
            {
                ConViewController * conViewController = [[ConViewController alloc] initWithGameViewController:self];
                conViewController.stringResult = @"You lose.";
                [self presentModalViewController:conViewController animated:YES];
                
            }
        }
    
    if( [currentKey rangeOfString:@"_"].location == NSNotFound )
    {
        ConViewController * conViewController = [[ConViewController alloc] initWithGameViewController:self];
        conViewController.stringResult = @"You Win.";
        [self presentModalViewController:conViewController animated:YES];
    }
    return NO;
}


- (IBAction)onStart:(id)sender 
{
    [self reset];
}

- (IBAction)onSetting:(id)sender 
{
    SettingViewController * settingViewController = [[SettingViewController alloc] initWithGameViewController:self];
    
    settingViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentModalViewController:settingViewController animated:YES];
    
}

#pragma mark - 
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidUnload
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:nWordLength] forKey:@"WordLength"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:nIncorrectCount] forKey:@"IncorrectGuess"];
    
    [self setLabelIncorrectCount:nil];
    [self setLabelDescription:nil];
    [self setText:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
@end
