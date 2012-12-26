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
		NSPredicate *predicate = [self getFetchPredicate:self.settingsCell.wine];
		NSLog(@"predicate %@", predicate);
		[self setFetchedResultsController:[Appellation fetchAllGroupedBy:@"region" withPredicate:predicate sortedBy:@"region.name,name" ascending:YES]];
		
		//sortedBy:nil works  -  @"region.name,name"
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
	if ([searchBar.text length] == 0) {
		NSLog(@"getFetchPredicate %@", withWine.country.countryID);
		search = [NSPredicate predicateWithFormat:@"(region.country.countryID == %@) || (%@ = null)", withWine.country.countryID, withWine.country.countryID];
	} else {
		NSLog(@"getFetchPredicate %@", searchBar.text);
		search = [NSPredicate predicateWithFormat:@"((region.country.countryID == %@) || (%@ = null)) AND name CONTAINS[c] %@", withWine.country.countryID, withWine.country.countryID, searchBar.text];
	}
	return search;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"AppellationCell";
    CellarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CellarTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
		if ([self showCount]) {
			[cell setShowArrow:YES];
		}
    }
	[self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id  sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
	//NSLog(@"numerOfRows in section %i is %i", section, [sectionInfo numberOfObjects]);
    return [sectionInfo numberOfObjects];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
	if([super respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
		[super tableView:tableView didSelectRowAtIndexPath:indexPath];
	}
	
	Appellation *appellation = [[super fetchedResultsController] objectAtIndexPath:indexPath];
	
	NSPredicate *searchStatement = [NSPredicate predicateWithFormat:@"appellation.appellationID == %@", appellation.appellationID];
    NSFetchedResultsController *wineSearchController = [Wine fetchAllSortedBy:@"appellation.name" ascending:YES withPredicate:searchStatement groupBy:nil delegate:self];
	
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
		NSLog(@"%i", self.fetchedResultsController.sections.count);
		
		id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
		NSString *title = [[[[sectionInfo objects] objectAtIndex:0] region] name];
		
		
		//NSLog(@"section: %i title: %@", section, title);
		return title;
	}
	//NSLog(@"returning nil!");
	return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSUInteger count = [[self.fetchedResultsController sections] count];
    return count;
}

@end
