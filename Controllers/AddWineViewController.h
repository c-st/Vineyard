#import <UIKit/UIKit.h>
#import "Wine.h"
#import "AddWineTableViewController.h"

@interface AddWineViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
	AddWineTableViewController *tableView;
	NSArray *configurableProperties;
	Wine *wine;
	
	BOOL newWine;
}

@property (nonatomic, strong) NSArray *configurableProperties;
@property (nonatomic, strong) Wine *wine;
@property (nonatomic, strong) AddWineTableViewController *tableView;

@property (atomic) BOOL newWine;

- (void) updateViewFromValidation;

- (id) initWithWine:(Wine *) theWine;
@end
