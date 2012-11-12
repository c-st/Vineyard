
#import "AddWineViewController.h"
#import "AddWineTableViewController.h"
#import "SettingsCell.h"
#import "AppellationTableViewController.h"

#import "Appellation.h"
#import "Wine.h"

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
	[scrollView setBackgroundColor:[UIColor colorWithRed:(234.0f/255.0f) green:(227.0f/255.0f) blue:(217.0f/255.0f) alpha:1.0f]];
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

-(void) viewDidAppear:(BOOL)animated {
	NSLog(@"did appear");
	[tableView.tableView reloadData];
}

-(void) viewDidLoad {
	[super viewDidLoad];
	[self setTitle:@"Add a Wine"];
	
	// Create a new wine
	wine = [Wine createEntity];
	
	// Build setting cells
	
	// name
	SettingsCell *nameSettingsCell = [[SettingsCell alloc] initWithWine:wine andType:TextSettingsCellType andProperty:@"name" andName:@"Name"];
	
	// appellation
	NSFetchedResultsController *appellationsController = [Appellation fetchAllSortedBy:@"name" ascending:YES withPredicate:nil groupBy:nil delegate:nil];
	AppellationTableViewController *appellationTableViewController = [[AppellationTableViewController alloc] initWithFetchedResultsController:appellationsController];
	SettingsCell *appellationSettingsCell = [[SettingsCell alloc] initWithWine:wine andType:DetailViewSettingsCellType andProperty:@"appellation" andName:@"Appellation" andViewController:appellationTableViewController];
	[appellationTableViewController setSettingsCell:appellationSettingsCell];
	
	// create appellation view controller
	//NSPredicate *searchStatement = [NSPredicate predicateWithFormat:@"region.regionID == %@", region.regionID];
    
	
	
	[self setConfigurableProperties:[NSArray arrayWithObjects:
									nameSettingsCell,
									appellationSettingsCell,
									[[SettingsCell alloc] initWithWine:wine andType:DetailViewSettingsCellType andProperty:@"country" andName:@"Country"],
									  nil]];
}

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
	[[self navigationController] pushViewController:selectedCell.settingsViewController animated:YES];
}

- (void) saveWine {
	NSLog(@"saving entry... %@", wine);
	[[NSManagedObjectContext defaultContext] saveNestedContexts];
	[self dismissViewControllerAnimated:YES completion:nil];
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
