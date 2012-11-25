#import <UIKit/UIKit.h>
#import "Wine.h"

@interface AddWineViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
	UITableViewController *tableView;
	NSArray *configurableProperties;
	Wine *wine;
	
	BOOL newWine;
}

@property (nonatomic, strong) NSArray *configurableProperties;
@property (nonatomic, strong) Wine *wine;
@property (nonatomic, strong) UITableViewController *tableView;

@property (atomic) BOOL newWine;

- (void) updateViewFromValidation;

- (id) initWithWine:(Wine *) theWine;
@end
