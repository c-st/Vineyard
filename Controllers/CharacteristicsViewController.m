
#import "CharacteristicsViewController.h"
#import "UIColor+CellarColours.h"

@interface CharacteristicsViewController ()

@end

@implementation CharacteristicsViewController

@synthesize settingsCell;

- (void) loadView {
	[super loadView];
	[self.view setBackgroundColor:[UIColor cellarBeigeNoisyColour]];
	
	// Slider
	SliderPageControl *slider = [[SliderPageControl alloc] initWithFrame:CGRectMake(0, 50, 200, 20)];
	[slider setNumberOfPages:5];
	[slider setCurrentPage:0];
	[slider setDelegate:self];
	[slider setShowsHint:YES];
	[self.view addSubview:slider];
	
	NSLog(@"loadView");
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

#pragma mark sliderPageControlDelegate

- (NSString *)sliderPageController:(id)controller hintTitleForPage:(NSInteger)page {
	NSString *hintTitle = @"Hello";
	return hintTitle;
}

- (void)onPageChanged:(id)sender {
	
}

- (void)slideToCurrentPage:(bool)animated {
	
}

- (void)changeToPage:(int)page animated:(BOOL)animated {
}


@end
