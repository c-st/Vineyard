#import "UIColor+CellarColours.h"
#import "CollectionTableViewController.h"
#import "RegionTableViewController.h"

#import "Collection.h"

#import "UIImage+Scale.h"

@interface CollectionTableViewController ()

@end

@implementation CollectionTableViewController

- (void) viewWillAppear:(BOOL) animated {
	[self setFetchedResultsController:[Collection fetchAllSortedBy:@"name" ascending:YES withPredicate:nil groupBy:nil delegate:nil]];
	[super viewWillAppear:animated];
	
	UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewCollection)];
	[[self navigationItem] setRightBarButtonItem:addButton];
	
	NSLog(@"%i collections.", [[[Collection fetchAllSortedBy:@"name" ascending:YES withPredicate:[self getFetchPredicate:nil] groupBy:nil delegate:nil] fetchedObjects] count]);
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Collection *collection = [self.fetchedResultsController objectAtIndexPath:indexPath];
	
	// cell.imageView.image = [[UIImage imageNamed:[country.isoCode stringByAppendingString:@".png"]] scaleToSize:CGSizeMake(26, 26)];
    cell.textLabel.text = collection.name;
	
	if ([self showCount]) {
		cell.accessoryView = [self buildAccessoryViewFromPredicate:[self buildCountPredicateForObject:collection] andObject:collection andIndexPath:indexPath];
	}
}

- (NSPredicate *) buildCountPredicateForObject:(NSManagedObject *)object {
	Country* country = (Country *) object;
	return [NSPredicate predicateWithFormat:@"(country.countryID == %@)", country.countryID];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CollectionCell";
    CellarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CellarTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
		if ([self showCount]) {
			[cell setShowArrow:YES];
		}
    }
   [self configureCell:cell atIndexPath:indexPath];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
	if([super respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
		[super tableView:tableView didSelectRowAtIndexPath:indexPath];
	}
	
    // ... show wines ...
	//[[self navigationController] pushViewController:regionTableViewController animated:YES];
}

- (void) addNewCollection {
	Collection *collection = [Collection createEntity];
	[collection setName:@"Test"];
	[[NSManagedObjectContext defaultContext] saveToPersistentStoreAndWait];
	
	[self updateAndRefetch];
	NSLog(@"add");
}


@end
