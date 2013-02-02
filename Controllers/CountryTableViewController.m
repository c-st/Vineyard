#import "UIColor+CellarColours.h"
#import "CountryTableViewController.h"
#import "RegionTableViewController.h"

#import "Country.h"
#import "Region.h"
#import "Wine.h"

#import "UIImage+Scale.h"


#import "XYPieChart.h"

@interface CountryTableViewController ()

@end

@implementation CountryTableViewController

- (void) viewWillAppear:(BOOL) animated {
	[self setFetchedResultsController:[Country fetchAllSortedBy:@"name" ascending:YES withPredicate:nil groupBy:nil delegate:nil]];
	
	[super viewWillAppear:animated];
}

- (NSPredicate *) buildCountPredicateForObject:(NSManagedObject *)object {
	Country* country = (Country *) object;
	return [NSPredicate predicateWithFormat:@"(country.countryID == %@)", country.countryID];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CountryCell";
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
    Country *country = [self.fetchedResultsController objectAtIndexPath:indexPath];
	cell.imageView.image = [[UIImage imageNamed:[country.isoCode stringByAppendingString:@".png"]] scaleToSize:CGSizeMake(26, 26)];
    cell.textLabel.text = country.name;
	if ([self showCount]) {
		cell.accessoryView = [self buildAccessoryViewFromPredicate:[self buildCountPredicateForObject:country] andObject:country andIndexPath:indexPath];
	}
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
	[regionTableViewController setShowPieChart:[self showPieChart]];
	[regionTableViewController setPaperFoldNC:self.paperFoldNC];
	
	[[self navigationController] pushViewController:regionTableViewController animated:YES];
}

@end
