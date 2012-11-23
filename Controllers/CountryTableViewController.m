#import "CountryTableViewController.h"
#import "RegionTableViewController.h"
#import "WineCell.h"

#import "Country.h"
#import "Region.h"
#import "Wine.h"

@interface CountryTableViewController ()

@end

@implementation CountryTableViewController

- (void) viewWillAppear:(BOOL)animated {
	[self setFetchedResultsController:[Country fetchAllSortedBy:@"name" ascending:YES withPredicate:nil groupBy:nil delegate:nil]];
	[super viewWillAppear:animated];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Country *country = [self.fetchedResultsController objectAtIndexPath:indexPath];
	
	cell.imageView.image = [UIImage imageNamed:[country.isoCode stringByAppendingString:@".png"]];
    cell.textLabel.text = country.name;
	
	if ([self showCount]) {
		// count wines
		NSPredicate *winesFromCountry = [NSPredicate predicateWithFormat:@"(country.countryID == %@)", country.countryID];
		int count = [Wine countOfEntitiesWithPredicate:winesFromCountry];
		if (count > 0) {
			cell.accessoryView = [self buildBadgeView:[NSString stringWithFormat:@"%i", count]];
		} else {
			cell.accessoryView = nil;
		}
	}
	
    //cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@", country.name, country.countryID];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
		
    }
   [self configureCell:cell atIndexPath:indexPath];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
	if([super respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
		[super tableView:tableView didSelectRowAtIndexPath:indexPath];
	}
	
    Country *country = [self.fetchedResultsController objectAtIndexPath:indexPath];
	
    NSPredicate *searchStatement = [NSPredicate predicateWithFormat:@"country.countryID == %@", country.countryID];
    NSFetchedResultsController *regionsController = [Region fetchAllSortedBy:@"name" ascending:YES withPredicate:searchStatement groupBy:nil delegate:self];
	
	RegionTableViewController *regionTableViewController = [[RegionTableViewController alloc] initWithFetchedResultsController:regionsController];
	[regionTableViewController setTitle:country.name];
	[regionTableViewController setShowCount:[self showCount]];
	
	[[self navigationController] pushViewController:regionTableViewController animated:YES];
}


@end
