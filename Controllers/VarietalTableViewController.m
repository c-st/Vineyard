
#import "VarietalTableViewController.h"
#import "Varietal.h"
#import "Wine.h"
#import "SettingsCell.h"

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
	if (self.settingsCell.wine != nil) {
		[self setFetchedResultsController:[Varietal fetchAllSortedBy:@"name" ascending:YES withPredicate:[self getFetchPredicate:self.settingsCell.wine] groupBy:nil delegate:nil]];
	} else {
		[self setFetchedResultsController:[Varietal fetchAllSortedBy:@"name" ascending:YES withPredicate:nil groupBy:nil delegate:nil]];
	}
	
	if ([self pickMode]) {
		UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle: @"Done" style:UIBarButtonItemStylePlain target:self action: @selector(finishSelection)];
		[[self navigationItem] setRightBarButtonItem:doneButton];
		
		// set selected varietals from wine
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
	return [NSPredicate predicateWithFormat:@"(varietals CONTAINS[c] %@)", varietal.varietalID];
}

- (NSPredicate*) getFetchPredicate:(Wine *)withWine {
	// if colour is set, only display varietals with colour
	return [NSPredicate predicateWithFormat:@"(colour == %@) || (%@ = null)", withWine.colour, withWine.colour];	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
		[cell setSelectionStyle:UITableViewCellEditingStyleNone];
    }
	[self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Varietal *varietal = [self.fetchedResultsController objectAtIndexPath:indexPath];
	
	cell.textLabel.text = [NSString stringWithFormat:@"%@ (%@)", varietal.name, varietal.colour];
	
	if ([self showCount]) {
		// count wines
		cell.accessoryView = [self buildAccessoryViewFromPredicate:[self buildCountPredicateForObject:varietal] andObject:varietal];
	}
	
	if ([self.selectedVarietals containsObject:varietal]) {
		[cell setAccessoryType:UITableViewCellAccessoryCheckmark];
	} else {
		[cell setAccessoryType:UITableViewCellAccessoryNone];
	}
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
	}
	
	//NSLog(@"--> %i", [selectedVarietals count]);
}




@end
