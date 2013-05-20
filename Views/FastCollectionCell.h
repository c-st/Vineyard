#import "ABTableViewCell.h"
#import "AbstractTableViewController.h"

#import "UIColor+CellarColours.h"

#import "Wine.h"
#import "Collection.h"
#import "Appellation.h"
#import "Country.h"
#import "Region.h"
#import "GrapeType.h"
#import "TemperatureRange.h"


@interface FastCollectionCell : ABTableViewCell {
	Collection *collection;
	
	__weak AbstractTableViewController *parentTableViewController;
}

@property (nonatomic, strong) Collection *collection;

@property (weak) AbstractTableViewController *parentTableViewController;

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andCollection:(Collection *)theCollection;

@end
