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
	[self updateAndRefetch];
	[self.searchBar setDelegate:self];
	//NSLog(@"%i results", [self.fetchedResultsController.fetchedObjects count]);
}

#pragma mark
#pragma mark Table View Data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"AppellationCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
	Appellation *appellation = [[super fetchedResultsController] objectAtIndexPath:indexPath];
    [[cell textLabel] setText:[appellation name]];
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
		//NSLog(@"%@", [sectionInfo objects][0]);
		Appellation *appellation = [sectionInfo objects][0];
		return [[appellation region] name];
	}
	return nil;
}

#pragma mark
#pragma mark View Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	NSIndexPath *path = [self.tableView indexPathForSelectedRow];
	Appellation *appellation = [[super fetchedResultsController] objectAtIndexPath:path];
	if (appellation != nil) {
		if ([[segue destinationViewController] isKindOfClass:[VYAddEditWineViewController class]]) {
			VYAddEditWineViewController *addEditWineController = [segue destinationViewController];
			[[addEditWineController wine] setAppellation:appellation];
		}
	}
}

@end
