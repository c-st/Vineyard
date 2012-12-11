#import <UIKit/UIKit.h>
#import "Wine.h"
#import "AbstractTableViewController.h"


@interface WineCell : UITableViewCell {
	Wine *wine;
	UIView *cellBackgroundView;
	UIView *toolbarView;
	
	__weak AbstractTableViewController *parentTableViewController;
}

@property (retain, nonatomic) UIView* cellBackgroundView;
@property (retain, nonatomic) UIView* toolbarView;
@property (nonatomic, strong) Wine *wine;

@property (weak) AbstractTableViewController *parentTableViewController;

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andWine:(Wine *)theWine;

- (void) displayToolArea:(BOOL)isDisplay;
- (void) animateSwipeCellActivationChange:(BOOL)active;
@end
