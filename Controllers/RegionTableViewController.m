#import "RegionTableViewController.h"
#import "AppellationTableViewController.h"

#import "Region.h"
#import "Appellation.h"

@implementation RegionTableViewController

- (NSPredicate *) buildCountPredicateForObject:(NSManagedObject *)object {
	Region* region = (Region *) object;
	return [NSPredicate predicateWithFormat:@"(appellation.region.regionID == %@)", region.regionID];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"RegionCell";
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

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Region *region = [[super fetchedResultsController] objectAtIndexPath:indexPath];
    cell.textLabel.text = region.name;
    //cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@", region.name, region.regionID];
	
	if ([self showCount]) {
		// count wines
		cell.accessoryView = [self buildAccessoryViewFromPredicate:[self buildCountPredicateForObject:region] andObject:region andIndexPath:indexPath];
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
	if([super respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
		[super tableView:tableView didSelectRowAtIndexPath:indexPath];
	}

	Region *region = [[super fetchedResultsController] objectAtIndexPath:indexPath];
    NSPredicate *searchStatement = [NSPredicate predicateWithFormat:@"region.regionID == %@", region.regionID];
    NSFetchedResultsController *appellationsController = [Appellation fetchAllSortedBy:@"region.name" ascending:YES withPredicate:searchStatement groupBy:nil delegate:self];
	
	AppellationTableViewController *appellationTableViewController = [[AppellationTableViewController alloc] initWithFetchedResultsController:appellationsController];
	[appellationTableViewController setTitle:region.name];
	[appellationTableViewController setShowCount:[self showCount]];
	[appellationTableViewController setShowPieChart:[self showPieChart]];
	[appellationTableViewController setPaperFoldNC:self.paperFoldNC];
	
	[[self navigationController] pushViewController:appellationTableViewController animated:YES];
}


@end
