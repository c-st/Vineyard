#import "WineTableViewController.h"
#import "Wine.h"
#import "Appellation.h"

@interface WineTableViewController ()

@end

@implementation WineTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSError *error;
	if (![[self fetchedResultsController] performFetch:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	}
	NSLog(@"We have %i now", [[[Wine fetchAllSortedBy:@"name" ascending:YES withPredicate:nil groupBy:nil delegate:nil] fetchedObjects] count]);
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Wine *wine = [[super fetchedResultsController] objectAtIndexPath:indexPath];
    cell.textLabel.text = [wine.name stringByAppendingFormat:@" (%@, %@)", wine.appellation.name, wine.country.countryID];
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
}



@end
