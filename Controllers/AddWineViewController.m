#import "AddWineViewController.h"
#import "AbstractTableViewController.h"
#import "AppellationTableViewController.h"
#import "CountryTableViewController.h"
#import "VarietalTableViewController.h"
#import "ColourTableViewController.h"
#import "CharacteristicsViewController.h"

#import "SettingsCell.h"

#import "UIColor+CellarColours.h"


@implementation AddWineViewController

@synthesize configurableProperties, wine, tableView, scrollView, newWine, locationManager;

- (id) init {
	if ((self = [super init])) {
		// Create a new wine
		[self setWine: [Wine createEntity]];
		[self setTitle:@"Add a Wine"];
		[self setNewWine:YES];
		
		[self requestLocationUpdate];
		[self.wine setCreationTime:[NSDate date]];
	}
	
	// register observer for scrolling notifications
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:@"scrollToUITableViewCell" object:nil];
	
    return self;
}

- (id) initWithWine:(Wine *)theWine {
	if ((self = [super init])) {
		[self setWine:theWine];
		
		//[self setTitle:[NSString stringWithFormat:@"%@", theWine.name]];
		[self setTitle:@"Edit Wine"];
		[self setNewWine:NO];
	}
	
	// register observer for scrolling notifications
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:@"scrollToUITableViewCell" object:nil];
	
    return self;
}


- (void) loadView {
	[super loadView];
	
	// Cancel and save buttons
	UIBarButtonItem *cancelButton =
	[[UIBarButtonItem alloc] initWithTitle: @"Cancel" style:UIBarButtonItemStylePlain target:self action: @selector(closeWineView)];
	[[self navigationItem] setLeftBarButtonItem:cancelButton];
	
	UIBarButtonItem *saveButton =
	[[UIBarButtonItem alloc] initWithTitle: @"Save" style:UIBarButtonItemStylePlain target:self action: @selector(saveWine)];
	[[self navigationItem] setRightBarButtonItem:saveButton];
	
	// calculate height of scrollView. If new wine, also substract tab bar.
	int height = self.view.frame.size.height - 44;
	if (![self newWine]) {
		height = height - 44;
	}
	self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, height)];
	
	[scrollView setContentSize: CGSizeMake(self.view.frame.size.width, self.view.frame.size.height)];
	[scrollView setContentOffset: CGPointMake(0, -20)];
	[scrollView setContentInset:UIEdgeInsetsMake(5.0,0,0,0.0)];
	[scrollView setBackgroundColor:[UIColor cellarBeigeNoisyColour]];
	[scrollView setShowsVerticalScrollIndicator:NO];
	[scrollView setScrollEnabled:YES];
	[scrollView setUserInteractionEnabled:YES];
	
	// "Hidden" Label
	UILabel *label = [[UILabel alloc] init];
	[label setFrame:CGRectMake(10, -100, self.view.frame.size.width-20, 50)];
	[label setBackgroundColor:[UIColor clearColor]];
	[label setFont:[UIFont fontWithName:@"Snell Roundhand" size:13.0f]];
	[label setTextAlignment:NSTextAlignmentCenter];
	[label setNumberOfLines:0];
	[label setText:@"Life is too short\n to drink bad wine"];
	[scrollView addSubview:label];
	
	// Attribute Table
	self.tableView = [[UITableViewController alloc] initWithStyle:UITableViewStyleGrouped];
	float outerSpacing = 10.0f;
	
	[tableView.view setFrame:
		CGRectMake(self.view.frame.origin.x + outerSpacing,
				   self.view.frame.origin.y - 15,
				   self.view.frame.size.width - (2 * outerSpacing),
				   self.view.frame.size.height)];
	
	[tableView.tableView setScrollEnabled:NO];
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
	
	// realign different frames
	CGRect tableFrame = tableView.tableView.frame;
	tableFrame.size.height = tableView.tableView.contentSize.height;
	tableFrame.size.width = tableView.tableView.contentSize.width;
	tableView.tableView.frame = tableFrame;
	scrollView.contentSize = tableView.tableView.contentSize;
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
	
	// Country
	CountryTableViewController *countryTableViewController = [[CountryTableViewController alloc] init];
	SettingsCell *countrySettingsCell = [[SettingsCell alloc] initWithWine:[self wine] andType:DetailViewSettingsCellType andProperty:@"country" andName:@"Country" andTableViewController:countryTableViewController];
	
	[countryTableViewController setSettingsCell:countrySettingsCell];
	
	// Appellation
	AppellationTableViewController *appellationTableViewController = [[AppellationTableViewController alloc] init];
	[appellationTableViewController setShowSearchBar:YES];
	SettingsCell *appellationSettingsCell = [[SettingsCell alloc] initWithWine:[self wine] andType:DetailViewSettingsCellType andProperty:@"appellation" andName:@"Appellation" andTableViewController:appellationTableViewController];
	
	[appellationTableViewController setSettingsCell:appellationSettingsCell];
	
	// Vintage
	SettingsCell *vintageSettingsCell = [[SettingsCell alloc] initWithWine:[self wine] andType:YearSettingsCellType andProperty:@"vintage" andName:@"Vintage"];
	
	// Colour
	ColourTableViewController *colourTableViewController = [[ColourTableViewController alloc] init];
	SettingsCell *colourSettingsCell = [[SettingsCell alloc] initWithWine:[self wine] andType:DetailViewSettingsCellType andProperty:@"colour" andName:@"Colour" andTableViewController:colourTableViewController];
	[colourTableViewController setSettingsCell:colourSettingsCell];
	
	// Varietal
	VarietalTableViewController *varietalTableViewController = [[VarietalTableViewController alloc] init];
	[varietalTableViewController setPickMode:YES];
	[varietalTableViewController setSelectedVarietals:[[[wine varietals] allObjects] mutableCopy]];
	SettingsCell *varietalSettingsCell = [[SettingsCell alloc] initWithWine:[self wine] andType:DetailViewSettingsCellType andProperty:@"varietals" andName:@"Varietals" andTableViewController:varietalTableViewController];
	
	[varietalTableViewController setSettingsCell:varietalSettingsCell];
	
	// Rating
	SettingsCell *ratingSettingsCell = [[SettingsCell alloc] initWithWine:[self wine] andType:RatingSettingsCellType andProperty:@"rating" andName:@"Rating"];
	
	// Price
	SettingsCell *priceSettingsCell = [[SettingsCell alloc] initWithWine:[self wine] andType:NumberSettingsCellType andProperty:@"price" andName:@"Price"];
	
	// Alcohol content
	SettingsCell *alcoholContentSettingsCell = [[SettingsCell alloc] initWithWine:[self wine] andType:AlcoholSettingsCellType andProperty:@"alcoholContent" andName:@"Alcohol content"];
	
	// Serving temperature
	SettingsCell *servingTemperatureSettingsCell = [[SettingsCell alloc] initWithWine:[self wine] andType:RangeSettingsCellType andProperty:@"servingTemperature" andName:@"Serving Temperature"];
	
	// TODO Characteristics
	CharacteristicsViewController *characteristicsViewController = [[CharacteristicsViewController alloc] init];
	// set current characteristics...
	
	SettingsCell *characteristicsSettingsCell = [[SettingsCell alloc] initWithWine:[self wine] andType:DetailViewSettingsCellType andProperty:@"varietals" andName:@"Characteristics" andViewController:characteristicsViewController];
	[characteristicsViewController setSettingsCell:characteristicsSettingsCell];
	
	// TODO Tags
	SettingsCell *tags = [[SettingsCell alloc] initWithWine:[self wine] andType:DetailViewSettingsCellType andProperty:@"varietals" andName:@"Tags" andTableViewController:varietalTableViewController];
	
	// TODO Notes
	SettingsCell *notes = [[SettingsCell alloc] initWithWine:[self wine] andType:DetailViewSettingsCellType andProperty:@"varietals" andName:@"Notes" andTableViewController:varietalTableViewController];
	
	// TODO: Tags, Notes, Tasting notes, barrel time
	
	NSArray *basics = nil;
	
	if (wine.country != nil) {
		basics = @[nameSettingsCell,
				  countrySettingsCell,
			 appellationSettingsCell];
	} else {
		basics = @[nameSettingsCell,
				  countrySettingsCell];
	}
	
	
	NSArray *varietal = @[vintageSettingsCell, colourSettingsCell, varietalSettingsCell]; // barrel time
	
	NSArray *rating = @[ratingSettingsCell, priceSettingsCell];
	
	NSArray *tasting = @[alcoholContentSettingsCell, servingTemperatureSettingsCell];
	
	NSArray *wineNotes = @[characteristicsSettingsCell, tags, notes];
	
	[self setConfigurableProperties:@[basics,
									 varietal,
									 tasting,
									 rating,
									 wineNotes
									 ]];
	
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

	if (selectedCell.settingsTableViewController != nil) {
		[[self navigationController] pushViewController:selectedCell.settingsTableViewController animated:YES];
	} else if (selectedCell.viewController != nil) {
		[[self navigationController] pushViewController:selectedCell.viewController animated:YES];
	}
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

#pragma mark
#pragma mark Location

- (void) requestLocationUpdate {
	self.locationManager = [[CLLocationManager alloc] init];
	locationManager.delegate = self;
	locationManager.distanceFilter = kCLDistanceFilterNone;
	locationManager.desiredAccuracy = kCLLocationAccuracyBest;
	[locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    NSLog(@"Location %f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
	
	// if a new wine is created, set location.
	if ([self newWine]) {
		Location *loc = [Location createEntity];
		[loc setLatitudeValue:newLocation.coordinate.latitude];
		[loc setLongitudeValue:newLocation.coordinate.longitude];
		[self.wine setLocation:loc];
	}
	[manager stopUpdatingLocation];
}

#pragma mark
#pragma mark Handle notifications for scrolling requests

-(void)handleNotification:(NSNotification *)pNotification {
	//NSLog(@"received message: %@",(NSString*)[pNotification object]);
	if ([[pNotification object] isKindOfClass:UITableViewCell.class]) {
		UITableViewCell *cell = (UITableViewCell *) [pNotification object];
		
		// TODO: get position of cell
		NSIndexPath *indexPath = [self.tableView.tableView indexPathForCell:cell];
		CGRect rectInTableView = [self.tableView.tableView rectForRowAtIndexPath:indexPath];
		CGRect rectInSuperview = [self.tableView.tableView convertRect:rectInTableView toView:[[self.tableView.tableView superview] superview]];
		
		NSLog(@"%f", rectInSuperview.origin.y);
		
		[UIView animateWithDuration:0.2 animations:^{
			if (rectInSuperview.origin.y >= 265) {
				//self.scrollView.contentOffset = CGPointMake(0, rectInSuperview.origin.y - 265);
			}
			
			[self.scrollView scrollRectToVisible:rectInSuperview animated:YES];
			
		}];
	}
}


@end
