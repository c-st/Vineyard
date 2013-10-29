//
//  VYVarietalsViewController.m
//  Vineyard
//
//  Created by Christian Stangier on 08.10.13.
//  Copyright (c) 2013 Christian Stangier. All rights reserved.
//

#import "VYVarietalsTableViewController.h"

@interface VYVarietalsTableViewController ()
@property (nonatomic, strong) IBOutlet UITableViewCell *varietalCell;

@end

@implementation VYVarietalsTableViewController

#pragma mark
#pragma mark Initialization


- (void)viewDidLoad {
    [super viewDidLoad];
	
	if (self.fetchedResultsController == nil) {
		[self setFetchedResultsController:[Varietal fetchAllGroupedBy:@"grapeType" withPredicate:nil sortedBy:@"grapeType.name,name" ascending:YES]];
	}
	
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
    static NSString *CellIdentifier = @"VarietalCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
	Varietal *varietal = [[super fetchedResultsController] objectAtIndexPath:indexPath];
    [[cell textLabel] setText:[varietal name]];
	
	if ([self inPickerMode]) {
		if ([self.selectedVarietals containsObject:varietal]) {
			[cell setAccessoryType:UITableViewCellAccessoryCheckmark];
		} else {
			[cell setAccessoryType:UITableViewCellAccessoryNone];
		}
	}
	
	// set browse table view cell specifics
	if ([cell isKindOfClass:[VYBrowseTableViewCell class]]) {
		VYBrowseTableViewCell *browseCell = (VYBrowseTableViewCell *) cell;
		[[browseCell wineCountButton] setTitle:[NSString stringWithFormat:@"%i", [Wine countOfEntitiesWithPredicate:[self buildCountPredicateForObject:varietal]]] forState:UIControlStateNormal];
		[[browseCell wineCountButton] setIndexPath:indexPath];
		cell = browseCell;
	}
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
	Varietal *varietal = [[super fetchedResultsController] objectAtIndexPath:indexPath];
	
	if ([self inPickerMode]) {
		if ([self.selectedVarietals containsObject:varietal]) {
			[self.selectedVarietals removeObject:varietal];
			[cell setAccessoryType:UITableViewCellAccessoryNone];
		} else {
			[self.selectedVarietals addObject:varietal];
			[cell setAccessoryType:UITableViewCellAccessoryCheckmark];
		}
	}
}

#pragma mark
#pragma mark GUI

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if ([[self.fetchedResultsController sections] count] > 1) {
		id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
		Varietal *varietal = [sectionInfo objects][0]; // use first item from list
		return [varietal.grapeType name];
	}
	return nil;
}


#pragma mark
#pragma mark View Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	NSLog(@"prepareForSegue %@ -> %@", self, [segue destinationViewController]);
	
	//	GrapeType *grapeType = [[super fetchedResultsController] objectAtIndexPath:path];
	
	if ([[segue destinationViewController] isKindOfClass:[VYAddEditWineViewController class]]) {
		VYAddEditWineViewController *addEditWineController = [segue destinationViewController];
		
		[[addEditWineController wine] setVarietals:[NSSet setWithArray:[self selectedVarietals]]];
			//reset appellation
		/*
		if ([addEditWineController.wine colour] == nil || [addEditWineController.wine colour] != grapeType) {
			[addEditWineController.wine setColour:nil];
		}
		[[addEditWineController wine] setColour:grapeType];
		 */
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
	Varietal* varietal = (Varietal *) object;
	return [NSPredicate predicateWithFormat:@"ANY varietals == %@", varietal];
}



@end
