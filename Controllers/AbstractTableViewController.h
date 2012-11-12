#import <Foundation/Foundation.h>
#import "SettingsCell.h"

@interface AbstractTableViewController : UITableViewController <NSFetchedResultsControllerDelegate, UITableViewDataSource, UITableViewDelegate> {
	SettingsCell *settingsCell;
}

@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@property (nonatomic, strong) SettingsCell* settingsCell;

- (id) initWithFetchedResultsController:(NSFetchedResultsController *)controller;

@end
