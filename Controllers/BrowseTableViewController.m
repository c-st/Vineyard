
#import "BrowseTableViewController.h"

#import "CountryTableViewController.h"
#import "VarietalTableViewController.h"
#import "RatingTableViewController.h"

#import "UIImage+Tint.h"

@interface BrowseTableViewController ()

@end

@implementation BrowseTableViewController

@synthesize tableGroups;

- (id) initWithStyle:(UITableViewStyle)style {
	if ((self = [super initWithStyle:style])) {
		
	}
    return self;
}
	
- (void) loadView {
	if (self.paperFoldNC == nil) {
		NSLog(@"browseTVC paperFoldNC is nil! this should not be.");
	}
	[super loadView];
	
	// Countries
	NSFetchedResultsController *countriesFRC = [Country fetchAllSortedBy:@"name" ascending:YES withPredicate:nil groupBy:nil delegate:nil];
	CountryTableViewController *countryTVC = [[CountryTableViewController alloc] initWithFetchedResultsController:countriesFRC];
	[countryTVC setTitle:@"Countries"];
	[countryTVC setShowCount:YES];
	[countryTVC setShowPieChart:YES];
	[countryTVC setPaperFoldNC:self.paperFoldNC];
	
	// Varietals
	VarietalTableViewController *varietalTVC = [[VarietalTableViewController alloc] init];
	[varietalTVC setTitle:@"Varietals"];
	[varietalTVC setShowCount:YES];
	[varietalTVC setPickMode:NO];
	[varietalTVC setShowPieChart:YES];
	[varietalTVC setPaperFoldNC:self.paperFoldNC];
	
	// Ratings
	RatingTableViewController *ratingTVC = [[RatingTableViewController alloc] init];
	[ratingTVC setTitle:@"Ratings"];
	[ratingTVC setShowCount:YES];
	[ratingTVC setShowPieChart:YES];
	[ratingTVC setPaperFoldNC:self.paperFoldNC];
	
	self.tableGroups = @[
						@[
							@{@"name" : @"Country", @"controller" : countryTVC, @"image" : @"globe-icon.png"},
							@{@"name" : @"Date added", @"controller" : countryTVC},
						],
						@[
							@{@"name" : @"Vintage", @"controller" : countryTVC},
							@{@"name" : @"Varietal", @"controller" : varietalTVC, @"image" : @"food_grapes.png"},
							@{@"name" : @"Matching food", @"controller" : countryTVC}
						],
						@[
							@{@"name" : @"Rating", @"controller" : ratingTVC, @"image" : @"badge.png"},
							@{@"name" : @"Price", @"controller" : countryTVC}
						],
						@[
							@{@"name" : @"Characteristics", @"controller" : countryTVC},
							@{@"name" : @"Tags", @"controller" : countryTVC}
						]
					];
}

- (void) viewWillAppear:(BOOL) animated {
	[self.tableView setBackgroundColor:[UIColor cellarBeigeNoisyColour]];
	[self.tableView setBackgroundView:nil];
	
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return [self.tableGroups count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.tableGroups objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"BrowseCell";
    CellarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CellarTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
		[cell setSelectionStyle:UITableViewCellEditingStyleNone];
		[cell setShowArrow:YES];
    }
	[self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
	NSDictionary *item = [[self.tableGroups objectAtIndex:indexPath.section] objectAtIndex:[indexPath row]];
	cell.textLabel.text = [item objectForKey:@"name"];
	[cell.imageView setImage:[[UIImage imageNamed:[item objectForKey:@"image"]] imageTintedWithColor:[UIColor cellarWineRedColour]]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSDictionary *item = [[self.tableGroups objectAtIndex:indexPath.section] objectAtIndex:[indexPath row]];
	[self.navigationController pushViewController:[item objectForKey:@"controller"] animated:YES];
}

@end
