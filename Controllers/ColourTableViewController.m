#import "ColourTableViewController.h"
#import "SettingsCell.h"

@implementation ColourTableViewController

@synthesize colours;

- (id) init {
	if ((self = [super init])) {
		// init
		[self setColours:[NSArray arrayWithObjects:@"Red", @"White", @"Rosé", nil]];
	}
    return self;
}

- (void) viewWillAppear:(BOOL)animated {
	//[self setFetchedResultsController:[Varietal fetchAllGroupedBy:@"grapeType" withPredicate:self.settingsCell.wine != nil ? [self getFetchPredicate:self.settingsCell.wine]:nil sortedBy:@"grapeType.name" ascending:YES]];
	[super viewWillAppear:animated];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [colours count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
	cell.textLabel.text = [NSString stringWithFormat:@"%@", [colours objectAtIndex:indexPath.row]];
	
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
	[[self settingsCell] objectValueWasSelected:[[self colours]objectAtIndex:indexPath.row]];
	
	[self.navigationController popViewControllerAnimated:YES];
}

@end
