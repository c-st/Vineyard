
#import "CharacteristicsViewController.h"
#import "UIColor+CellarColours.h"
#import "UIView+ObjectTagAdditions.h"

@interface CharacteristicsViewController ()

@end

@implementation CharacteristicsViewController

@synthesize settingsCell, characteristics, values;

- (void) loadView {
	[super loadView];
	[self.view setBackgroundColor:[UIColor cellarBeigeNoisyColour]];
	
	self.values = [[NSMutableDictionary alloc] init];
	
	// load existing values
	if (self.settingsCell.wine.characteristics != nil) {
		self.characteristics = self.settingsCell.wine.characteristics;
		// set existing values to sliders
	} else {
		self.characteristics = [Characteristics createEntity];
		//[self.characteristics setWine:self.settingsCell.wine];
	}
	
	UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle: @"Done" style:UIBarButtonItemStylePlain target:self action: @selector(finishSelection)];
	[[self navigationItem] setRightBarButtonItem:doneButton];
	

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
	
	// Sweetness, Acidity, Tannin, Fruit, Body
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
	[slider setObjectTag:key];
	[slider setNumberOfPages:5];
	[slider setCurrentPage:0];
	[slider setDelegate:self];
	[slider setShowsHint:YES];
	[view addSubview:slider];
	
	// try to load current value
	if ([self.characteristics valueForKeyPath:key] != nil) {
		//NSLog(@"value is %@", [self.characteristics valueForKeyPath:key]);
		[slider setCurrentPage:[[self.characteristics valueForKeyPath:key] intValue]];
	}
	
	[slider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void) finishSelection {
	if ([self settingsCell] != nil) {
		// hand values to settings cell.
		NSLog(@"value is handed to settingsCell...");
		
		// save
		NSString *key;
		for (key in self.values) {
			[self.characteristics setValue:[self.values valueForKeyPath:key] forKey:key];
		}
		
		[[self settingsCell] valueWasSelected:[self characteristics]];
		[self.navigationController popViewControllerAnimated:YES];
	}
}


- (void) viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

#pragma mark sliderPageControlDelegate and event handlers

- (void) valueChanged:(SliderPageControl *) slider {
	NSLog(@"value changed to %i for %@", slider.currentPage, (NSString *) slider.objectTag);
	//[self.characteristics setValue:[NSNumber numberWithInt:slider.currentPage] forKey:(NSString *) slider.objectTag];
	[self.values setObject:[NSNumber numberWithInt:slider.currentPage] forKey:(NSString *) slider.objectTag];
}

- (NSString *)sliderPageController:(id)controller hintTitleForPage:(NSInteger)page {
	NSString *title;
	switch (page) {
		case 0:
			title = @"None";
			break;
		case 1:
			title = @"Few";
			break;
		case 2:
			title = @"Medium";
			break;
		case 3:
			title = @"Medium-High";
			break;
		case 4:
			title = @"High";
			break;
		default:
			break;
	}
	return title;;
}

- (void)onPageChanged:(id)sender {
	
}

- (void)slideToCurrentPage:(bool)animated {
	
}

- (void)changeToPage:(int)page animated:(BOOL)animated {
}


@end
