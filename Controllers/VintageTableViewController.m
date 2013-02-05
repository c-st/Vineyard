
#import "VintageTableViewController.h"

#import "WineTableViewController.h"

@implementation VintageTableViewController

@synthesize years;

- (id) init {
	if ((self = [super init])) {
	}
    return self;
}

- (void) viewWillAppear:(BOOL)animated {
	// find all wines with year != null, add to years
	NSPredicate *yearPredicate = [NSPredicate predicateWithFormat:@"vintage > 0"];
	NSArray *wines = [Wine findAllWithPredicate:yearPredicate];
	NSMutableArray *vintages = [[NSMutableArray alloc] init];
	for (Wine *wine in wines) {
		if (![vintages containsObject:wine.vintage]) {
			[vintages addObject:wine.vintage];
		}
	}
	[self setYears:vintages];
	//NSLog(@"%i", [vintages count]);
	
}

- (NSPredicate *) buildCountPredicateForYear:(NSNumber *)year {
	return [NSPredicate predicateWithFormat:@"vintage == %@", year];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"VintageCell";
    CellarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CellarTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		if ([self showCount]) {
			[cell setShowArrow:YES];
		}
    }
	[self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
	NSNumber *year = [self.years objectAtIndex:indexPath.row];
	
    // add year
	[[cell textLabel] setText:[NSString stringWithFormat:@"%@", year]];
	
	if ([self showCount]) {
		// count wines
		cell.accessoryView = [self buildAccessoryViewFromPredicate:[self buildCountPredicateForYear:year] andObject:nil andIndexPath:indexPath];
	}
}

- (void) countButtonClicked:(UIButton *) sender {
	// fetch selected row object
	// fetch selected row object
	NSIndexPath *path = [sender objectTag];
	NSNumber *year = [years objectAtIndex:path.row];
	
	NSFetchedResultsController *wineSearchController = [Wine fetchAllSortedBy:@"name" ascending:YES withPredicate:[self buildCountPredicateForYear:year] groupBy:nil delegate:self];
	
	WineTableViewController *wineTableViewController = [[WineTableViewController alloc] initWithFetchedResultsController:wineSearchController];
	[wineTableViewController setTitle:[NSString stringWithFormat:@"%@", year]];
	[wineTableViewController setShowCount:NO];
	[wineTableViewController setPaperFoldNC:self.paperFoldNC];
	[[self navigationController] pushViewController:wineTableViewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 40;
}

- (void) updateAndRefetch {
	// overridden. nothing else to do here.
	[self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [years count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart {
	return [years count];
}

- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index {
	int count = [Wine countOfEntitiesWithPredicate:[self buildCountPredicateForYear:[years objectAtIndex:index]]];
    return count;
}

- (NSString *)pieChart:(XYPieChart *)pieChart textForSliceAtIndex:(NSUInteger)index {
	return [NSString stringWithFormat:@"%@", [years objectAtIndex:index]];
}


@end
