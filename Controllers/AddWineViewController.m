
#import "AddWineViewController.h"
#import "AddWineTableViewController.h"
#import "AbstractTableViewController.h"
#import "SettingsCell.h"

#import "AppellationTableViewController.h"
#import "CountryTableViewController.h"

#import "UIColor+CellarColours.h"

#import "Appellation.h"
#import "Wine.h"
#import "Country.h"

@interface AddWineViewController ()

@end

@implementation AddWineViewController

@synthesize configurableProperties, wine, tableView;

-(void) loadView {
	[super loadView];
	CGRect bound = [[UIScreen mainScreen] bounds];
	
	UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(bound.origin.x,
																			  bound.origin.y,
																			  bound.size.width,
																			  bound.size.height)];
	
	[scrollView setContentSize: CGSizeMake(self.view.frame.size.width, self.view.frame.size.height)];
	[scrollView setContentOffset: CGPointMake(0, 0)];
	
	[scrollView setContentInset:UIEdgeInsetsMake(21.0,0,0,0.0)];
	// 234 227 217
	[scrollView setBackgroundColor:[UIColor cellarBeigeColour]];
	scrollView.showsVerticalScrollIndicator=NO;
	scrollView.scrollEnabled=YES;
	scrollView.userInteractionEnabled=YES;
	
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
	self.tableView = [[AddWineTableViewController alloc] init];
	[tableView.tableView setDelegate:self];
	[tableView.tableView setDataSource:self];
	[scrollView addSubview:tableView.view];
	
	// Tap recognizer to hide keyboard
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
	[tap setCancelsTouchesInView:NO];
	[scrollView addGestureRecognizer:tap];
	
	[self.view addSubview:scrollView];
}

-(void) viewWillAppear:(BOOL)animated {
	[tableView.tableView reloadData];
}
/**
 Build setting cells.
 */
-(void) viewDidLoad {
	[super viewDidLoad];
	[self setTitle:@"Add a Wine"];
	
	// Create a new wine
	wine = [Wine createEntity];
	
	// Name
	SettingsCell *nameSettingsCell = [[SettingsCell alloc] initWithWine:wine andType:TextSettingsCellType andProperty:@"name" andName:@"Name"];
	
	// Appellation
	AppellationTableViewController *appellationTableViewController = [[AppellationTableViewController alloc] init];
	
	SettingsCell *appellationSettingsCell = [[SettingsCell alloc] initWithWine:wine andType:DetailViewSettingsCellType andProperty:@"appellation" andName:@"Appellation" andViewController:appellationTableViewController];
	
	[appellationTableViewController setSettingsCell:appellationSettingsCell];
	
	// Country
	CountryTableViewController *countryTableViewController = [[CountryTableViewController alloc] init];
	
	SettingsCell *countrySettingsCell = [[SettingsCell alloc] initWithWine:wine andType:DetailViewSettingsCellType andProperty:@"country" andName:@"Country" andViewController:countryTableViewController];
	
	[countryTableViewController setSettingsCell:countrySettingsCell];
	
	
	[self setConfigurableProperties:[NSArray arrayWithObjects:
									nameSettingsCell,
									countrySettingsCell,
									appellationSettingsCell,
									nil]];
}


#pragma mark
#pragma mark Table view delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self configurableProperties] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	return [[self configurableProperties] objectAtIndex:indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
	SettingsCell *selectedCell = [[self configurableProperties] objectAtIndex:indexPath.row];
	[selectedCell updatePredicateAndRefetch];

	[[self navigationController] pushViewController:selectedCell.settingsViewController animated:YES];
}

#pragma mark
#pragma mark Saving wine

- (void) saveWine {
	if ([wine isValid]) {
		NSLog(@"saving entry... %@", wine);
		[[NSManagedObjectContext defaultContext] saveNestedContexts];
		[self dismissViewControllerAnimated:YES completion:nil];
	} else {
		// TODO: visual feedback!
		NSLog(@"Wine is not valid!");
	}
}

-(void) closeWineView:(id *) sender {
	NSLog(@"throwing wine away..");
	[wine deleteEntity];
	[self dismissViewControllerAnimated:YES completion:nil];
}

-(void)dismissKeyboard {
	[self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
