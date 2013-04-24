#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>
{
    NSArray * wordArray;    
    
    int nWordLength;
    int nIncorrectCount;
    int nMaxLength;
    
    int nCurrentWordLength;
    int nCurrentIncorrectCount;
    
    BOOL bPressed[26];
    
}

@property (assign, nonatomic) int nWordLength;
@property (assign, nonatomic) int nIncorrectCount;
@property (assign, nonatomic) int nMaxLength;

@property (strong, nonatomic) IBOutlet UILabel *labelIncorrectCount;
@property (strong, nonatomic) IBOutlet UILabel *labelDescription;
@property (strong, nonatomic) IBOutlet UITextField *text;

@property (strong, nonatomic) NSString * currentKey;
@property (strong, nonatomic) NSMutableArray * currentArray;

- (IBAction)onStart:(id)sender;
- (IBAction)onSetting:(id)sender;

- (void)reset;
- (NSString *)makeKeyString:(NSString *)word letter:(NSString *)strLetter;

@end
