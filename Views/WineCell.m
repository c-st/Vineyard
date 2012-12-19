#import "WineCell.h"

#import "Wine.h"
#import "Country.h"
#import "Appellation.h"
#import "Region.h"
#import "GrapeType.h"

#import "UIColor+CellarColours.h"
#import "UIImage+Tint.h"

#import <QuartzCore/QuartzCore.h>

#import "SSToolkit.h"

@implementation WineCell

@synthesize wine, cellBackgroundView, toolbarView, parentTableViewController;

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andWine:(Wine *)theWine {
	self = [super initWithFrame:CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height)];
	if (self) {
		[self setWine:theWine];
		
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
	[toolbar setBackgroundColor:[UIColor cellarGrayColour]];
	
	UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[deleteButton addTarget:self action:@selector(deleteWine) forControlEvents:UIControlEventTouchUpInside];
	UIImage *bin = [UIImage imageNamed:@"trashbin.png"];
	[deleteButton setFrame:CGRectMake(15, 30, 38, 38)];
	[deleteButton setImage:bin forState:UIControlStateNormal];
	[toolbar addSubview:deleteButton];
	
	[self displayToolArea:NO];
	[self setToolbarView:toolbar];
}
	 
- (void) deleteWine {
	NSLog(@"deleting wine..");
	NSIndexPath *path = [self.parentTableViewController.tableView indexPathForCell:self];

	[self.parentTableViewController.tableView beginUpdates];
	[self.parentTableViewController.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:path] withRowAnimation:UITableViewRowAnimationRight];

	[wine deleteEntity];
	[[NSManagedObjectContext defaultContext] saveNestedContexts];
	[self.parentTableViewController.fetchedResultsController performFetch:nil];
	[self.parentTableViewController.tableView endUpdates];
	
	[UIView animateWithDuration:0.2 animations:^{
		[self.parentTableViewController.tableView reloadData];
	}];
}

- (UIView*) buildWineView {
	UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(10, 19,
														  self.contentView.bounds.size.width - 21,
														  120)];
	
	[bg setOpaque:YES];
	
	// Name
	UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 240, 25)];
	[nameLabel setBackgroundColor:[UIColor cellarGrayColour]];
    [nameLabel setFont:[UIFont fontWithName:@"Baskerville" size:20]];
	[nameLabel setTextColor:[UIColor blackColor]];
	[nameLabel setText:[wine name]];
	[bg addSubview:nameLabel];
	
	// Vintage
	if (wine.vintage != nil) {
		UILabel *vintageLabel = [[UILabel alloc] initWithFrame:CGRectMake(252, 15, 40, 18)];
		[vintageLabel setBackgroundColor:[UIColor cellarGrayColour]];
		[vintageLabel setFont:[UIFont fontWithName:@"Baskerville" size:18]];
		[vintageLabel setTextColor:[UIColor darkGrayColor]];
		[vintageLabel setText:[wine vintage]];
		[bg addSubview:vintageLabel];
	}
	
	// Line
	SSLineView *lineView = [[SSLineView alloc] initWithFrame:CGRectMake(10, 38, 280, 3)];
	[lineView setLineColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.2]];
	[lineView setInsetColor:[UIColor whiteColor]];
	[bg addSubview:lineView];
	
	// Country / Appellation (Region)
	if (wine.country != nil || wine.appellation != nil) {
		if (wine.appellation != nil) {
			UILabel *appellationLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 45, 150, 13)];
			[appellationLabel setBackgroundColor:[UIColor cellarGrayColour]];
			[appellationLabel setTextColor:[[UIColor blackColor] colorWithAlphaComponent:0.85]];
			[appellationLabel setFont:[UIFont systemFontOfSize:12]];
			[appellationLabel setText:[NSString stringWithFormat:@"%@", wine.appellation.name]];
			//[appellationLabel setBackgroundColor:[UIColor redColor]];
			[bg addSubview:appellationLabel];
		}
		
		UIImageView *globeImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"globe.png"]];
		[globeImage setBackgroundColor:[UIColor cellarGrayColour]];
		[globeImage setFrame:CGRectMake(10, 95, 16, 16)];
		[bg addSubview:globeImage];
		
		UILabel *localeLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 93, 190, 20)];
		[localeLabel setBackgroundColor:[UIColor cellarGrayColour]];
		[localeLabel setFont:[UIFont systemFontOfSize:12]];
		//[localeLabel setBackgroundColor:[UIColor redColor]];
		
		if (wine.appellation != nil) {
			[localeLabel setText:[NSString stringWithFormat:@"%@, %@", wine.appellation.region.name, wine.appellation.region.country.name]];
		} else if (wine.appellation == nil && wine.country != nil) {
			[localeLabel setText:[NSString stringWithFormat:@"%@", wine.country.name]];
		}
		[bg addSubview:localeLabel];
	}
	
	// Colour
	if (wine.colour != nil) {
		UIImage *bottle;
		if ([wine.colour.grapeTypeID isEqual: @"red"]) {
			bottle = [[UIImage imageNamed:@"wine_bottle.png"] imageTintedWithColor:[UIColor cellarWineColourRed]];
		} else if ([wine.colour.grapeTypeID isEqual: @"white"]) {
			bottle = [[UIImage imageNamed:@"wine_bottle.png"] imageTintedWithColor:[UIColor cellarWineColourWhite]];
		} else if ([wine.colour.grapeTypeID isEqual: @"white"]) {
			bottle = [[UIImage imageNamed:@"wine_bottle.png"] imageTintedWithColor:[UIColor cellarWineColourRose]];
		}

		UIImageView *bottleImage = [[UIImageView alloc] initWithImage:bottle];
		[bottleImage setFrame:CGRectMake(253, 35, 35, 35)];
		[bottleImage setAlpha:0.8];
		[bg addSubview:bottleImage];
	}
	
	// Varietal
	if (wine.varietals != nil && [wine.varietals count] > 0) {
		UIImageView *grapesImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"food_grapes_black.png"]];
		[grapesImage setBackgroundColor:[UIColor cellarGrayColour]];
		[grapesImage setFrame:CGRectMake(9, 70, 18, 18)];
		[bg addSubview:grapesImage];
		
		UILabel *varietalLabel = [[UILabel alloc] initWithFrame:CGRectMake(29, 70, 190, 20)];
		[varietalLabel setBackgroundColor:[UIColor cellarGrayColour]];
		NSString *names = [[NSString alloc] init];
		for (NSManagedObject *object in wine.varietals) {
			names = [names stringByAppendingString:[[object valueForKey:@"name"] stringByAppendingString:@", "]];
		}
		[varietalLabel setText:[names substringToIndex:[names length] - 2]];
		//[varietalLabel setBackgroundColor:[UIColor redColor]];
		[varietalLabel setFont:[UIFont systemFontOfSize:12]];
		[bg addSubview:varietalLabel];
	}
	
	if (wine.rating != nil) {
		SSRatingPicker *ratingPicker = [[SSRatingPicker alloc] initWithFrame:CGRectMake(195, 86, 100, 30)];
		//[ratingPicker setBackgroundColor:[UIColor redColor]];
		[ratingPicker setAlpha:1.0f];
		[ratingPicker setBackgroundColor:[UIColor cellarGrayColour]];
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

- (void) animateSwipeCellActivationChange:(BOOL)active {
	NSNumber *targetValue = active ? [NSNumber numberWithFloat:220] : [NSNumber numberWithFloat:159.5];
	
	// set position.x of cell
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.x"];
	[animation setFromValue:[NSNumber numberWithFloat:self.cellBackgroundView.layer.position.x]];
	[animation setToValue:targetValue];
	
	[animation setDuration:.2];
	[animation setTimingFunction:[CAMediaTimingFunction functionWithControlPoints: .5 :1.8: 1 :1]];
	
	[self.cellBackgroundView.layer addAnimation:animation forKey:@"animation-somekey"];
	//[self.cellBackgroundView.layer setValue:[animation toValue] forKeyPath:@"position.x"];
	[self.cellBackgroundView.layer setPosition:CGPointMake([targetValue floatValue], self.cellBackgroundView.layer.position.y)];
	[self.cellBackgroundView setNeedsLayout];
	
	if (active) {
		[UIView animateWithDuration:0.1 animations:^{
			[self displayToolArea:YES];
		}];
	}
	
	if (!active) {
		[UIView animateWithDuration:0.05 animations:^{
			[self displayToolArea:NO];
		}];
	}
}

- (void) layoutSubviews {

}

- (void)drawRect:(CGRect)rect {
	//[super drawRect:rect];
	[self.cellBackgroundView setBackgroundColor:[UIColor cellarGrayColour]];
	[self.cellBackgroundView setOpaque:YES];
	
	// add shadow
	self.cellBackgroundView.layer.shadowOpacity = 0.9f;
	self.cellBackgroundView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
	self.cellBackgroundView.layer.shadowColor = [UIColor blackColor].CGColor;
	self.cellBackgroundView.layer.shadowRadius = 2.0f;
	self.cellBackgroundView.layer.masksToBounds = NO;
	//[self.cellBackgroundView.layer setShouldRasterize:YES];
	self.cellBackgroundView.layer.opaque = YES;
	self.cellBackgroundView.layer.cornerRadius = 4.0;
	[self.cellBackgroundView.layer setShadowPath:[[UIBezierPath bezierPathWithRoundedRect:self.cellBackgroundView.bounds cornerRadius:4.0f] CGPath]];
	
	// stroke
	self.cellBackgroundView.layer.borderColor =	[[UIColor blackColor] CGColor];
	self.cellBackgroundView.layer.borderWidth = 0.5f;
}

@end
