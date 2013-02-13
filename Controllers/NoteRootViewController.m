#import "NoteRootViewController.h"
#import "UIColor+CellarColours.h"
#import "WineTableViewController.h"
#import "ModalTextFieldView.h"

#import "Collection.h"

#import "UIViewController+KNSemiModal.h"

@interface NoteRootViewController ()

@end

@implementation NoteRootViewController

- (id) init {
	if ((self = [super init])) {
		self.noteViewController = [[KLNoteViewController alloc] init];
		[self.noteViewController setDataSource:self];
		[self.noteViewController setDelegate:self];
		
		[self setFetchedResultsController:[Collection fetchAllSortedBy:@"name" ascending:YES withPredicate:nil groupBy:nil delegate:nil]];
	}
    return self;
}

- (void) viewDidLoad {
    [super viewDidLoad];
	[self.navigationController.navigationBar setTintColor:[UIColor cellarWineRedColour]];
	
	UIButton *addCollectionButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[addCollectionButton setFrame:CGRectMake(93, 20, 120, 30)];
	[addCollectionButton setTitle:@"Add collection" forState:UIControlStateNormal];
	[addCollectionButton addTarget:self action:@selector(addCollectionButtonClicked) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:addCollectionButton];
	
	
	[self updateAndRefetch];
	[self.view addSubview:self.noteViewController.view];
	[self.view setBackgroundColor:[UIColor blackColor]];
}

- (void) updateAndRefetch {
	[self.fetchedResultsController.fetchRequest setFetchBatchSize:20];
	
	NSError *error;
	if (![[self fetchedResultsController] performFetch:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	}
    [self.noteViewController reloadData];
}

- (NSPredicate *) buildCountPredicateForObject:(NSManagedObject *)object {
	Collection* collection = (Collection *) object;
	return [NSPredicate predicateWithFormat:@"ANY collections == %@", collection];
}

#pragma mark
#pragma mark NoteViewController delegate methods

- (NSInteger)numberOfControllerCardsInNoteView:(KLNoteViewController*) noteView {
	return [self.fetchedResultsController.fetchedObjects count];
}

- (UIViewController *)noteView:(KLNoteViewController*)noteView viewControllerForRowAtIndexPath:(NSIndexPath *)indexPath {
	Collection *c = [self.fetchedResultsController objectAtIndexPath:indexPath];

	NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
	NSFetchedResultsController *wineSearchController = [Wine fetchAllSortedBy:@"name" ascending:YES withPredicate:[self buildCountPredicateForObject:c] groupBy:nil delegate:nil];
	
	WineTableViewController *wineTableViewController = [[WineTableViewController alloc] initWithFetchedResultsController:wineSearchController];
	[wineTableViewController setTitle:[object valueForKey:@"name"]];
	[wineTableViewController setShowCount:NO];
	//[wineTableViewController setPaperFoldNC:self.paperFoldNC];
	//[[self navigationController] pushViewController:wineTableViewController animated:YES];
	
	return wineTableViewController;
}

-(void) noteViewController: (KLNoteViewController*) noteViewController didUpdateControllerCard:(KLControllerCard*)controllerCard toDisplayState:(KLControllerCardState) toState fromDisplayState:(KLControllerCardState) fromState {
	
   // NSLog(@"changed state %ld", toState);
}

#pragma mark
#pragma mark Modal text field view

- (void) addCollectionButtonClicked {
	NSLog(@"button");
	
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
