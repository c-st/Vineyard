#import "AppellationTableViewController.h"

#import "Appellation.h"
#import "Region.h"

@interface AppellationTableViewController ()

@end

@implementation AppellationTableViewController

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Appellation *appellation = [[super fetchedResultsController] objectAtIndexPath:indexPath];
    cell.textLabel.text = appellation.name;
}

/**
 Only display appellations that match the current country. Return all, if no country is set.
*/
- (NSPredicate*) getFetchPredicate:(Wine *)withWine {
	//return nil;
	return [NSPredicate predicateWithFormat:@"(region.country.countryID == %@) || (%@ = null)", withWine.country.countryID, withWine.country.countryID];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
	[self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id  sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

/*- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
	if([super respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
		[super tableView:tableView didSelectRowAtIndexPath:indexPath];
	}
}

/////
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	return [self tableView:tableView customViewForHeaderInSection:section];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if ([[self.fetchedResultsController sections] count] > section) {
		id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
		return [[[[sectionInfo objects] objectAtIndex:0] region] name];
	}
	return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSUInteger count = [[self.fetchedResultsController sections] count];
    return count;
}



@end
