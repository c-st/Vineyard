
#import "VintageTableViewController.h"

#import "WineTableViewController.h"

@implementation VintageTableViewController

- (id) init {
	if ((self = [super init])) {
	}
    return self;
}

- (void) viewWillAppear:(BOOL)animated {
	// find all wines with year != null, add all years
	NSPredicate *yearPredicate = [NSPredicate predicateWithFormat:@"year > 0"];
	NSLog(@"matching wines %i", [[Wine findAllWithPredicate:yearPredicate] count]);
	
}

- (NSPredicate *) buildCountPredicateForYear:(NSNumber *)year {
	return [NSPredicate predicateWithFormat:@"year == %i", year];
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
	//NSDictionary *rating = [self.values objectAtIndex:indexPath.row];
	
    // add year
	
	if ([self showCount]) {
		// count wines
		//cell.accessoryView = [self buildAccessoryViewFromPredicate:[self buildCountPredicateForRating:rating] andObject:nil andIndexPath:indexPath];
	}
}

- (void) countButtonClicked:(UIButton *) sender {
	// fetch selected row object
	
	NSFetchedResultsController *wineSearchController = [Wine fetchAllSortedBy:@"name" ascending:YES withPredicate:[self buildCountPredicateForYear:@2013] groupBy:nil delegate:self];
	
	WineTableViewController *wineTableViewController = [[WineTableViewController alloc] initWithFetchedResultsController:wineSearchController];
//	[wineTableViewController setTitle:[rating valueForKey:@"name"]];
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
    return 0; //[values count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart {
	return 0; //[values count];
}

- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index {
	//int count = [Wine countOfEntitiesWithPredicate:[self buildCountPredicateForRating:[values objectAtIndex:index]]];
    return 0; //count;
}

- (NSString *)pieChart:(XYPieChart *)pieChart textForSliceAtIndex:(NSUInteger)index {
	return @""; //[[values objectAtIndex:index] valueForKey:@"name"];
}


@end
