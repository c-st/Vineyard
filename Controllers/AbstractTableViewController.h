#import <Foundation/Foundation.h>
#import "Wine.h"
#import "Country.h"

@class SettingsCell;

@interface AbstractTableViewController : UITableViewController <NSFetchedResultsControllerDelegate, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate> {
	UISearchBar *searchBar;
	
	SettingsCell *settingsCell;
}

@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@property (nonatomic, strong) SettingsCell* settingsCell;

- (id) initWithFetchedResultsController:(NSFetchedResultsController *)controller;

// filter based on current Wine configuration.
- (NSPredicate*) getFetchPredicate:(Wine *)withWine;

// Custom section header view (implement viewForHeaderInSection and return result of this method).
- (UIView *) tableView:(UITableView *)tableView customViewForHeaderInSection:(NSInteger)section;

@end
