#import "UIColor+CellarColours.h"
#import "CollectionTableViewController.h"
#import "RegionTableViewController.h"

#import "ModalTextFieldView.h"
#import "ModalCollectionDeleteView.h"

#import "WineTableViewController.h"

#import "Collection.h"

#import "UIViewController+KNSemiModal.h"

#import "UIImage+Scale.h"
#import "UIImage+Tint.h"
#import "FastCollectionCell.h"

@interface CollectionTableViewController ()

@end

@implementation CollectionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	[self.tableView setRowHeight:70];
	[self.tableView setBackgroundColor:[UIColor cellarBeigeNoisyColour]];
	self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
}


- (void) viewWillAppear:(BOOL) animated {
	[self setFetchedResultsController:[Collection fetchAllSortedBy:@"name" ascending:YES withPredicate:nil groupBy:nil delegate:nil]];
	[super viewWillAppear:animated];
	
	UIBarButtonItem *deleteButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteCollectionButtonClicked)];
	[[self navigationItem] setLeftBarButtonItem:deleteButton];
	
	UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCollectionButtonClicked)];
	[[self navigationItem] setRightBarButtonItem:addButton];

	NSLog(@"%i collections.", [[[Collection fetchAllSortedBy:@"name" ascending:YES withPredicate:[self getFetchPredicate:nil] groupBy:nil delegate:nil] fetchedObjects] count]);
}


- (NSPredicate *) buildCountPredicateForObject:(NSManagedObject *)object {
	Collection* collection = (Collection *) object;
	return [NSPredicate predicateWithFormat:@"ANY collections == %@", collection];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	FastCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WineCell"];
	if (cell == nil) {
		Collection *collection = [[super fetchedResultsController] objectAtIndexPath:indexPath];
        cell = [[FastCollectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CollectionCell" andCollection:collection];
		[cell setParentTableViewController:self];
    }
    return cell;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CollectionCell";
    CellarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CellarTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
		if ([self showCount]) {
			[cell setShowArrow:YES];
		}
    }
   [self configureCell:cell atIndexPath:indexPath];
    return cell;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
	if([super respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
		[super tableView:tableView didSelectRowAtIndexPath:indexPath];
	}
	
	Collection *collection = [[super fetchedResultsController] objectAtIndexPath:indexPath];
	NSFetchedResultsController *wineSearchController = [Wine fetchAllSortedBy:@"name" ascending:YES withPredicate:[self buildCountPredicateForObject:collection] groupBy:nil delegate:self];
	
	//NSPredicate *searchStatement = [NSPredicate predicateWithFormat:@"appellation.appellationID == %@", appellation.appellationID];
	
	WineTableViewController *wineTableViewController = [[WineTableViewController alloc] initWithFetchedResultsController:wineSearchController];
	[wineTableViewController setTitle:collection.name];
	[wineTableViewController setShowCount:NO];
	[wineTableViewController setPaperFoldNC:self.paperFoldNC];
	//if ([wineSearchController.fetchedObjects count] > 0) {
		[[self navigationController] pushViewController:wineTableViewController animated:YES];
	//}
	
	
	NSLog(@"show wines...");
    // ... show wines ...
	//[[self navigationController] pushViewController:regionTableViewController animated:YES];
}

#pragma mark
#pragma mark Modal text field view

- (void) deleteCollectionButtonClicked {
	ModalCollectionDeleteView *modaCollectionDeleteView = [[ModalCollectionDeleteView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)];
	[modaCollectionDeleteView setDelegate:self];
	
	[self presentSemiView:modaCollectionDeleteView withOptions:@{
	 KNSemiModalOptionKeys.pushParentBack    : @(YES),
	 KNSemiModalOptionKeys.animationDuration : @(0.25),
	 KNSemiModalOptionKeys.shadowOpacity     : @(0.3),
	 KNSemiModalOptionKeys.parentAlpha		 : @(0.2)
	 }];
}

- (void) addCollectionButtonClicked {
	ModalTextFieldView *modalTextFieldView = [[ModalTextFieldView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 400)];
	[modalTextFieldView setDelegate:self];
	
	[self presentSemiView:modalTextFieldView withOptions:@{
		KNSemiModalOptionKeys.pushParentBack    : @(YES),
		KNSemiModalOptionKeys.animationDuration : @(0.25),
		KNSemiModalOptionKeys.shadowOpacity     : @(0.3),
		KNSemiModalOptionKeys.parentAlpha		 : @(0.4)
	 }];
}

- (void) cancelButtonPressed:(UITextField*) textField {
	[textField resignFirstResponder];
	[self dismissSemiModalView];
	[self updateAndRefetch];
}

- (void) saveButtonPressed:(UITextField*) textField {
	if ([textField.text length] > 0) {
		// save
		Collection *collection = [Collection createEntity];
		[collection setName:[textField text]];
		[[NSManagedObjectContext defaultContext] saveToPersistentStoreAndWait];
		
		[self updateAndRefetch];
		
		[textField resignFirstResponder];
		[self dismissSemiModalView];
	}
}



@end
