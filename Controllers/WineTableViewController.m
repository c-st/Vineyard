#import "UIColor+CellarColours.h"
#import "WineTableViewController.h"
#import "Wine.h"
#import "Appellation.h"
#import "WineCell.h"
#import <QuartzCore/QuartzCore.h>

@interface WineTableViewController ()

@end

@implementation WineTableViewController

@synthesize currentlyActiveCell, tapGestureRecognizer;

- (void)viewDidLoad {
    [super viewDidLoad];
	[self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	[self.tableView setRowHeight:145];
	[self.tableView setBackgroundColor:[UIColor cellarBeigeColour]];
	
	// add gesture recognizer
	[self setTapGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditMode:)]];
	[self.tapGestureRecognizer  setCancelsTouchesInView:NO];
	[self.tapGestureRecognizer setEnabled:NO];
	[self.tableView addGestureRecognizer:[self tapGestureRecognizer]];
}

- (void) viewWillAppear:(BOOL)animated {
	[self setFetchedResultsController:[Wine fetchAllSortedBy:@"name" ascending:YES withPredicate:[self getFetchPredicate:nil] groupBy:nil delegate:nil]];
	
	NSError *error;
	if (![[self fetchedResultsController] performFetch:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	}
	
	[super viewWillAppear:animated];
}

- (void) viewDidAppear:(BOOL)animated {
	NSLog(@"We have %i now", [[[Wine fetchAllSortedBy:@"name" ascending:YES withPredicate:[self getFetchPredicate:nil] groupBy:nil delegate:nil] fetchedObjects] count]);
}

- (NSPredicate*) getFetchPredicate:(Wine *)withWine {
	return [NSPredicate predicateWithFormat:@"name.length > 0"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	// set acticated cell deactivated
	if (self.currentlyActiveCell != nil) {
		[self endEditMode:nil];
		[self setCurrentlyActiveCell:nil];
	}

	WineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WineCell"];
	
	if (cell == nil) {
		Wine *wine = [[super fetchedResultsController] objectAtIndexPath:indexPath];
        cell = [[WineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WineCell" andWine:wine];
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
	[self animateCellActivationChange:YES];
}

- (void) animateCellActivationChange:(BOOL)active {
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.x"];
	if (active) {
		[animation setFromValue:[NSNumber numberWithFloat:currentlyActiveCell.cellBackgroundView.layer.position.x]];
		[animation setToValue:[NSNumber numberWithFloat:200]];
	} else {
		[animation setFromValue:[NSNumber numberWithFloat:currentlyActiveCell.cellBackgroundView.layer.position.x]];
		[animation setToValue:[NSNumber numberWithFloat:159.5]];
	}
	
	[animation setDuration:.3];
	[animation setTimingFunction:[CAMediaTimingFunction functionWithControlPoints: .5 :1.8
																				 : 1 :1]];
	
	[currentlyActiveCell.cellBackgroundView.layer addAnimation:animation forKey:@"somekey"];
	[currentlyActiveCell.cellBackgroundView.layer setValue:[animation toValue] forKeyPath:@"position.x"];
}

- (void) endEditMode:(UITapGestureRecognizer *)sender {
	[self animateCellActivationChange:NO];
	[self.tableView setEditing:NO animated:YES];
	//[self.tableView reloadData];
	[tapGestureRecognizer setEnabled:NO];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
}

@end
