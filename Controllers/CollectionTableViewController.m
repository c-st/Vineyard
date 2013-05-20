#import "UIColor+CellarColours.h"
#import "CollectionTableViewController.h"
#import "RegionTableViewController.h"
#import "ModalTextFieldView.h"

#import "Collection.h"

#import "UIViewController+KNSemiModal.h"

#import "UIImage+Scale.h"
#import "FastCollectionCell.h"

@interface CollectionTableViewController ()

@end

@implementation CollectionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	[self.tableView setRowHeight:120];
	[self.tableView setBackgroundColor:[UIColor cellarBeigeNoisyColour]];
	self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
}


- (void) viewWillAppear:(BOOL) animated {
	[self setFetchedResultsController:[Collection fetchAllSortedBy:@"name" ascending:YES withPredicate:nil groupBy:nil delegate:nil]];
	[super viewWillAppear:animated];
	
	UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCollectionButtonClicked)];
	[[self navigationItem] setRightBarButtonItem:addButton];
	
	NSLog(@"%i collections.", [[[Collection fetchAllSortedBy:@"name" ascending:YES withPredicate:[self getFetchPredicate:nil] groupBy:nil delegate:nil] fetchedObjects] count]);
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Collection *collection = [self.fetchedResultsController objectAtIndexPath:indexPath];
	
	// cell.imageView.image = [[UIImage imageNamed:[country.isoCode stringByAppendingString:@".png"]] scaleToSize:CGSizeMake(26, 26)];
    cell.textLabel.text = collection.name;
	
	if ([self showCount]) {
		cell.accessoryView = [self buildAccessoryViewFromPredicate:[self buildCountPredicateForObject:collection] andObject:collection andIndexPath:indexPath];
	}
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
	
	NSLog(@"show wines...");
    // ... show wines ...
	//[[self navigationController] pushViewController:regionTableViewController animated:YES];
}

#pragma mark
#pragma mark Modal text field view 

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
