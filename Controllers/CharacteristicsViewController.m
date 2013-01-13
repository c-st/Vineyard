
#import "CharacteristicsViewController.h"
#import "UIColor+CellarColours.h"

@interface CharacteristicsViewController ()

@end

@implementation CharacteristicsViewController

@synthesize settingsCell;

- (void) loadView {
	[super loadView];
	[self.view setBackgroundColor:[UIColor cellarBeigeNoisyColour]];
	
	UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle: @"Done" style:UIBarButtonItemStylePlain target:self action: @selector(finishSelection)];
	[[self navigationItem] setRightBarButtonItem:doneButton];
	
	// Sweetness, Acidity, Tannin, Fruit, Body
	UILabel *backgroundLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 355)];
	[backgroundLabel setBackgroundColor:[UIColor whiteColor]];
	[[self view] addSubview:backgroundLabel];
	
	// Shadow
	CAGradientLayer *shadow = [CAGradientLayer layer];
	shadow.frame = CGRectMake(0, 355, self.view.frame.size.width, 6);
	shadow.startPoint = CGPointMake(1.0, 0.5);
	shadow.endPoint = CGPointMake(1.0, 1.0);
	shadow.colors = @[(id)[[UIColor colorWithWhite:0.0 alpha:0.15] CGColor], (id)[[UIColor clearColor] CGColor]];
	[self.view.layer addSublayer:shadow];
	

	[self createSliderAndLabel:@"Sweetness" andNamedProperty:@"sweetness" andYPosition:10 onView:self.view];
	[self createSliderAndLabel:@"Acidity" andNamedProperty:@"acidity" andYPosition:75 onView:self.view];
	[self createSliderAndLabel:@"Tannin" andNamedProperty:@"tannin" andYPosition:145 onView:self.view];
	[self createSliderAndLabel:@"Fruit" andNamedProperty:@"fruit" andYPosition:215 onView:self.view];
	[self createSliderAndLabel:@"Body" andNamedProperty:@"body" andYPosition:285 onView:self.view];
	
	NSLog(@"loadView");
}

- (void) createSliderAndLabel:(NSString *) name andNamedProperty:(NSString *)key andYPosition:(int) y onView: (UIView *) view {
	// Label
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, y, self.view.frame.size.width, 25)];
	[label setBackgroundColor:[UIColor clearColor]];
	[label setTextColor:[UIColor darkGrayColor]];
	[label setFont:[UIFont fontWithName:@"Baskerville" size:22]];
	[label setText:name];
	[view addSubview:label];
	
	// Slider
	SliderPageControl *slider = [[SliderPageControl alloc] initWithFrame:CGRectMake(0, y + 30, self.view.frame.size.width, 20)];
	[slider setNumberOfPages:5];
	[slider setCurrentPage:0];
	[slider setDelegate:self];
	[slider setShowsHint:YES];
	[view addSubview:slider];
	
	// change values for
}

- (void) finishSelection {
	if ([self settingsCell] != nil) {
		// hand values to settings cell.
		NSLog(@"value is handed to settingsCell...");
		//[[self settingsCell] listValueWasSelected:[NSSet setWithArray:[self selectedVarietals]]];
		[self.navigationController popViewControllerAnimated:YES];
	}
}

- (void) viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

#pragma mark sliderPageControlDelegate

- (NSString *)sliderPageController:(id)controller hintTitleForPage:(NSInteger)page {
	NSString *hintTitle = [NSString stringWithFormat:@"Hello %i", page];
	return hintTitle;
}

- (void)onPageChanged:(id)sender {
	
}

- (void)slideToCurrentPage:(bool)animated {
	
}

- (void)changeToPage:(int)page animated:(BOOL)animated {
}


@end
