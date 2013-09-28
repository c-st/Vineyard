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
	[self updateAndRefetch];
	
	//NSLog(@"%i results", [self.fetchedResultsController.fetchedObjects count]);
}

#pragma mark
#pragma mark Table View Data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CountryCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
	Country *country = [[super fetchedResultsController] objectAtIndexPath:indexPath];
    [[cell textLabel] setText:[country name]];
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
	Country *country = [[super fetchedResultsController] objectAtIndexPath:path];
	if (country != nil) {
		if ([[segue destinationViewController] isKindOfClass:[VYRegionTableViewController class]]) {
			NSLog(@"target is RegionViewController");
			VYRegionTableViewController *regionTableViewController = [segue destinationViewController];
			//[[regionTableViewController navigationItem] setTitle:[country name]];
			
			// find all regions from selected country
			NSPredicate *searchStatement =
				[NSPredicate predicateWithFormat:@"country.countryID == %@", country.countryID];
			
			NSFetchedResultsController *regionsController = [Region fetchAllSortedBy:@"name" ascending:YES withPredicate:searchStatement groupBy:nil delegate:self];
			
			[regionTableViewController setFetchedResultsController:regionsController];
		} else if ([[segue destinationViewController] isKindOfClass:[VYAddEditWineViewController class]]) {
			VYAddEditWineViewController *addEditWineController = [segue destinationViewController];
			[[addEditWineController wine] setCountry:country];
		}
	}
}


@end
