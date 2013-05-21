#import "AbstractTableViewController.h"

@interface WineTableViewController : AbstractTableViewController {
	UIView *addWineInfoView;
	NSString *addWineInfoText;
}

@property (nonatomic, strong) UIView *addWineInfoView;
@property (nonatomic, strong) NSString *addWineInfoText;
@end
