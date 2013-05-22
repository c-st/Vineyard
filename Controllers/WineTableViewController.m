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

@synthesize addWineInfoView, addWineInfoText;

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
	
	// add helpful screen: "Add wines" info
	addWineInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
	[addWineInfoView setBackgroundColor:[UIColor clearColor]];
	[addWineInfoView setHidden:YES];
	UILabel *addLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
	[addLabel setTextAlignment:NSTextAlignmentCenter];
	[addLabel setBackgroundColor:[UIColor clearColor]];
	[addLabel setTextColor:[UIColor darkGrayColor]];
	[addLabel setTextAlignment:NSTextAlignmentCenter];
	[addLabel setNumberOfLines:0];
	[addLabel setFont:[UIFont fontWithName:@"Bradley Hand" size:19]];
	if ([addWineInfoText length] == 0) {
		[addLabel setText:@"Oh... There are no wines yet...\n\n You can add them\n by using the\n button down there!"];
	} else {
		[addLabel setText:addWineInfoText];
	}
	[addWineInfoView addSubview:addLabel];
	[self.tableView setScrollEnabled:YES];
	[self.view addSubview:addWineInfoView];
	
	[self.tableView reloadData];
}

- (void) viewDidAppear:(BOOL)animated {
	// enable paper fold
	[[[self paperFoldNC] paperFoldView] setEnableLeftFoldDragging:NO];
	[[[self paperFoldNC] paperFoldView] setEnableRightFoldDragging:YES];
	[[[self paperFoldNC] paperFoldView] setGestureRecognizerEnabled:YES];
	
	// set wines to fold map view
	UIViewController *viewC = [[self paperFoldNC] rightViewController];
	if ([viewC isKindOfClass:[WineMapFoldViewController class]]) {
		WineMapFoldViewController *wineMapC = (WineMapFoldViewController *) viewC;
		NSArray *fetchResult = self.fetchedResultsController.fetchedObjects;
		if ([fetchResult count] > 0) {
			[wineMapC setWines:fetchResult];
			[addWineInfoView setHidden:YES];
			[self.tableView setScrollEnabled:YES];
		} else {
			NSLog(@"no wines in list");
			[wineMapC setWines:[[NSArray alloc] init]];
			[addWineInfoView setHidden:NO];
			[self.tableView setScrollEnabled:NO];
		}
	}
}

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


- (void) viewWillDisappear:(BOOL)animated {
	if ([[[self paperFoldNC] paperFoldView] state] == PaperFoldStateDefault) {
		//NSLog(@"PaperFoldStateDefault");
	}
}

- (NSPredicate*) getFetchPredicate:(Wine *)withWine {
	return [NSPredicate predicateWithFormat:@"name.length > 0"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
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
	
	// disable map fold in order to retain swipe functionality
	[[[self paperFoldNC] paperFoldView] setEnableRightFoldDragging:NO];
	[[[self paperFoldNC] paperFoldView] setGestureRecognizerEnabled:NO];
	
	// only unfold, if paperfold is not open. otherwise fold back.
	if ([[[self paperFoldNC] paperFoldView] state] == PaperFoldStateDefault) {
		[[self navigationController] pushViewController:wineDetail animated:YES];
	} else {
		[[[self paperFoldNC] paperFoldView] setPaperFoldState:PaperFoldStateDefault animated:YES];
	}
}

- (void) showMapFoldButtonClicked {
	// stop scrolling
	//[self.tableView setContentOffset:self.tableView.contentOffset animated:NO];
	
	NSLog(@"button state is %i", [[[self paperFoldNC] paperFoldView] state]);
	if ([[[self paperFoldNC] paperFoldView] state] == PaperFoldStateDefault) {
		//[[[self paperFoldNC] paperFoldView] setPaperFoldState:PaperFoldStateRightUnfolded animated:YES];
		[[[self paperFoldNC] paperFoldView] setPaperFoldState:PaperFoldStateRightUnfolded animated:NO]; // this seems to work reliably
	} else {
		[[[self paperFoldNC] paperFoldView] setPaperFoldState:PaperFoldStateDefault animated:YES];
	}
}

@end
