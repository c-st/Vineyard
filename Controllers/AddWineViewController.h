#import <UIKit/UIKit.h>
#import "Wine.h"
#import "AddWineTableViewController.h"

@interface AddWineViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
	AddWineTableViewController *tableView;
	NSArray *configurableProperties;
	Wine *wine;
}

@property (nonatomic, strong) NSArray *configurableProperties;
@property (nonatomic, strong) Wine *wine;
@property (nonatomic, strong) AddWineTableViewController *tableView;

@end
