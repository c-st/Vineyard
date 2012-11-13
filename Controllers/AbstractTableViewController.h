#import <Foundation/Foundation.h>
#import "Wine.h"
#import "Country.h"

@class SettingsCell;

@interface AbstractTableViewController : UITableViewController <NSFetchedResultsControllerDelegate, UITableViewDataSource, UITableViewDelegate> {
	SettingsCell *settingsCell;
}

@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@property (nonatomic, strong) SettingsCell* settingsCell;

- (id) initWithFetchedResultsController:(NSFetchedResultsController *)controller;
- (NSPredicate*) getFetchPredicate:(Wine *)withWine;

@end
