#import "ColourTableViewController.h"
#import "SettingsCell.h"

#import "GrapeType.h"

@implementation ColourTableViewController

- (id) init {
	if ((self = [super init])) {
		// init
	}
    return self;
}

- (void) viewWillAppear:(BOOL) animated {
	[self setFetchedResultsController:[GrapeType fetchAllSortedBy:@"name" ascending:YES withPredicate:nil groupBy:nil delegate:nil]];
	[super viewWillAppear:animated];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    GrapeType *grapeType = [self.fetchedResultsController objectAtIndexPath:indexPath];
	cell.textLabel.text = [NSString stringWithFormat:@"%@", grapeType.name];
	
	/*
	if ([self showCount]) {
		// count wines
		cell.accessoryView = [self buildAccessoryViewFromPredicate:[self buildCountPredicateForObject:varietal] andObject:varietal andIndexPath:indexPath];
	}
	 */
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ColourCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
		[cell setSelectionStyle:UITableViewCellEditingStyleNone];
    }
	[self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if([super respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
		[super tableView:tableView didSelectRowAtIndexPath:indexPath];
	}
	
	[self.navigationController popViewControllerAnimated:YES];
}

@end
