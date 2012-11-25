#import <UIKit/UIKit.h>
#import "AbstractTableViewController.h"

@interface VarietalTableViewController : AbstractTableViewController {
	BOOL pickMode;
	
	NSMutableArray *selectedVarietals;
}

@property (atomic) BOOL pickMode;

@property (nonatomic, strong) NSMutableArray* selectedVarietals;

@end
