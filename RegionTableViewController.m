#import "CountryTableViewController.h"
#import "WineCell.h"

#import "Country.h"

@interface CountryTableViewController ()

@end

@implementation CountryTableViewController

@synthesize fetchedResultsController = fetchedResultsController;
@synthesize managedObjectContext = _managedObjectContext;

- (NSFetchedResultsController *)fetchedResultsController {
    if (fetchedResultsController != nil) {
        return fetchedResultsController;
    }
    fetchedResultsController = [Country
                                    fetchAllGroupedBy:nil
                                    withPredicate:nil
                                    sortedBy:@"name" ascending:NO delegate:self];
    
    return fetchedResultsController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSError *error;
	if (![[self fetchedResultsController] performFetch:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	}
    self.title = @"Countries";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id  sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Country *country = [fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = country.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@", country.name, country.countryID];
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
	[[self navigationController] pushViewController:[[WineTableViewController alloc] init] animated:YES];
}

- (void)viewDidUnload {
    self.fetchedResultsController = nil;
}

@end
