#import "UIColor+CellarColours.h"
#import "UIImage+Tint.h"
#import "WineTableViewController.h"
#import "Wine.h"
#import "Appellation.h"
#import "WineCell.h"

#import <QuartzCore/QuartzCore.h>
#import "AddWineViewController.h"
#import "WineDetailViewController.h"

#import "PaperFoldNavigationController.h"

@interface WineTableViewController ()

@end

@implementation WineTableViewController

@synthesize currentlyActiveCell, tapGestureRecognizer;

- (void)viewDidLoad {
    [super viewDidLoad];
	[self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	[self.tableView setRowHeight:145];
	[self.tableView setBackgroundColor:[UIColor cellarBeigeNoisyColour]];
	self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 15, 0);
	
	// add gesture recognize
	[self setTapGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditMode:)]];
	[self.tapGestureRecognizer  setCancelsTouchesInView:YES];
	[self.tapGestureRecognizer setEnabled:NO];
	[self.tableView addGestureRecognizer:[self tapGestureRecognizer]];
}

- (void) viewWillAppear:(BOOL)animated {
	if (self.fetchedResultsController == nil) {
		[self setFetchedResultsController:[Wine fetchAllSortedBy:@"name" ascending:YES withPredicate:[self getFetchPredicate:nil] groupBy:nil delegate:nil]];
	}
	
	NSError *error;
	if (![[self fetchedResultsController] performFetch:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	}
	
	NSLog(@"%i wines.", [[[Wine fetchAllSortedBy:@"name" ascending:YES withPredicate:[self getFetchPredicate:nil] groupBy:nil delegate:nil] fetchedObjects] count]);
	
	[self.tableView reloadData];
	
	
}

- (void) viewDidAppear:(BOOL)animated {
	// enable left fold
	[[[self paperFoldNC] paperFoldView] setEnableLeftFoldDragging:YES];
}


- (NSPredicate*) getFetchPredicate:(Wine *)withWine {
	return [NSPredicate predicateWithFormat:@"name.length > 0"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	// set activated cell deactivated
	if (self.currentlyActiveCell != nil) {
		[self endEditMode:nil];
		[self setCurrentlyActiveCell:nil];
	}

	WineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WineCell"];
	if (cell == nil) {
		Wine *wine = [[super fetchedResultsController] objectAtIndexPath:indexPath];
        cell = [[WineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WineCell" andWine:wine];
		[cell setParentTableViewController:self];
    }
	
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here for when you hit delete
		NSLog(@"delete");
    }
}

-(void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
	// set cell active
	WineCell *cell = (WineCell *)[tableView cellForRowAtIndexPath:indexPath];
	[self setCurrentlyActiveCell:cell];
	
	[tapGestureRecognizer setEnabled:YES];
	[currentlyActiveCell animateSwipeCellActivationChange:YES];
}


- (void) endEditMode:(UITapGestureRecognizer *)sender {
	[currentlyActiveCell animateSwipeCellActivationChange:NO];
	[self.tableView setEditing:NO animated:YES];
	[tapGestureRecognizer setEnabled:NO];
	
	[self setCurrentlyActiveCell:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
	// unfold and disable
	[[[self paperFoldNC] paperFoldView] setEnableLeftFoldDragging:NO];
	[[[self paperFoldNC] paperFoldView] setPaperFoldState:PaperFoldStateDefault];
	
	Wine *wine = [[super fetchedResultsController] objectAtIndexPath:indexPath];
	WineDetailViewController *wineDetail = [[WineDetailViewController alloc] initWithWine:wine];
	[[self navigationController] pushViewController:wineDetail animated:YES];;
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
	NSLog(@"didChangeContent");
}

@end
