#import "AbstractTableViewController.h"
#import "SettingsCell.h"


@interface AbstractTableViewController ()

@end

@implementation AbstractTableViewController

@synthesize settingsCell;
@synthesize fetchedResultsController = fetchedResultsController;
@synthesize managedObjectContext = _managedObjectContext;

#pragma mark
#pragma mark Initialization

// Do not use this one. Use initWithFetchedResultsController.
- (id)init {
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}

- (id) initWithFetchedResultsController:(NSFetchedResultsController *)controller {
    if ((self = [super init])) {
        fetchedResultsController = controller;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSError *error;
	if (![[self fetchedResultsController] performFetch:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	}
}

-(void) viewWillAppear:(BOOL)animated {
	[self.tableView reloadData];
}

- (void)viewDidUnload {
    self.fetchedResultsController = nil;
}

#pragma mark
#pragma mark Table view delegate methods

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	UIView* sectionHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 18)];
    sectionHead.backgroundColor = [UIColor colorWithRed:(111.0f/255.0f) green:(23.0f/255.0f) blue:(54.0f/255.0f) alpha:0.8f];
    sectionHead.userInteractionEnabled = YES;
    sectionHead.tag = section;
	
	UIImageView *headerImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PlainTableViewSectionHeader.png"]];
    headerImage.contentMode = UIViewContentModeScaleAspectFit;
	
    [sectionHead addSubview:headerImage];
	
	UILabel *sectionText = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, tableView.bounds.size.width - 10, 18)];
    sectionText.text = [self tableView:tableView titleForHeaderInSection:section];
    sectionText.backgroundColor = [UIColor clearColor];
    sectionText.textColor = [UIColor whiteColor];
    sectionText.shadowColor = [UIColor darkGrayColor];
    sectionText.shadowOffset = CGSizeMake(0,1);
    sectionText.font = [UIFont boldSystemFontOfSize:18];
	
	[sectionHead addSubview:sectionText];
	
	return sectionHead;
}

/** 
 If not customized, assume that we are a value pick controller. Return value to our settingsCell.
 If customized, take care to also call this method from the child methods:
	if([super respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
		[super tableView:tableView didSelectRowAtIndexPath:indexPath];
	}
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
	if ([self settingsCell] != nil) {
		// hand value to settings cell.
		NSLog(@"value is handed to settingsCell...");
		[[self settingsCell] valueWasSelected:[[self fetchedResultsController] objectAtIndexPath:indexPath]];
		[self.navigationController popViewControllerAnimated:YES];
	}
}

// Can/Should be customized in subclass

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id  sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

/**
 Implement, if the results from the fetchController should be filtered.
 */
- (NSPredicate*) getFetchPredicate:(Wine *)withWine {
	return nil;
}



@end
