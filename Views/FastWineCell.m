#import "FastWineCell.h"

#import "UIImage+Scale.h"
#import "UIImage+Tint.h"

@implementation FastWineCell

@synthesize wine, parentTableViewController;

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andWine:(Wine *)theWine {
	self = [super initWithFrame:CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height)];
	if (self) {
		[self setWine:theWine];
	}
	return self;
}

- (void) drawWineCellContainer:(CGRect)rect context:(CGContextRef) context {
	UIColor *backgroundColor = [UIColor cellarBeigeNoisyColour];
	[backgroundColor set];
	CGContextFillRect(context, rect);
	
	float shadowRadius = 5.0f;
	float cornerRadius = 3.0f;
	float padding = 6.0f;
	
	CGRect bounds = CGRectMake(padding, padding, self.contentView.bounds.size.width - (2 * padding), self.contentView.bounds.size.height - (2 * padding));
	CGRect contentRect = CGRectInset(bounds, shadowRadius, shadowRadius);
	
	CGContextSaveGState(context); //save state
	
	/* Create the rounded path and fill it */
    UIBezierPath *roundedPath = [UIBezierPath bezierPathWithRoundedRect:contentRect cornerRadius:cornerRadius];
    CGContextSetFillColorWithColor(context, [UIColor cellarGrayColour].CGColor);
	/* // disabled due to performance problems
	 CGContextSetShadowWithColor(context, CGSizeMake(0.0, 0.0), shadowRadius, [UIColor blackColor].CGColor);
	 */
	[roundedPath fill];
	

	[roundedPath addClip];
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:1.0 alpha:0.6].CGColor);
    CGContextSetBlendMode(context, kCGBlendModeOverlay);
	
    CGContextMoveToPoint(context, CGRectGetMinX(contentRect), CGRectGetMinY(contentRect)+0.5);
    CGContextAddLineToPoint(context, CGRectGetMaxX(contentRect), CGRectGetMinY(contentRect)+0.5);
    CGContextStrokePath(context);
	
	CGContextRestoreGState(context); // restore state
	
	// add stroke around rectangle
	CGContextSaveGState(context);
	CGContextAddPath(context, roundedPath.CGPath);
	CGContextClip(context);
	
	CGContextRestoreGState(context);
	CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:0.0 alpha:0.3].CGColor);
	CGContextAddPath(context, roundedPath.CGPath);
	CGContextDrawPath(context, kCGPathStroke);
	
	// draw line
	CGContextSaveGState(context);
	CGRect lineBounds = CGRectMake(18, 38, 300, 0);
	
	CGContextSetLineWidth(context, 1.0f);
	CGContextSetStrokeColorWithColor(context, [[UIColor lightGrayColor] colorWithAlphaComponent:0.2].CGColor);
	CGContextMoveToPoint(context, lineBounds.origin.x, lineBounds.origin.y);
	CGContextAddLineToPoint(context, lineBounds.size.width, lineBounds.origin.y);
	CGContextStrokePath(context);
	
	CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
	CGContextMoveToPoint(context, lineBounds.origin.x, lineBounds.origin.y + 1.0);
	CGContextAddLineToPoint(context, lineBounds.size.width, lineBounds.origin.y + 1.0);
	CGContextStrokePath(context);
	
	CGContextRestoreGState(context);
}

- (void) drawRating:(CGRect)rect {
	if (wine.rating == nil) {
		return;
	}
	
	SSRatingPicker *ratingPicker = [[SSRatingPicker alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
	[ratingPicker setStarSize:CGSizeMake(11, 20)];
	[ratingPicker setStarSpacing:3.0f];
	[ratingPicker setTotalNumberOfStars:6];
	[ratingPicker.textLabel setText:@""];
	[ratingPicker setSelectedNumberOfStars:self.wine.ratingValue];
	[ratingPicker drawRect:rect];
}

- (void) drawName:(CGPoint) point {
	UIFont *font = [UIFont fontWithName:@"Baskerville" size:20];
	UIColor *textColor = [UIColor blackColor];
	[textColor set];
	[self.wine.name drawAtPoint:point withFont:font];
}

- (void) drawVintage:(CGPoint) point {
	if (wine.vintage == nil || [wine.vintage intValue] == 0) {
		return;
	}
	
	UIFont *font = [UIFont fontWithName:@"Baskerville" size:18];
	UIColor *textColor = [UIColor darkGrayColor];
	[textColor set];
	[[NSString stringWithFormat:@"%@", self.wine.vintage] drawAtPoint:point withFont:font];
}

- (void) drawAppellationRegion:(CGPoint) appellationPoint localizationPoint:(CGPoint) localizationPoint {
	if (wine.country != nil || wine.appellation != nil) {
		UIFont *font = [UIFont systemFontOfSize:12];
		UIColor *textColor = [UIColor blackColor];
		[textColor set];
		
		if (wine.appellation != nil) {
			//appellation
			[[NSString stringWithFormat:@"%@", wine.appellation.name] drawAtPoint:appellationPoint withFont:font];
		}
		
		// globe image
		[[[UIImage imageNamed:@"globe.png"] scaleToSize:CGSizeMake(12, 12)] drawAtPoint:localizationPoint];
		
		// localization text
		float leftPadding = 16;
			float topPadding = -2;
		if (wine.appellation != nil) {
			[[NSString stringWithFormat:@"%@, %@", wine.appellation.region.name, wine.appellation.region.country.name] drawAtPoint:
				CGPointMake(localizationPoint.x + leftPadding, localizationPoint.y + topPadding) withFont:font];
			 
		} else if (wine.appellation == nil && wine.country != nil) {
			[[NSString stringWithFormat:@"%@", wine.country.name] drawAtPoint:
				CGPointMake(localizationPoint.x + leftPadding, localizationPoint.y + topPadding) withFont:font];
		}
	}
}

- (void) drawVarietals:(CGPoint) varietalPoint {
	if (wine.varietals == nil || [wine.varietals count] == 0) {
		return;
	}
	
	UIFont *font = [UIFont systemFontOfSize:12];
	UIColor *textColor = [UIColor blackColor];
	[textColor set];
	
	// grape image
	[[[UIImage imageNamed:@"food_grapes_black.png"] scaleToSize:CGSizeMake(16, 16)] drawAtPoint:varietalPoint];
	
	// varietals text
	float leftPadding = 16;
	float topPadding = 2;
	
	NSString *names = [[NSString alloc] init];
	for (NSManagedObject *object in wine.varietals) {
		names = [names stringByAppendingString:[[object valueForKey:@"name"] stringByAppendingString:@", "]];
	}
	names = [names substringToIndex:[names length] - 2];
	
	[names drawAtPoint:CGPointMake(varietalPoint.x + leftPadding, varietalPoint.y + topPadding) withFont:font];
}

- (void) drawTemperature:(CGPoint) temperaturePoint {
	if (wine.servingTemperature == nil) {
		return;
	}
	
	UIFont *font = [UIFont systemFontOfSize:12];
	UIColor *textColor = [UIColor blackColor];
	[textColor set];
	
	float leftPadding = 12;
	
	// thermometer image
	[[[UIImage imageNamed:@"thermometer.png"] scaleToSize:CGSizeMake(6, 14)] drawAtPoint:temperaturePoint];
	if ([wine.servingTemperature temperatureFromValue] != [wine.servingTemperature temperatureToValue]) {
		[[NSString stringWithFormat:@"%0.0f - %0.0f ºC", [wine.servingTemperature temperatureFromValue], [wine.servingTemperature temperatureToValue]] drawAtPoint:CGPointMake(temperaturePoint.x + leftPadding, temperaturePoint.y) withFont:font];
	} else {
		[[NSString stringWithFormat:@"%0.0f ºC", [wine.servingTemperature temperatureFromValue]] drawAtPoint:CGPointMake(temperaturePoint.x + leftPadding, temperaturePoint.y) withFont:font];
	}
	
}

- (void) drawColour:(CGPoint) colourPoint {
	if (wine.colour != nil) {
		UIImage *bottle;
		if ([wine.colour.grapeTypeID isEqual: @"red"]) {
			bottle = [[UIImage imageNamed:@"wine_bottle.png"] imageTintedWithColor:[UIColor cellarWineColourRed]];
		} else if ([wine.colour.grapeTypeID isEqual: @"white"]) {
			bottle = [[UIImage imageNamed:@"wine_bottle.png"] imageTintedWithColor:[UIColor cellarWineColourWhite]];
		} else if ([wine.colour.grapeTypeID isEqual: @"white"]) {
			bottle = [[UIImage imageNamed:@"wine_bottle.png"] imageTintedWithColor:[UIColor cellarWineColourRose]];
		}
		
		[[bottle scaleToSize:CGSizeMake(36, 36)] drawAtPoint:colourPoint];
	}
}

- (void) drawContentView:(CGRect)rect highlighted:(BOOL)highlighted {
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	[self drawWineCellContainer:rect context:context];
	
	[self drawName:CGPointMake(19, 14)];
	
	[self drawVintage:CGPointMake(265, 15)];
	
	[self drawAppellationRegion:CGPointMake(20, 40) localizationPoint:CGPointMake(18, 93)];
	
	[self drawVarietals:CGPointMake(17, 55)];
	
	[self drawTemperature:CGPointMake(21, 74)];
	
	[self drawColour:CGPointMake(266, 33)];
	
	[self drawRating: CGRectMake(0, 90, 518, 0)];
}


@end
