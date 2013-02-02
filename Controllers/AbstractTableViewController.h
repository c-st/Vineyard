#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

#import "SSToolkit/SSToolkit.h"

#import "Wine.h"
#import "Country.h"

#import "UIColor+CellarColours.h"
#import "CellarTableViewCell.h"

#import "UIColor+CellarColours.h"
#import "UIImage+Tint.h"
#import "UIImage+Scale.h"
#import "UIViewController+KNSemiModal.h"
#import "UIView+ObjectTagAdditions.h"

#import "PaperFoldNavigationController.h"
#import "SSToolkit.h"
#import "XYPieChart.h"



@class SettingsCell;

@interface AbstractTableViewController : UITableViewController <NSFetchedResultsControllerDelegate, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, XYPieChartDelegate, XYPieChartDataSource> {
	UISearchBar *searchBar;
	SettingsCell *settingsCell;
	
	PaperFoldNavigationController *paperFoldNC;
	

}

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) SettingsCell* settingsCell;

@property (nonatomic, strong) PaperFoldNavigationController *paperFoldNC;

@property (atomic) BOOL showCount;
@property (atomic) BOOL showSearchBar;
@property (atomic) BOOL showPieChart;
@property (atomic) BOOL allowPaperFoldDragging;


- (id) initWithFetchedResultsController:(NSFetchedResultsController *)controller;

- (void) updateAndRefetch;

// filter based on current Wine configuration.
- (NSPredicate*) getFetchPredicate:(Wine *)withWine;

// Custom section header view (implement viewForHeaderInSection and return result of this method).
- (UIView *) tableView:(UITableView *)tableView customViewForHeaderInSection:(NSInteger)section;

#pragma mark
#pragma mark Count and count Predicate

- (UIView *) buildAccessoryViewFromPredicate:(NSPredicate *)searchPredicate andObject:(NSManagedObject *) object andIndexPath:(NSIndexPath *) indexPath;
- (NSPredicate *) buildCountPredicateForObject:(NSManagedObject *)object;

- (void) filterContentForSearch:(NSString *) searchText;

#pragma mark Pie chart
- (NSIndexPath *) determineIndexPathFromAbsoluteIndex:(NSUInteger)index;
@end
