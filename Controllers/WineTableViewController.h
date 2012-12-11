#import "AbstractTableViewController.h"
#import "WineCell.h"

@interface WineTableViewController : AbstractTableViewController {
	__weak WineCell *currentlyActiveCell;
	UITapGestureRecognizer *tapGestureRecognizer;
}

//@property (nonatomic, strong) WineCell* currentlyActiveCell;
@property (weak) WineCell* currentlyActiveCell;

@property (nonatomic, strong) UITapGestureRecognizer* tapGestureRecognizer;

@end
