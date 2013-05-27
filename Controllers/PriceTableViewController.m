#import "PriceTableViewController.h"

#import "WineTableViewController.h"

@interface PriceTableViewController ()

@end

@implementation PriceTableViewController

@synthesize values;

- (id) init {
	if ((self = [super init])) {
		self.values = @[
					@{@"name" : @"No price", @"lowerBound" : @0, @"upperBound" : @0},
					@{@"name" : @"< 20", @"lowerBound" : @0.01, @"upperBound" : @19},
					@{@"name" : @"20 - 50", @"lowerBound" : @20, @"upperBound" : @49},
					@{@"name" : @"50 - 80", @"lowerBound" : @50, @"upperBound" : @80},
					@{@"name" : @"80 - 100", @"lowerBound" : @80, @"upperBound" : @100},
					@{@"name" : @"80 - 100", @"lowerBound" : @100, @"upperBound" : @150},
				];

	}
    return self;
}

- (NSPredicate *) buildCountPredicateForPrice:(NSDictionary *)object {
	return [NSPredicate predicateWithFormat:@"price >= %lf AND price <= %lf", [[object valueForKey:@"lowerBound"] floatValue], [[object valueForKey:@"upperBound"] floatValue]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"PriceCell";
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
	NSDictionary *price = [self.values objectAtIndex:indexPath.row];
	if ([[price valueForKey:@"lowerBound"] floatValue] == 0.0f) {
		cell.textLabel.text = [price valueForKey:@"name"];
	} else {
		cell.textLabel.text = [[price valueForKey:@"name"] stringByAppendingString:[NSString stringWithFormat:@" %@", [self getCurrencySymbol]]];
	}
    //cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@", region.name, region.regionID];
	
	if ([self showCount]) {
		// count wines
		cell.accessoryView = [self buildAccessoryViewFromPredicate:[self buildCountPredicateForPrice:price] andObject:nil andIndexPath:indexPath];
	}
}

- (NSString *) getCurrencySymbol {
	NSLocale *theLocale = [NSLocale currentLocale];
	return [theLocale objectForKey:NSLocaleCurrencySymbol];
}


- (void) countButtonClicked:(UIButton *) sender {
	// fetch selected row object
	NSIndexPath *path = [sender objectTag];
	NSDictionary *price = [values objectAtIndex:path.row];
	
	NSFetchedResultsController *wineSearchController = [Wine fetchAllSortedBy:@"name" ascending:YES withPredicate:[self buildCountPredicateForPrice:price] groupBy:nil delegate:self];
	
	WineTableViewController *wineTableViewController = [[WineTableViewController alloc] initWithFetchedResultsController:wineSearchController];
	
	[wineTableViewController setTitle:[[price valueForKey:@"name"] stringByAppendingString:[NSString stringWithFormat:@" %@", [self getCurrencySymbol]]] ];
	[wineTableViewController setShowCount:NO];
	[wineTableViewController setPaperFoldNC:self.paperFoldNC];
	[[self navigationController] pushViewController:wineTableViewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 55;
}

- (void) updateAndRefetch {
	// overridden. nothing else to do here.
	[self.tableView reloadData];
}

- (void) viewWillAppear:(BOOL)animated {
	[self updateAndRefetch];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [values count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart {
	return [values count];
}

- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index {
	int count = [Wine countOfEntitiesWithPredicate:[self buildCountPredicateForPrice:[values objectAtIndex:index]]];
    return count;
}

- (NSString *)pieChart:(XYPieChart *)pieChart textForSliceAtIndex:(NSUInteger)index {
	return [[values objectAtIndex:index] valueForKey:@"name"];
}

// hack: overriden to not display "add item" view here
- (UIView *)buildAddItemView {
	return nil;
}
@end
