#import "AbstractTableViewController.h"
#import "WineCell.h"

@interface WineTableViewController : AbstractTableViewController {
	WineCell *currentlyActiveCell;
	UITapGestureRecognizer *tapGestureRecognizer;
}

@property (nonatomic, strong) WineCell* currentlyActiveCell;
@property (nonatomic, strong) UITapGestureRecognizer* tapGestureRecognizer;

@end
