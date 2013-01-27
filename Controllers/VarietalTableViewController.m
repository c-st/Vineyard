
#import "VarietalTableViewController.h"
#import "WineTableViewController.h"
#import "Varietal.h"
#import "Wine.h"
#import "GrapeType.h"
#import "SettingsCell.h"

#import "UIColor+CellarColours.h"

@interface VarietalTableViewController ()

@end

@implementation VarietalTableViewController

@synthesize pickMode, selectedVarietals;

- (id) init {
	if ((self = [super init])) {
		[self setSelectedVarietals:[[NSMutableArray alloc] init]];
	}
    return self;
}

- (void) viewWillAppear:(BOOL)animated {
	[self setFetchedResultsController:[Varietal fetchAllGroupedBy:@"grapeType" withPredicate:self.settingsCell.wine != nil ? [self getFetchPredicate:self.settingsCell.wine]:nil sortedBy:@"grapeType,name" ascending:YES]];
	
	if ([self pickMode]) {
		UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle: @"Done" style:UIBarButtonItemStylePlain target:self action: @selector(finishSelection)];
		[[self navigationItem] setRightBarButtonItem:doneButton];
	}
	[super viewWillAppear:animated];
}

- (void) finishSelection {
	if ([self settingsCell] != nil) {
		// hand values to settings cell.
		NSLog(@"value is handed to settingsCell...");
		[[self settingsCell] listValueWasSelected:[NSSet setWithArray:[self selectedVarietals]]];
		[self.navigationController popViewControllerAnimated:YES];
	}
}

- (NSPredicate *) buildCountPredicateForObject:(NSManagedObject *)object {
	Varietal* varietal = (Varietal *) object;
	return [NSPredicate predicateWithFormat:@"ANY varietals == %@", varietal];
}

- (NSPredicate*) getFetchPredicate:(Wine *)withWine {
	// if colour is set, only display varietals with colour
	return [NSPredicate predicateWithFormat:@"(grapeType.grapeTypeID ==[c] %@) || (%@ = null)", withWine.colour.grapeTypeID, withWine.colour];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Varietal *varietal = [self.fetchedResultsController objectAtIndexPath:indexPath];
	
	cell.textLabel.text = [NSString stringWithFormat:@"%@", varietal.name];
	
	if ([self showCount]) {
		// count wines
		cell.accessoryView = [self buildAccessoryViewFromPredicate:[self buildCountPredicateForObject:varietal] andObject:varietal andIndexPath:indexPath];
	}
	
	if ([self.selectedVarietals containsObject:varietal]) {
		[cell setAccessoryType:UITableViewCellAccessoryCheckmark];
		[cell setBackgroundColor:[UIColor cellarBeigeNoisyColour]];
	} else {
		[cell setAccessoryType:UITableViewCellAccessoryNone];
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"VarietalCell";
    CellarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CellarTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
		[cell setSelectionStyle:UITableViewCellEditingStyleNone];
		if ([self showCount]) {
			[cell setShowArrow:YES];
		}
    }
	[self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
	UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
	Varietal *varietal = [[super fetchedResultsController] objectAtIndexPath:indexPath];
	
	if ([self pickMode]) {
		if ([selectedVarietals containsObject:varietal]) {
			[selectedVarietals removeObject:varietal];
			[cell setAccessoryType:UITableViewCellAccessoryNone];
		} else {
			[selectedVarietals addObject:varietal];
			[cell setAccessoryType:UITableViewCellAccessoryCheckmark];
		}
	} else {
		NSFetchedResultsController *wineSearchController = [Wine fetchAllSortedBy:@"name" ascending:YES withPredicate:[self buildCountPredicateForObject:varietal] groupBy:nil delegate:self];
		
		WineTableViewController *wineTableViewController = [[WineTableViewController alloc] initWithFetchedResultsController:wineSearchController];
		[wineTableViewController setTitle:[varietal valueForKey:@"name"]];
		[wineTableViewController setShowCount:NO];
		[wineTableViewController setPaperFoldNC:self.paperFoldNC];
		[[self navigationController] pushViewController:wineTableViewController animated:YES];
	}
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
		id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
		Varietal *v = (Varietal *) [sectionInfo objects][0];
		return [NSString stringWithFormat:@"%@ grapes", v.grapeType.name];
	}
	return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSUInteger count = [[self.fetchedResultsController sections] count];
    return count;
}


@end
