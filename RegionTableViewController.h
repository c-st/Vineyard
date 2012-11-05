#import <UIKit/UIKit.h>

@interface RegionTableViewController : UITableViewController <NSFetchedResultsControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

- (id) initWithFetchedResultsController:(NSFetchedResultsController *)controller;

@end
