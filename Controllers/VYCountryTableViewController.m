//
//  VYCountryTableViewController.m
//  Vineyard
//
//  Created by Christian Stangier on 27.09.13.
//  Copyright (c) 2013 Christian Stangier. All rights reserved.
//

#import "VYCountryTableViewController.h"

@interface VYCountryTableViewController ()

@end

@implementation VYCountryTableViewController

#pragma mark
#pragma mark Initialization

- (void)viewDidLoad {
    [super viewDidLoad];
	[self setFetchedResultsController:
	 [Country fetchAllSortedBy:@"name" ascending:YES withPredicate:nil groupBy:nil delegate:nil]];
	[[self fetchedResultsController] setDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];

}

- (void) viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[self updateAndRefetch]; // is a bit too late, but not messing up animation.
}

#pragma mark
#pragma mark Table View Data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CountryCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
	Country *country = [[super fetchedResultsController] objectAtIndexPath:indexPath];
    [[cell textLabel] setText:[country name]];
	
	// set browse table view cell specifics
	if ([cell isKindOfClass:[VYBrowseTableViewCell class]]) {
		VYBrowseTableViewCell *browseCell = (VYBrowseTableViewCell *) cell;
		[[browseCell wineCountButton] setTitle:[NSString stringWithFormat:@"%i", [Wine countOfEntitiesWithPredicate:[self buildCountPredicateForObject:country]]] forState:UIControlStateNormal];
		[[browseCell wineCountButton] setIndexPath:indexPath];
		cell = browseCell;
	}

    return cell;
}
    
	
#pragma mark
#pragma mark GUI

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}


#pragma mark
#pragma mark View Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	NSLog(@"prepareForSegue %@ -> %@", self, [segue destinationViewController]);
	NSIndexPath *path = [self.tableView indexPathForSelectedRow];
	Country *country = [[super fetchedResultsController] objectAtIndexPath:path];
	
	if (country != nil) {
		if ([[segue destinationViewController] isKindOfClass:[VYRegionTableViewController class]]) {
			VYRegionTableViewController *regionTableViewController = [segue destinationViewController];
			// find all regions from selected country
			NSPredicate *searchStatement =
				[NSPredicate predicateWithFormat:@"country.countryID == %@", country.countryID];
			NSFetchedResultsController *regionsController = [Region fetchAllSortedBy:@"name" ascending:YES withPredicate:searchStatement groupBy:nil delegate:regionTableViewController];
			[regionTableViewController setFetchedResultsController:regionsController];
			
		} else if ([[segue destinationViewController] isKindOfClass:[VYAddEditWineViewController class]]) {
			VYAddEditWineViewController *addEditWineController = [segue destinationViewController];
			
			//reset appellation
			if ([addEditWineController.wine country] == nil || [addEditWineController.wine country] != country) {
				[addEditWineController.wine setAppellation:nil];
			}
			[[addEditWineController wine] setCountry:country];
			
		}
	}
	
	// Navigation to WineTableView from count button
	if ([[segue destinationViewController] isKindOfClass:[VYWineTableViewController class]]) {
		VYWineTableViewController *wineTableViewController = [segue destinationViewController];
		if ([sender isKindOfClass:[VYIndexPathButton class]]) {
			VYIndexPathButton *button = sender;
			NSIndexPath *path = [button indexPath];
			[wineTableViewController.fetchedResultsController setDelegate:nil];
			NSFetchedResultsController *findWinesRC = [Wine fetchAllSortedBy:@"name" ascending:YES withPredicate:[self buildCountPredicateForObject:[self.fetchedResultsController objectAtIndexPath:path]] groupBy:nil delegate:wineTableViewController];
			[wineTableViewController setFetchedResultsController:findWinesRC];
			[NSFetchedResultsController deleteCacheWithName:nil];
			[wineTableViewController setPresetData:[self.fetchedResultsController objectAtIndexPath:path]];
		}
	}
}

#pragma mark
#pragma mark Methods declared at superclass

- (NSPredicate *) buildCountPredicateForObject:(NSManagedObject *)object {
	Country* country = (Country *) object;
	return [NSPredicate predicateWithFormat:@"(country.countryID == %@)", country.countryID];
}


@end
