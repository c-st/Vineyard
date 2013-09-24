#import "VYWineTableViewController.h"

@implementation VYWineTableViewController

#pragma mark
#pragma mark Initialization

- (void)viewDidLoad {
    [super viewDidLoad];
	[self setFetchedResultsController:[Wine fetchAllSortedBy:@"name" ascending:YES withPredicate:nil groupBy:nil delegate:nil]];
	[[self fetchedResultsController] setDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated {
	//NSLog(@"viewWillAppear");
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

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	NSIndexPath *path = [self.tableView indexPathForSelectedRow];
	Wine *wine = [[super fetchedResultsController] objectAtIndexPath:path];
	if (wine != nil) {
		//NSLog(@"VYWineTableViewContoller -> prepareForSeque. Pushing wine %@", wine);
		/*
		if ([[segue destinationViewController] isKindOfClass:[VYAddWineViewController class]]) {
			NSLog(@"target is AddWineViewController");
		}
		*/
		if ([[segue destinationViewController] isKindOfClass:[VYWineViewController class]]) {
			NSLog(@"target is WineViewController");
			VYWineViewController *wineViewController = [segue destinationViewController];
			[wineViewController setWine:wine];
		}
	}
}

@end
