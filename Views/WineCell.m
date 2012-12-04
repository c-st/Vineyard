#import "WineCell.h"

#import "Wine.h"
#import "Country.h"
#import "Appellation.h"
#import "Region.h"

#import <QuartzCore/QuartzCore.h>

@implementation WineCell

@synthesize wine, cellBackgroundView, toolbarView, parentTableViewController;

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andWine:(Wine *)theWine {
	self = [super initWithFrame:CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height)];
	if (self) {
		[self setWine:theWine];
		
		[self.contentView setBackgroundColor:[UIColor clearColor]];
		
		[self setCellBackgroundView:[self buildWineView]];
		[self.contentView addSubview:[self cellBackgroundView]];
		
		[self buildAndSaveToolbarView];
		[self.contentView addSubview:[self toolbarView]];
		
		[self setBackgroundView:nil];
		[self setSelectionStyle:UITableViewCellSelectionStyleNone];
	}
	return self;
}

- (void) buildAndSaveToolbarView {
	UIView *toolbar = [[UIView alloc] initWithFrame:CGRectMake(10, 24, 59, 112)];
	[toolbar setAlpha:0.0f];
	[toolbar setBackgroundColor:[UIColor clearColor]];
	
	UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[deleteButton addTarget:self action:@selector(deleteWine) forControlEvents:UIControlEventTouchUpInside];
	UIImage *bin = [UIImage imageNamed:@"trashbin.png"];
	[deleteButton setFrame:CGRectMake(15, 10, 38, 38)];
	[deleteButton setImage:bin forState:UIControlStateNormal];
	[toolbar addSubview:deleteButton];
	
	[self displayToolArea:NO];
	[self setToolbarView:toolbar];
}
	 
- (void) deleteWine {
	NSLog(@"deleting wine..");
	[wine deleteEntity];
	[[NSManagedObjectContext defaultContext] saveNestedContexts];
	
	[self.parentTableViewController.fetchedResultsController performFetch:nil];
	[self.parentTableViewController.tableView beginUpdates];
	NSIndexPath *path = [self.parentTableViewController.tableView indexPathForCell:self];
	[self.parentTableViewController.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:path] withRowAnimation:UITableViewRowAnimationRight];
	[self.parentTableViewController.tableView endUpdates];
}

- (UIView*) buildWineView {
	UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(10, 19,
														  self.contentView.bounds.size.width - 21,
														  120)];
	// shadow etc.
	[bg setBackgroundColor:[UIColor whiteColor]];
	bg.layer.shadowColor = [UIColor blackColor].CGColor;
	
	// Name
	UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 7, 200, 18)];
	[nameLabel setBackgroundColor:[UIColor clearColor]];
    [nameLabel setFont:[UIFont boldSystemFontOfSize:16]];
	[nameLabel setTextColor:[UIColor blackColor]];
	[nameLabel setText:[wine name]];
	[bg addSubview:nameLabel];
	
	// Country / Appellation (Region)
	if (wine.country != nil || wine.appellation != nil) {
		if (wine.appellation != nil) {
			UILabel *appellationLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, 200, 13)];
			[appellationLabel setFont:[UIFont boldSystemFontOfSize:12]];
			[appellationLabel setText:[NSString stringWithFormat:@"%@", wine.appellation.name]];
			//[appellationLabel setBackgroundColor:[UIColor redColor]];
			[bg addSubview:appellationLabel];
		}
		
		UIImageView *globeImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"globe.png"]];
		[globeImage setFrame:CGRectMake(10, 95, 16, 16)];
		[bg addSubview:globeImage];
		
		UILabel *localeLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 93, 190, 20)];
		[localeLabel setFont:[UIFont boldSystemFontOfSize:12]];
		//[localeLabel setBackgroundColor:[UIColor redColor]];
		
		if (wine.appellation != nil) {
			[localeLabel setText:[NSString stringWithFormat:@"%@, %@", wine.appellation.region.name, wine.appellation.region.country.name]];
		} else if (wine.appellation == nil && wine.country != nil) {
			[localeLabel setText:[NSString stringWithFormat:@"%@", wine.country.name]];
		}
		[bg addSubview:localeLabel];
	}
	
	if (wine.varietals != nil && [wine.varietals count] > 0) {
		UIImageView *grapesImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"food_grapes_black.png"]];
		[grapesImage setFrame:CGRectMake(9, 40, 18, 18)];
		[bg addSubview:grapesImage];
		
		UILabel *varietalLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 38, 190, 20)];
		NSString *names = [[NSString alloc] init];
		for (NSManagedObject *object in wine.varietals) {
			names = [names stringByAppendingString:[[object valueForKey:@"name"] stringByAppendingString:@", "]];
		}
		[varietalLabel setText:[names substringToIndex:[names length] - 2]];
		//[varietalLabel setBackgroundColor:[UIColor redColor]];
		[varietalLabel setFont:[UIFont boldSystemFontOfSize:12]];
		[bg addSubview:varietalLabel];
	}
	
	if (wine.rating != nil) {
		SSRatingPicker *ratingPicker = [[SSRatingPicker alloc] initWithFrame:CGRectMake(195, 86, 100, 30)];
		//[ratingPicker setBackgroundColor:[UIColor redColor]];
		[ratingPicker setAlpha:0.8f];
		[ratingPicker setSelectedNumberOfStars:[wine.rating floatValue]];
		[ratingPicker setTotalNumberOfStars:6];
		[ratingPicker setStarSize:CGSizeMake(11, 20)];
		[ratingPicker setStarSpacing:3.0f];
		[ratingPicker.textLabel setText:@""];
		[bg addSubview:ratingPicker];
	}

	return bg;
}

- (void) displayToolArea:(BOOL)isDisplay {
	if (isDisplay) {
		[self.toolbarView setAlpha:1.0f];
	} else {
		[self.toolbarView setAlpha:0.0f];
	}
}


- (void) layoutSubviews {
	// add shadow
	self.cellBackgroundView.layer.shadowOpacity = 0.9f;
	self.cellBackgroundView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
	self.cellBackgroundView.layer.shadowRadius = 2.0f;
	self.cellBackgroundView.layer.masksToBounds = NO;
	//[self.cellBackgroundView.layer setShouldRasterize:YES];
	self.cellBackgroundView.layer.opaque = YES;
	self.cellBackgroundView.layer.cornerRadius = 4.0;
	
	[self.cellBackgroundView.layer setShadowPath:[[UIBezierPath bezierPathWithRoundedRect:self.cellBackgroundView.bounds cornerRadius:4.0f] CGPath]];
}

- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
	//[self.textLabel setText:[self.wine name]];

}

@end
