#import <Foundation/Foundation.h>
#import "Wine.h"
#import "Country.h"

#import "SSToolkit/SSBadgeView.h"
#import "SSToolkit/SSLabel.h"

@class SettingsCell;

@interface AbstractTableViewController : UITableViewController <NSFetchedResultsControllerDelegate, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate> {
	UISearchBar *searchBar;
	
	SettingsCell *settingsCell;
	
	BOOL showCount;
}

@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@property (nonatomic, strong) SettingsCell* settingsCell;
@property (atomic) BOOL showCount;


- (id) initWithFetchedResultsController:(NSFetchedResultsController *)controller;

// filter based on current Wine configuration.
- (NSPredicate*) getFetchPredicate:(Wine *)withWine;

// Custom section header view (implement viewForHeaderInSection and return result of this method).
- (UIView *) tableView:(UITableView *)tableView customViewForHeaderInSection:(NSInteger)section;

// Overwrite and return yes to show search bar.
- (BOOL) showSearchBar;

- (SSBadgeView *) buildBadgeView:(NSString *) withText;

- (void) filterContentForSearch:(NSString *) searchText;
@end
