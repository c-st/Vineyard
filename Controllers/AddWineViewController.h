#import <UIKit/UIKit.h>
#import "Wine.h"
@interface AddWineViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
	NSArray *configurableProperties;
	Wine *wine;
}

@property (nonatomic, strong) NSArray *configurableProperties;
@property (nonatomic, strong) Wine *wine;

@end
