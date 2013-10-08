//
//  VYColourTableViewController.m
//  Vineyard
//
//  Created by Christian Stangier on 08.10.13.
//  Copyright (c) 2013 Christian Stangier. All rights reserved.
//

#import "VYGrapeTypeTableViewController.h"

@interface VYGrapeTypeTableViewController ()

@end

@implementation VYGrapeTypeTableViewController

#pragma mark
#pragma mark Initialization

- (void)viewDidLoad {
    [super viewDidLoad];
	[self setFetchedResultsController:
	 [GrapeType fetchAllSortedBy:@"name" ascending:YES withPredicate:nil groupBy:nil delegate:nil]];
	[[self fetchedResultsController] setDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
}

- (void) viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[self updateAndRefetch];
}

#pragma mark
#pragma mark Table View Data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"GrapeTypeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
	GrapeType *grapeType = [[super fetchedResultsController] objectAtIndexPath:indexPath];
    [[cell textLabel] setText:[grapeType name]];
	
	// set browse table view cell specifics
	if ([cell isKindOfClass:[VYBrowseTableViewCell class]]) {
		VYBrowseTableViewCell *browseCell = (VYBrowseTableViewCell *) cell;
		[[browseCell wineCountButton] setTitle:[NSString stringWithFormat:@"%i", [Wine countOfEntitiesWithPredicate:[self buildCountPredicateForObject:grapeType]]] forState:UIControlStateNormal];
		[[browseCell wineCountButton] setIndexPath:indexPath];
		cell = browseCell;
	}
	
    return cell;
}


#pragma mark
#pragma mark View Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	NSLog(@"prepareForSegue %@ -> %@", self, [segue destinationViewController]);
	NSIndexPath *path = [self.tableView indexPathForSelectedRow];
	GrapeType *grapeType = [[super fetchedResultsController] objectAtIndexPath:path];
	
	if ([[segue destinationViewController] isKindOfClass:[VYAddEditWineViewController class]]) {
		VYAddEditWineViewController *addEditWineController = [segue destinationViewController];
		
		//reset appellation
		if ([addEditWineController.wine colour] == nil || [addEditWineController.wine colour] != grapeType) {
			[addEditWineController.wine setColour:nil];
		}
		[[addEditWineController wine] setColour:grapeType];
	}
}


@end
