#import "AddWineViewController.h"
#import "AbstractTableViewController.h"
#import "AppellationTableViewController.h"
#import "CountryTableViewController.h"
#import "VarietalTableViewController.h"
#import "ColourTableViewController.h"

#import "SettingsCell.h"

#import "UIColor+CellarColours.h"

#import "Appellation.h"
#import "Wine.h"
#import "Country.h"


@implementation AddWineViewController

@synthesize configurableProperties, wine, tableView, newWine;

- (id) init {
	if ((self = [super init])) {
		// Create a new wine
		[self setWine: [Wine createEntity]];
		[self setTitle:@"Add a Wine"];
		[self setNewWine:YES];
	}
    return self;
}

- (id) initWithWine:(Wine *)theWine {
	if ((self = [super init])) {
		[self setWine:theWine];
		
		//[self setTitle:[NSString stringWithFormat:@"%@", theWine.name]];
		[self setTitle:@"Edit Wine"];
		
		[self setNewWine:NO];
	}
    return self;
}

- (void) loadView {
	[super loadView];
	[self.view setBackgroundColor:[UIColor cellarBeigeColour]];
	
	// Cancel and save buttons
	UIBarButtonItem *cancelButton =
	[[UIBarButtonItem alloc] initWithTitle: @"Cancel" style:UIBarButtonItemStylePlain target:self action: @selector(closeWineView)];
	[[self navigationItem] setLeftBarButtonItem:cancelButton];
	
	UIBarButtonItem *saveButton =
	[[UIBarButtonItem alloc] initWithTitle: @"Save" style:UIBarButtonItemStylePlain target:self action: @selector(saveWine)];
	[[self navigationItem] setRightBarButtonItem:saveButton];

	// Scroll view
	CGRect bound = [[UIScreen mainScreen] bounds];
	
	UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(bound.origin.x,
																			  bound.origin.y,
																			  bound.size.width,
																			  bound.size.height)];
	
	[scrollView setContentSize: CGSizeMake(self.view.frame.size.width, self.view.frame.size.height)];
	[scrollView setContentOffset: CGPointMake(0, 0)];
	[scrollView setContentInset:UIEdgeInsetsMake(21.0,0,0,0.0)];
	[scrollView setBackgroundColor:[UIColor cellarBeigeColour]];
	[scrollView setShowsVerticalScrollIndicator:NO];
	[scrollView setScrollEnabled:YES];
	[scrollView setUserInteractionEnabled:YES];
	
	// "Hidden" Label
	UILabel *label = [[UILabel alloc] init];
	[label setFrame:CGRectMake(10, -100, bound.size.width-20, 50)];
	[label setBackgroundColor:[UIColor clearColor]];
	[label setFont:[UIFont fontWithName:@"Snell Roundhand" size:13.0f]];
	[label setTextAlignment:NSTextAlignmentCenter];
	[label setNumberOfLines:0];
	[label setText:@"Life is too short\n to drink bad wine"];
	[scrollView addSubview:label];
	
	// Attribute Table
	self.tableView = [[UITableViewController alloc] initWithStyle:UITableViewStyleGrouped];
	float outerSpacing = 10.0f;
	[tableView.view setFrame:CGRectMake(bound.origin.x+outerSpacing, bound.origin.y, bound.size.width- 2 * outerSpacing, 400)];
	[tableView.tableView setDelegate:self];
	[tableView.tableView setDataSource:self];
	[tableView.tableView setBackgroundView:nil];
	[scrollView addSubview:tableView.view];
	
	// Tap recognizer to hide keyboard
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
	[tap setCancelsTouchesInView:NO];
	[scrollView addGestureRecognizer:tap];
	
	[self.view addSubview:scrollView];
}

/**
 View is about to appear. Set configurable properties and update settings table.
 */
-(void) viewWillAppear:(BOOL)animated {
	[self updateAndSetConfigurableProperties];
	[self updateViewFromValidation];
	[tableView.tableView reloadData];
}

/**
 Build setting cells.
 */
-(void) viewDidLoad {
	[super viewDidLoad];
}

-(void) updateAndSetConfigurableProperties {
	// Name
	SettingsCell *nameSettingsCell = [[SettingsCell alloc] initWithWine:[self wine] andType:TextSettingsCellType andProperty:@"name" andName:@"Name"];
	
	// Appellation
	AppellationTableViewController *appellationTableViewController = [[AppellationTableViewController alloc] init];
	[appellationTableViewController setShowSearchBar:YES];
	SettingsCell *appellationSettingsCell = [[SettingsCell alloc] initWithWine:[self wine] andType:DetailViewSettingsCellType andProperty:@"appellation" andName:@"Appellation" andViewController:appellationTableViewController];
	
	[appellationTableViewController setSettingsCell:appellationSettingsCell];
	
	// Country
	CountryTableViewController *countryTableViewController = [[CountryTableViewController alloc] init];
	SettingsCell *countrySettingsCell = [[SettingsCell alloc] initWithWine:[self wine] andType:DetailViewSettingsCellType andProperty:@"country" andName:@"Country" andViewController:countryTableViewController];
	
	[countryTableViewController setSettingsCell:countrySettingsCell];
	
	// Colour
	ColourTableViewController *colourTableViewController = [[ColourTableViewController alloc] init];
	SettingsCell *colourSettingsCell = [[SettingsCell alloc] initWithWine:[self wine] andType:DetailViewSettingsCellType andProperty:@"colour" andName:@"Colour" andViewController:colourTableViewController];
	[colourTableViewController setSettingsCell:colourSettingsCell];
	
	
	// Varietal
	VarietalTableViewController *varietalTableViewController = [[VarietalTableViewController alloc] init];
	[varietalTableViewController setPickMode:YES];
	[varietalTableViewController setSelectedVarietals:[[[wine varietals] allObjects] mutableCopy]];
	SettingsCell *varietalSettingsCell = [[SettingsCell alloc] initWithWine:[self wine] andType:DetailViewSettingsCellType andProperty:@"varietals" andName:@"Varietals" andViewController:varietalTableViewController];
	
	[varietalTableViewController setSettingsCell:varietalSettingsCell];
	
	NSArray *basics = nil;
	
	if (wine.country != nil) {
		basics = [NSArray arrayWithObjects:nameSettingsCell,
				  countrySettingsCell,
				  appellationSettingsCell,
				  nil];
	} else {
		basics = [NSArray arrayWithObjects:nameSettingsCell,
				  countrySettingsCell,
				  nil];
	}
	
	
	NSArray *varietal = [NSArray arrayWithObjects:
							colourSettingsCell,
							varietalSettingsCell,
							nil];
	
	[self setConfigurableProperties:[NSArray arrayWithObjects:
									 basics,
									 varietal,
									 nil]];
	
}

- (void) updateViewFromValidation {
	[self.navigationItem.rightBarButtonItem setEnabled:[self.wine isValid]];
}


#pragma mark
#pragma mark Table view delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.configurableProperties count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [[self.configurableProperties objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	return [[[self configurableProperties] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
	SettingsCell *selectedCell = [[[self configurableProperties] objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
	[selectedCell updatePredicateAndRefetch];

	[[self navigationController] pushViewController:selectedCell.settingsViewController animated:YES];
}

#pragma mark
#pragma mark Saving wine

- (void) saveWine {
	if ([wine isValid]) {
		NSLog(@"saving entry... %@", wine);
		[wine extendWine];
		[[NSManagedObjectContext defaultContext] saveNestedContexts];
		if ([self newWine]) {
			[self dismissViewControllerAnimated:YES completion:nil];
		} else {
			[UIView animateWithDuration:0.5 animations:^{
				[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO];
			} completion:^(BOOL finished){}];
			[[self navigationController] popViewControllerAnimated:NO];
		}
	} else {
		// TODO: visual feedback!
		NSLog(@"Wine is not valid!");
	}
}

-(void) closeWineView {
	[[NSManagedObjectContext defaultContext] rollback];
	if ([self newWine]) {
		[self dismissViewControllerAnimated:YES completion:nil];
	} else {
		[UIView animateWithDuration:0.5 animations:^{
			[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO];
		} completion:^(BOOL finished){}];
		[[self navigationController] popViewControllerAnimated:NO];
	}
}

-(void)dismissKeyboard {
	[self.view endEditing:YES];
}

@end
