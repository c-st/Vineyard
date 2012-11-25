#import "AppellationTableViewController.h"

#import "Appellation.h"
#import "Region.h"
#import "SettingsCell.h"

#import "WineTableViewController.h"

@interface AppellationTableViewController ()

@end

@implementation AppellationTableViewController

-(void) viewDidLoad {
	[super viewDidLoad];
}

-(void) viewWillAppear:(BOOL)animated {
	if (self.settingsCell.wine != nil) {
		[self setFetchedResultsController:[Appellation fetchAllGroupedBy:@"region" withPredicate:[self getFetchPredicate:self.settingsCell.wine] sortedBy:@"region.name" ascending:YES]];
		
	}
	[super viewWillAppear:animated];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Appellation *appellation = [[super fetchedResultsController] objectAtIndexPath:indexPath];
    cell.textLabel.text = appellation.name;
	
	if ([self showCount]) {
		// count wines
		cell.accessoryView = [self buildAccessoryViewFromPredicate:[self buildCountPredicateForObject:appellation] andObject:appellation andIndexPath:indexPath];
	}
}

- (NSPredicate *) buildCountPredicateForObject:(NSManagedObject *)object {
	Appellation* appellation = (Appellation *) object;
	return [NSPredicate predicateWithFormat:@"(appellation.appellationID == %@)", appellation.appellationID];
}

/**
 Only display appellations that match the current country. Return all, if no country is set.
*/
- (NSPredicate*) getFetchPredicate:(Wine *)withWine {
	NSPredicate *search;
	NSLog(@"getFetchPredicate %@", searchBar.text);
	if ([searchBar.text length] == 0) {
		search = [NSPredicate predicateWithFormat:@"(region.country.countryID == %@) || (%@ = null)", withWine.country.countryID, withWine.country.countryID];
	} else {
		search = [NSPredicate predicateWithFormat:@"((region.country.countryID == %@) || (%@ = null)) AND name CONTAINS[c] %@", withWine.country.countryID, withWine.country.countryID, searchBar.text];
	}
	return search;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
	[self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id  sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
	if([super respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
		[super tableView:tableView didSelectRowAtIndexPath:indexPath];
	}
	
	Appellation *appellation = [[super fetchedResultsController] objectAtIndexPath:indexPath];
	
	NSPredicate *searchStatement = [NSPredicate predicateWithFormat:@"appellation.appellationID == %@", appellation.appellationID];
    NSFetchedResultsController *wineSearchController = [Wine fetchAllSortedBy:@"name" ascending:YES withPredicate:searchStatement groupBy:nil delegate:self];
	
	WineTableViewController *wineTableViewController = [[WineTableViewController alloc] initWithFetchedResultsController:wineSearchController];
	
	[wineTableViewController setTitle:appellation.name];
	[wineTableViewController setShowCount:NO];
	[[self navigationController] pushViewController:wineTableViewController animated:YES];
}

#pragma mark
#pragma mark Delegate methods and logic for sections

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	if ([[self.fetchedResultsController sections] count] > 1) {
		return [self tableView:tableView customViewForHeaderInSection:section];
	}
	return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	if ([[self.fetchedResultsController sections] count] == 1) {
		return 0;
	}
    return 22;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if ([[self.fetchedResultsController sections] count] > 1) {
		id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
		return [[[[sectionInfo objects] objectAtIndex:0] region] name];
	}
	return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSUInteger count = [[self.fetchedResultsController sections] count];
    return count;
}

@end
