#import "UIColor+CellarColours.h"
#import "WineTableViewController.h"
#import "Wine.h"
#import "Appellation.h"
#import "WineCell.h"

@interface WineTableViewController ()

@end

@implementation WineTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	[self.tableView setRowHeight:145];
	[self.tableView setBackgroundColor:[UIColor cellarBeigeColour]];
}

- (void) viewWillAppear:(BOOL)animated {
	[self setFetchedResultsController:[Wine fetchAllSortedBy:@"name" ascending:YES withPredicate:[self getFetchPredicate:nil] groupBy:nil delegate:nil]];
	
	NSError *error;
	if (![[self fetchedResultsController] performFetch:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	}
	
	[super viewWillAppear:animated];
}

- (void) viewDidAppear:(BOOL)animated {
	NSLog(@"We have %i now", [[[Wine fetchAllSortedBy:@"name" ascending:YES withPredicate:[self getFetchPredicate:nil] groupBy:nil delegate:nil] fetchedObjects] count]);
}

- (NSPredicate*) getFetchPredicate:(Wine *)withWine {
	return [NSPredicate predicateWithFormat:@"name.length > 0"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	Wine *wine = [[super fetchedResultsController] objectAtIndexPath:indexPath];
	
    WineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WineCell"];
    if (cell == nil) {
        cell = [[WineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WineCell" andWine:wine];
    }
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
}



@end
