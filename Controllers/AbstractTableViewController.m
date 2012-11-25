#import "UIColor+CellarColours.h"

#import "AbstractTableViewController.h"

#import "WineTableViewController.h"
#import "SettingsCell.h"

#import <QuartzCore/QuartzCore.h>

@interface AbstractTableViewController ()

@end

@implementation AbstractTableViewController

@synthesize settingsCell, showCount, showSearchBar;
@synthesize fetchedResultsController = fetchedResultsController;
@synthesize managedObjectContext = _managedObjectContext;

#pragma mark
#pragma mark Initialization

// deprecated. set itself on view controller.
- (id) initWithFetchedResultsController:(NSFetchedResultsController *)controller {
    if ((self = [super init])) {
        fetchedResultsController = controller;
		[self setShowCount:NO];
		[self setShowSearchBar:NO];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	if (self.showSearchBar) {
		searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
		[searchBar setTintColor:[UIColor cellarWineRedColour]];
		[searchBar setDelegate:self];
		self.tableView.tableHeaderView = searchBar;
		self.tableView.contentOffset = CGPointMake(0, self.tableView.tableHeaderView.frame.size.height);
	}
	[fetchedResultsController setDelegate:self];
}

-(void) viewWillAppear:(BOOL)animated {
	[self.tableView setContentOffset:self.showSearchBar ? CGPointMake(0, 44) : CGPointMake(0, 0) animated:YES];
	[self.fetchedResultsController.fetchRequest setFetchBatchSize:50];
	
	NSError *error;
	if (![[self fetchedResultsController] performFetch:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	}
    [self.tableView reloadData];
}

- (void)viewDidUnload {
    self.fetchedResultsController = nil;
}

#pragma mark
#pragma mark UISearchBar delegate methods

-(void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self filterContentForSearch:searchText];
}

-(void) searchBarSearchButtonClicked:(UISearchBar *)theSearchBar {
    [self filterContentForSearch:theSearchBar.text];
    [self.view endEditing:YES];
}

- (void) filterContentForSearch:(NSString *) searchText {
	[self.fetchedResultsController.fetchRequest setPredicate:[self getFetchPredicate:self.settingsCell.wine]];
	NSError *error;
	[self.fetchedResultsController performFetch:&error];
	[self.tableView reloadData];
}

#pragma mark
#pragma mark NSFetchedResultsController delegate methods

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
	NSLog(@"controllerWillChangeContent");
    [self.tableView beginUpdates];
}

- (void) controllerDidChangeContent:(NSFetchedResultsController *)controller {
	NSLog(@"controllerDidChangeContent");
	[self.tableView reloadData];
	[self.tableView endUpdates];
}

-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
	
	NSLog(@"didChangeObject");
	
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                                  withRowAnimation:UITableViewRowAnimationTop];
            break;
			
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                                  withRowAnimation:UITableViewRowAnimationTop];
            break;
			
        case NSFetchedResultsChangeUpdate:
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                                  withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

/**
 Build count predicate to count wines for a specific row.
 */
- (NSPredicate *) buildCountPredicateForObject:(NSManagedObject *)object {
	return nil;
}

#pragma mark
#pragma mark Table view delegate methods

- (UIView *) tableView:(UITableView *)tableView customViewForHeaderInSection:(NSInteger)section {
	NSString *title = [self tableView:tableView titleForHeaderInSection:section];
	if ([title length] == 0) {
		return nil;
	}
	UIView* sectionHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 20)];
    sectionHead.backgroundColor = [[UIColor cellarWineRedColour] colorWithAlphaComponent:0.8f];
    sectionHead.userInteractionEnabled = YES;
    sectionHead.tag = section;

	UILabel *sectionText = [[UILabel alloc] initWithFrame:CGRectMake(10, 1, tableView.bounds.size.width - 10, 20)];
    sectionText.text = title;
    sectionText.backgroundColor = [UIColor clearColor];
    sectionText.textColor = [UIColor whiteColor];
    sectionText.shadowColor = [UIColor darkGrayColor];
    sectionText.shadowOffset = CGSizeMake(0,1);
    sectionText.font = [UIFont boldSystemFontOfSize:18];
	
	[sectionHead addSubview:sectionText];
	
	return sectionHead;
}

- (UIView *) buildAccessoryViewFromPredicate:(NSPredicate *)searchPredicate andObject:(NSManagedObject *) object {
	int count = [Wine countOfEntitiesWithPredicate:searchPredicate];
	
	// TODO make this badge look more like a button
	if (count > 0) {
		SSBadgeView *badgeView = [[SSBadgeView alloc] initWithFrame:CGRectMake(0, 5, 55, 20)];
		badgeView.backgroundColor = [UIColor clearColor];
		[badgeView setBadgeColor:[[UIColor cellarWineRedColour] colorWithAlphaComponent:0.65f]];
		badgeView.badgeAlignment = SSBadgeViewAlignmentCenter;
		[badgeView.textLabel setText:[NSString stringWithFormat:@"%i", count]];
		badgeView.userInteractionEnabled = NO;
		badgeView.exclusiveTouch = NO;
		
		badgeView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
		badgeView.layer.shadowRadius = 2.0f;
		badgeView.layer.shadowOpacity = 0.9f;
		badgeView.layer.masksToBounds = NO;
		
		UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
		[button setBackgroundColor:[UIColor clearColor]];
		[button setFrame:CGRectMake(0, 0, 60, 30)];
		[button addSubview:badgeView];
		//[button setShowsTouchWhenHighlighted:YES];
		
		[button addTarget:self action:@selector(countButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
		[button setTag:[[self fetchedResultsController] indexPathForObject:object].row]; // store position in tag of button
		return button;
	} else {
		return nil;
	}
}

- (void) countButtonClicked:(UIButton *) sender {
	// fetch selected row object
	NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:[NSIndexPath indexPathForRow:sender.tag inSection:0]];
	
	NSFetchedResultsController *wineSearchController = [Wine fetchAllSortedBy:@"name" ascending:YES withPredicate:[self buildCountPredicateForObject:object] groupBy:nil delegate:self];
	
	WineTableViewController *wineTableViewController = [[WineTableViewController alloc] initWithFetchedResultsController:wineSearchController];
	[wineTableViewController setTitle:[object valueForKey:@"name"]];
	[wineTableViewController setShowCount:NO];
	[[self navigationController] pushViewController:wineTableViewController animated:YES];
}


/**
 If not customized, assume that we are a value pick controller. Return value to our settingsCell.
 If customized, take care to also call this method from the child methods:
	if([super respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
		[super tableView:tableView didSelectRowAtIndexPath:indexPath];
	}
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
	if ([self settingsCell] != nil) {
		// hand value to settings cell.
		NSLog(@"value is handed to settingsCell...");
		[[self settingsCell] valueWasSelected:[[self fetchedResultsController] objectAtIndexPath:indexPath]];
		[self.navigationController popViewControllerAnimated:YES];
	}
}

// Can/Should be customized in subclass

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id  sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

/**
 Implement, if the results from the fetchController should be filtered.
 */
- (NSPredicate*) getFetchPredicate:(Wine *)withWine {
	return nil;
}

@end
