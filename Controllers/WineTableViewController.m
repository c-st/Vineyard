#import "UIColor+CellarColours.h"
#import "UIImage+Tint.h"
#import "WineTableViewController.h"
#import "Wine.h"
#import "Appellation.h"

#import "FastWineCell.h"

#import <QuartzCore/QuartzCore.h>
#import "AddWineViewController.h"
#import "WineDetailViewController.h"

#import "PaperFoldNavigationController.h"

@interface WineTableViewController ()

@end

@implementation WineTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	[self.tableView setRowHeight:120];
	[self.tableView setBackgroundColor:[UIColor cellarBeigeNoisyColour]];
	self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
}

- (void) viewWillAppear:(BOOL)animated {
	if (self.fetchedResultsController == nil) {
		[self setFetchedResultsController:[Wine fetchAllSortedBy:@"name" ascending:YES withPredicate:[self getFetchPredicate:nil] groupBy:nil delegate:nil]];
	}
	if (self.paperFoldNC == nil) {
		NSLog(@"paperFoldNC is nil! this should not be.");
	}
	
	NSError *error;
	[[NSManagedObjectContext defaultContext] reset];
	if (![[self fetchedResultsController] performFetch:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	}
	//NSLog(@"%i wines.", [[[Wine fetchAllSortedBy:@"name" ascending:YES withPredicate:[self getFetchPredicate:nil] groupBy:nil delegate:nil] fetchedObjects] count]);
	[self.tableView reloadData];
}

- (void) viewDidAppear:(BOOL)animated {
	NSLog(@"view did appear");
	// enable left fold
	[[[self paperFoldNC] paperFoldView] setEnableLeftFoldDragging:NO];
	[[[self paperFoldNC] paperFoldView] setEnableRightFoldDragging:YES];
	[[[self paperFoldNC] paperFoldView] setGestureRecognizerEnabled:YES];
}


- (NSPredicate*) getFetchPredicate:(Wine *)withWine {
	return [NSPredicate predicateWithFormat:@"name.length > 0"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	// moved to FastWineCell from WineCell
	FastWineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WineCell"];
	if (cell == nil) {
		Wine *wine = [[super fetchedResultsController] objectAtIndexPath:indexPath];
        cell = [[FastWineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WineCell" andWine:wine];
		[cell setParentTableViewController:self];
    }
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
	Wine *wine = [[super fetchedResultsController] objectAtIndexPath:indexPath];
	WineDetailViewController *wineDetail = [[WineDetailViewController alloc] initWithWine:wine];
	
	// TODO: bug with unbalanced calls
	
	[[[self paperFoldNC] paperFoldView] setPaperFoldState:PaperFoldStateDefault];
	
	[UIView animateWithDuration:0.5 animations:^{
	} completion:^(BOOL finished){
		
	}];
	
	[[self navigationController] pushViewController:wineDetail animated:YES];
	
	// unfold and disable
	[[[self paperFoldNC] paperFoldView] setEnableLeftFoldDragging:NO];
	[[[self paperFoldNC] paperFoldView] setEnableRightFoldDragging:NO];
	[[[self paperFoldNC] paperFoldView] setGestureRecognizerEnabled:NO];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
	NSLog(@"didChangeContent");
}

@end
