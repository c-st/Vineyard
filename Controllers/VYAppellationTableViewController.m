//
//  VYAppellationTableViewController.m
//  Vineyard
//
//  Created by Christian Stangier on 27.09.13.
//  Copyright (c) 2013 Christian Stangier. All rights reserved.
//

#import "VYAppellationTableViewController.h"

@interface VYAppellationTableViewController ()

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
#pragma mark GUI

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
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
