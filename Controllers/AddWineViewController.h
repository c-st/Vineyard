#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

#import "Wine.h"
#import "Appellation.h"
#import "Country.h"
#import "Location.h"

@interface AddWineViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate, UIActionSheetDelegate> {
	CLLocationManager *locationManager;

	NSMutableArray *configurableProperties;
	Wine *wine;

	UITableViewController *tableView;
	UIScrollView *scrollView;
	
	BOOL newWine;
}

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSMutableArray *configurableProperties;
@property (nonatomic, strong) Wine *wine;

@property (nonatomic, strong) UITableViewController *tableView;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (atomic) BOOL newWine;

- (void) updateViewFromValidation;

- (id) initWithWine:(Wine *) theWine;
@end
