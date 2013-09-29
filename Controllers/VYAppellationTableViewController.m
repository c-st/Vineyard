//
//  VYAppellationTableViewController.m
//  Vineyard
//
//  Created by Christian Stangier on 27.09.13.
//  Copyright (c) 2013 Christian Stangier. All rights reserved.
//

#import "VYAppellationTableViewController.h"

@interface VYAppellationTableViewController ()
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@end

@implementation VYAppellationTableViewController

#pragma mark
#pragma mark Initialization

- (void)viewDidLoad {
    [super viewDidLoad];
	[[self fetchedResultsController] setDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.searchBar setDelegate:self];
}

- (void) viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[self updateAndRefetch]; // is a bit too late, but not messing up animation.
}


#pragma mark
#pragma mark Table View Data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"AppellationCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
	Appellation *appellation = [[super fetchedResultsController] objectAtIndexPath:indexPath];
	
    [[cell textLabel] setText:[appellation name]];
	
	// set browse table view cell specifics
	if ([cell isKindOfClass:[VYBrowseTableViewCell class]]) {
		VYBrowseTableViewCell *browseCell = (VYBrowseTableViewCell *) cell;
		[[browseCell wineCountButton] setTitle:[NSString stringWithFormat:@"%i", [Wine countOfEntitiesWithPredicate:[self buildCountPredicateForObject:appellation]]] forState:UIControlStateNormal];
		[[browseCell wineCountButton] setIndexPath:indexPath];
		cell = browseCell;
	}
	
    return cell;
}

#pragma mark
#pragma mark UISearchBar delegate methods

-(void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self filterContentForSearch:searchText];
}

-(void) searchBarSearchButtonClicked:(UISearchBar *)theSearchBar {
	NSLog(@"searchBarbuttonc");
    [self filterContentForSearch:theSearchBar.text];
    [self.view endEditing:YES];
}

- (void) filterContentForSearch:(NSString *) searchText {
	if ([[self.navigationController.viewControllers objectAtIndex:0] isKindOfClass:[VYAddEditWineViewController class]]) {
		NSLog(@"search for: %@", self.searchBar.text);
		VYAddEditWineViewController *addEditWineController = [self.navigationController.viewControllers objectAtIndex:0];
		
		NSPredicate *search = ([self.searchBar.text length] > 0) ? [NSPredicate predicateWithFormat:
							   @"((region.country.countryID == %@) || (%@ = null)) AND name CONTAINS[c] %@",
							   addEditWineController.wine.country.countryID, addEditWineController.wine.country.countryID,
							   self.searchBar.text]
								: [NSPredicate predicateWithFormat: @"(region.country.countryID == %@) || (%@ = null)",
								addEditWineController.wine.country.countryID, addEditWineController.wine.country.countryID];
		
		[self.fetchedResultsController.fetchRequest setPredicate:search];
		NSError *error;
		[self.fetchedResultsController performFetch:&error];
		[self.tableView reloadData];
	}
}


#pragma mark
#pragma mark GUI

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if ([[self.fetchedResultsController sections] count] > 1) {
		id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
		Appellation *appellation = [sectionInfo objects][0]; // use first item from list
		return [[appellation region] name];
	}
	return nil;
}

#pragma mark
#pragma mark View Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	NSLog(@"prepareForSegue %@ -> %@", self, [segue destinationViewController]);
	NSIndexPath *path = [self.tableView indexPathForSelectedRow];
	Appellation *appellation = [[super fetchedResultsController] objectAtIndexPath:path];
	if (appellation != nil) {
		if ([[segue destinationViewController] isKindOfClass:[VYAddEditWineViewController class]]) {
			VYAddEditWineViewController *addEditWineController = [segue destinationViewController];
			[[addEditWineController wine] setAppellation:appellation];
		}
	}
	
	// Navigation to WineTableView from count button
	if ([[segue destinationViewController] isKindOfClass:[VYWineTableViewController class]]) {
		VYWineTableViewController *wineTableViewController = [segue destinationViewController];
		if ([sender isKindOfClass:[VYIndexPathButton class]]) {
			VYIndexPathButton *button = sender;
			NSIndexPath *path = [button indexPath];
			NSFetchedResultsController *findWinesRC = [Wine fetchAllSortedBy:@"name" ascending:YES withPredicate:[self buildCountPredicateForObject:[self.fetchedResultsController objectAtIndexPath:path]] groupBy:nil delegate:self];
			[wineTableViewController setFetchedResultsController:findWinesRC];
		} else if ([sender isKindOfClass:[UITableViewCell class]]) {
			NSIndexPath * path = [self.tableView indexPathForCell:sender];
			NSFetchedResultsController *findWinesRC = [Wine fetchAllSortedBy:@"name" ascending:YES withPredicate:[self buildCountPredicateForObject:[self.fetchedResultsController objectAtIndexPath:path]] groupBy:nil delegate:self];
			[wineTableViewController setFetchedResultsController:findWinesRC];
			[wineTableViewController setPresetData:[self.fetchedResultsController objectAtIndexPath:path]];
		}
		
	}
}

#pragma mark
#pragma mark Methods declared at superclass

- (NSPredicate *) buildCountPredicateForObject:(NSManagedObject *)object {
	Appellation* appellation = (Appellation *) object;
	return [NSPredicate predicateWithFormat:@"(appellation.appellationID == %@)", appellation.appellationID];
}


@end
