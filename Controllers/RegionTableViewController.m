#import "RegionTableViewController.h"
#import "AppellationTableViewController.h"
#import "WineCell.h"

#import "Region.h"
#import "Appellation.h"

@interface RegionTableViewController ()

@end

@implementation RegionTableViewController

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {	
    Region *region = [[super fetchedResultsController] objectAtIndexPath:indexPath];
    cell.textLabel.text = region.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@", region.name, region.regionID];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
	Region *region = [[super fetchedResultsController] objectAtIndexPath:indexPath];
	
    NSPredicate *searchStatement = [NSPredicate predicateWithFormat:@"region.regionID == %@", region.regionID];
    NSFetchedResultsController *appellationsController = [Appellation fetchAllSortedBy:@"name" ascending:YES withPredicate:searchStatement groupBy:nil delegate:self];
	
	AppellationTableViewController *appellationTableViewController = [[AppellationTableViewController alloc] initWithFetchedResultsController:appellationsController];
	[appellationTableViewController setTitle:region.name];
	[[self navigationController] pushViewController:appellationTableViewController animated:YES];
}


@end
