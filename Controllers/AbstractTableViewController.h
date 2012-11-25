#import <Foundation/Foundation.h>
#import "Wine.h"
#import "Country.h"

#import "SSToolkit.h"

@class SettingsCell;

@interface AbstractTableViewController : UITableViewController <NSFetchedResultsControllerDelegate, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate> {
	UISearchBar *searchBar;
	
	SettingsCell *settingsCell;
	
	BOOL showCount;
	BOOL showSearchBar;
}

@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) SettingsCell* settingsCell;

@property (atomic) BOOL showCount;
@property (atomic) BOOL showSearchBar;


- (id) initWithFetchedResultsController:(NSFetchedResultsController *)controller;

// filter based on current Wine configuration.
- (NSPredicate*) getFetchPredicate:(Wine *)withWine;

// Custom section header view (implement viewForHeaderInSection and return result of this method).
- (UIView *) tableView:(UITableView *)tableView customViewForHeaderInSection:(NSInteger)section;

#pragma mark
#pragma mark Count and count Predicate

- (UIView *) buildAccessoryViewFromPredicate:(NSPredicate *)searchPredicate andObject:(NSManagedObject *) object;
- (NSPredicate *) buildCountPredicateForObject:(NSManagedObject *)object;

- (void) filterContentForSearch:(NSString *) searchText;
@end
