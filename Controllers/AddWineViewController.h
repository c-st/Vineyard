#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

#import "Wine.h"
#import "Appellation.h"
#import "Country.h"
#import "Location.h"

@interface AddWineViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate> {
	CLLocationManager *locationManager;
	UITableViewController *tableView;
	NSArray *configurableProperties;
	Wine *wine;
	
	BOOL newWine;
}

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSArray *configurableProperties;
@property (nonatomic, strong) Wine *wine;
@property (nonatomic, strong) UITableViewController *tableView;

@property (atomic) BOOL newWine;

- (void) updateViewFromValidation;

- (id) initWithWine:(Wine *) theWine;
@end
