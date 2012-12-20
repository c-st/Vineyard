#import "ABTableViewCell.h"
#import "AbstractTableViewController.h"

#import "UIColor+CellarColours.h"

#import "Wine.h"

@interface FastWineCell : ABTableViewCell {
	Wine *wine;
	
	__weak AbstractTableViewController *parentTableViewController;
}

@property (nonatomic, strong) Wine *wine;

@property (weak) AbstractTableViewController *parentTableViewController;

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andWine:(Wine *)theWine;

@end