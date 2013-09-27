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


- (void)viewWillAppear:(BOOL)animated {
	[self updateAndRefetch];
	//NSLog(@"%i results", [self.fetchedResultsController.fetchedObjects count]);
}

#pragma mark
#pragma mark Table View Data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"RegionCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
	Region *region = [[super fetchedResultsController] objectAtIndexPath:indexPath];
    [[cell textLabel] setText:[region name]];
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
	NSIndexPath *path = [self.tableView indexPathForSelectedRow];
	Region *region = [[super fetchedResultsController] objectAtIndexPath:path];
	if (region != nil) {
		if ([[segue destinationViewController] isKindOfClass:[VYAppellationTableViewController class]]) {
			NSLog(@"target is VYAppellationTableViewController");
			VYAppellationTableViewController *appellationTableViewController = [segue destinationViewController];
			//[[appellationTableViewController navigationItem] setTitle:[region name]];
			
			// find all regions from selected country
			NSPredicate *searchStatement =
			[NSPredicate predicateWithFormat:@"region.regionID == %@", region.regionID];
			
			NSFetchedResultsController *appellationsController = [Appellation fetchAllSortedBy:@"name" ascending:YES withPredicate:searchStatement groupBy:nil delegate:self];
			
			[appellationTableViewController setFetchedResultsController:appellationsController];
		}
	}
}

@end
