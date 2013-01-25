#import "UIColor+CellarColours.h"
#import "UIImage+Tint.h"
#import "WineTableViewController.h"
#import "Wine.h"
#import "Appellation.h"

#import "FastWineCell.h"

#import <QuartzCore/QuartzCore.h>
#import "AddWineViewController.h"
#import "WineDetailViewController.h"

#import "WineMapFoldViewController.h"

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
	
	// show button for map fold
	UIImage *image = [[[UIImage imageNamed:@"map.png"] imageTintedWithColor:[UIColor whiteColor]] scaleToSize:CGSizeMake(16, 16)];
	UIBarButtonItem *mapButton = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(showMapFoldButtonClicked)];
	[[self navigationItem] setRightBarButtonItem:mapButton];
}

- (void) viewWillAppear:(BOOL)animated {
	if (self.fetchedResultsController == nil) {
		[self setFetchedResultsController:[Wine fetchAllSortedBy:@"name" ascending:YES withPredicate:[self getFetchPredicate:nil] groupBy:nil delegate:nil]];
	}
	if (self.paperFoldNC == nil) {
		NSLog(@"wine TVC paperFoldNC is nil! this should not be.");
	}
	
	NSError *error;
	[[NSManagedObjectContext defaultContext] reset];
	if (![[self fetchedResultsController] performFetch:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	}
	
	/*
	int wineCount = [[[Wine fetchAllSortedBy:@"name" ascending:YES withPredicate:[self getFetchPredicate:nil] groupBy:nil delegate:nil] fetchedObjects] count];
	if (wineCount == 0) {
		NSLog(@"no wines yet");
		UIView *addWineView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
		[addWineView setBackgroundColor:[UIColor redColor]];
		[self.view addSubview:addWineView];
	}
	 */
	
	[self.tableView reloadData];
}

- (void) viewDidAppear:(BOOL)animated {
	//NSLog(@"view did appear");
	// enable left fold
	[[[self paperFoldNC] paperFoldView] setEnableLeftFoldDragging:NO];
	[[[self paperFoldNC] paperFoldView] setEnableRightFoldDragging:YES];
	[[[self paperFoldNC] paperFoldView] setGestureRecognizerEnabled:YES];
	
	// set wines to fold map view
	UIViewController *viewC = [[self paperFoldNC] rightViewController];
	if ([viewC isKindOfClass:[WineMapFoldViewController class]]) {
		NSLog(@"WineMapFoldViewController");
		WineMapFoldViewController *wineMapC = (WineMapFoldViewController *) viewC;
		[wineMapC setWines:self.fetchedResultsController.fetchedObjects];
	}
}

- (void) viewWillDisappear:(BOOL)animated {
	// unfold and disable
	[[[self paperFoldNC] paperFoldView] setEnableLeftFoldDragging:NO];
	[[[self paperFoldNC] paperFoldView] setEnableRightFoldDragging:NO];
	//[[[self paperFoldNC] paperFoldView] setGestureRecognizerEnabled:NO];
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
	if ([[[self paperFoldNC] paperFoldView] state] != PaperFoldStateDefault) {
		[[[self paperFoldNC] paperFoldView] setPaperFoldState:PaperFoldStateDefault];
	}
	[[self navigationController] pushViewController:wineDetail animated:YES];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
	NSLog(@"didChangeContent");
}



- (void) showMapFoldButtonClicked {
	NSLog(@"button state is %i", [[[self paperFoldNC] paperFoldView] state]);
	if ([[[self paperFoldNC] paperFoldView] state] == PaperFoldStateDefault) {
		[[[self paperFoldNC] paperFoldView] setPaperFoldState:PaperFoldStateRightUnfolded animated:YES];
		[[[self paperFoldNC] paperFoldView] setPaperFoldState:PaperFoldStateRightUnfolded];
	} else {
		[[[self paperFoldNC] paperFoldView] setPaperFoldState:PaperFoldStateDefault animated:YES];
		[[[self paperFoldNC] paperFoldView] setPaperFoldState:PaperFoldStateDefault];
	}
}

@end
