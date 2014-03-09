//
//  VYRegionTableViewController.m
//  Vineyard
//
//  Created by Christian Stangier on 27.09.13.
//  Copyright (c) 2013 Christian Stangier. All rights reserved.
//

#import "VYRegionTableViewController.h"

@interface VYRegionTableViewController ()
@end

@implementation VYRegionTableViewController

#pragma mark
#pragma mark Initialization

- (void)viewDidLoad {
    [super viewDidLoad];
	//[self setFetchedResultsController:
	 //[Region fetchAllSortedBy:@"name" ascending:YES withPredicate:nil groupBy:nil delegate:nil]];
	[[self fetchedResultsController] setDelegate:self];
}


#pragma mark
#pragma mark Table View Data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"RegionCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
	Region *region = [[super fetchedResultsController] objectAtIndexPath:indexPath];
    [[cell textLabel] setText:[region name]];
	
	// set browse table view cell specifics
	if ([cell isKindOfClass:[VYBrowseTableViewCell class]]) {
		VYBrowseTableViewCell *browseCell = (VYBrowseTableViewCell *) cell;
		[[browseCell wineCountButton] setTitle:[NSString stringWithFormat:@"%zd", [Wine countOfEntitiesWithPredicate:[self buildCountPredicateForObject:region]]] forState:UIControlStateNormal];
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
	Region *region = [[super fetchedResultsController] objectAtIndexPath:path];
	if (region != nil) {
		if ([[segue destinationViewController] isKindOfClass:[VYAppellationTableViewController class]]) {
			NSLog(@"target is VYAppellationTableViewController");
			VYAppellationTableViewController *appellationTableViewController = [segue destinationViewController];
			
			// find all appellations from selected region with more than 1 wine
			NSPredicate *searchStatement = (self.inPickerMode) ? [NSPredicate predicateWithFormat:@"region.regionID == %@", region.regionID] : [NSPredicate predicateWithFormat:@"region.regionID == %@ AND wines.@count > 0", region.regionID];
			
			NSFetchedResultsController *appellationsController = [Appellation fetchAllSortedBy:@"name" ascending:YES withPredicate:searchStatement groupBy:nil delegate:self];
			
			[appellationTableViewController setFetchedResultsController:appellationsController];
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
			[wineTableViewController setPresetData:[self.fetchedResultsController objectAtIndexPath:path]];
		}
	}
}

#pragma mark
#pragma mark Methods declared at superclass

- (NSPredicate *) buildCountPredicateForObject:(NSManagedObject *)object {
	Region* region = (Region *) object;
	return [NSPredicate predicateWithFormat:@"(appellation.region.regionID == %@)", region.regionID];
}


@end
