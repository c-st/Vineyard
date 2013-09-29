#import "VYWineTableViewController.h"

@implementation VYWineTableViewController

#pragma mark
#pragma mark Initialization

- (id)initWithCoder:(NSCoder *)aDecoder {
	NSLog(@"initWithCoder");
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
	NSLog(@"viewDidLoad resetting fetched rc");
	
	// display all wines if no results controller is set yet
	if ([self fetchedResultsController] == nil) {
		NSLog(@"setting fetched rcontroller");
		[self setFetchedResultsController:[Wine fetchAllSortedBy:@"name" ascending:YES withPredicate:nil groupBy:nil delegate:nil]];
	}
}

- (void)viewWillAppear:(BOOL)animated {
	
	// BUG here
	[self updateAndRefetch];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"WineCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
	Wine *wine = [[super fetchedResultsController] objectAtIndexPath:indexPath];
    [[cell textLabel] setText:[wine name]];
    return cell;
}

#pragma mark
#pragma mark GUI

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
		// delete wine
		Wine *wine = [[super fetchedResultsController] objectAtIndexPath:indexPath];
		[wine deleteEntity];
		[[NSManagedObjectContext defaultContext] saveToPersistentStoreAndWait];
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
	
	// throws error when context is reset..
	if (type == NSFetchedResultsChangeDelete) {
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }	
}


#pragma mark
#pragma mark View Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	NSLog(@"prepareForSegue %@ -> %@", self, [segue destinationViewController]);
	NSIndexPath *path = [self.tableView indexPathForSelectedRow];
	Wine *wine = [[super fetchedResultsController] objectAtIndexPath:path];
	if (wine != nil) {
		if ([[segue destinationViewController] isKindOfClass:[VYWineViewController class]]) {
			NSLog(@"target is WineViewController");
			VYWineViewController *wineViewController = [segue destinationViewController];
			[wineViewController setWine:wine];
		}
	} else {
		if ([[[segue destinationViewController] viewControllers][0] isKindOfClass:[VYAddEditWineViewController class]]) {
			VYAddEditWineViewController *addEditWineController =
				[[segue destinationViewController] viewControllers][0];
			
			if ([self.presetData isKindOfClass:[Country class]]) {
				[[addEditWineController wine] setCountry:(Country *) self.presetData];
			} else if ([self.presetData isKindOfClass:[Region class]]) {
				Region *region = (Region *) self.presetData;
				[[addEditWineController wine] setCountry:[region country]];
			} else if ([self.presetData isKindOfClass:[Appellation class]]) {
				Appellation *appellation = (Appellation *) self.presetData;
				[[addEditWineController wine] setAppellation:appellation];
				[[addEditWineController wine] setCountry:appellation.region.country];
			}
			
		}
	}
}

@end
