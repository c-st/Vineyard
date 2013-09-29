#import "VYWineTableViewController.h"

@implementation VYWineTableViewController

#pragma mark
#pragma mark Initialization

- (void)viewDidLoad {
    [super viewDidLoad];
	
	// display all wines if no results controller is set yet
	if ([self fetchedResultsController] == nil) {
		[self setFetchedResultsController:[Wine fetchAllSortedBy:@"name" ascending:YES withPredicate:nil groupBy:nil delegate:nil]];
	}
	[[self fetchedResultsController] setDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated {
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
		NSLog(@"wine is nil");
	}
}

@end
