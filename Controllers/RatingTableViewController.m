#import "RatingTableViewController.h"

#import "WineTableViewController.h"

@interface RatingTableViewController ()

@end

@implementation RatingTableViewController

@synthesize values;

- (id) init {
	if ((self = [super init])) {
		self.values = @[
					@{@"name" : @"Unrated", @"starCount" : @0},
					@{@"name" : @"6 Stars", @"starCount" : @6},
					@{@"name" : @"5 Stars", @"starCount" : @5},
					@{@"name" : @"4 Stars", @"starCount" : @4},
					@{@"name" : @"3 Stars", @"starCount" : @3},
					@{@"name" : @"2 Stars", @"starCount" : @2},
					@{@"name" : @"1 Star",  @"starCount" : @1}
				];

	}
    return self;
}

- (NSPredicate *) buildCountPredicateForRating:(NSDictionary *)object {
	return [NSPredicate predicateWithFormat:@"rating == %i", [[object valueForKey:@"starCount"] integerValue]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"RatingCell";
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
	NSDictionary *rating = [self.values objectAtIndex:indexPath.row];
	
    cell.textLabel.text = [rating valueForKey:@"name"];
    //cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@", region.name, region.regionID];
	float starCount = [[rating valueForKey:@"starCount"] floatValue];
	if (starCount > 0) {
		SSRatingPicker *ratingPicker = [[SSRatingPicker alloc] initWithFrame:CGRectMake(70, 15, 180, 20)];
		[ratingPicker setBackgroundColor:[UIColor clearColor]];
		[ratingPicker setTotalNumberOfStars:6];
		[ratingPicker setSelectedNumberOfStars:starCount];
		[ratingPicker setStarSpacing:4.0f];
		[ratingPicker.textLabel setText:@""];
		[ratingPicker setUserInteractionEnabled:NO];
		[cell.contentView addSubview:ratingPicker];
	}
	
	if ([self showCount]) {
		// count wines
		cell.accessoryView = [self buildAccessoryViewFromPredicate:[self buildCountPredicateForRating:rating] andObject:nil andIndexPath:indexPath];
	}
}

- (void) countButtonClicked:(UIButton *) sender {
	// fetch selected row object
	NSIndexPath *path = [sender objectTag];
	NSDictionary *rating = [values objectAtIndex:path.row];
	
	NSFetchedResultsController *wineSearchController = [Wine fetchAllSortedBy:@"name" ascending:YES withPredicate:[self buildCountPredicateForRating:rating] groupBy:nil delegate:self];
	
	WineTableViewController *wineTableViewController = [[WineTableViewController alloc] initWithFetchedResultsController:wineSearchController];
	[wineTableViewController setTitle:[rating valueForKey:@"name"]];
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
	int count = [Wine countOfEntitiesWithPredicate:[self buildCountPredicateForRating:[values objectAtIndex:index]]];
    return count;
}

- (NSString *)pieChart:(XYPieChart *)pieChart textForSliceAtIndex:(NSUInteger)index {
	return [[values objectAtIndex:index] valueForKey:@"name"];
}
@end
