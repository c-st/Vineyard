#import "FastWineCell.h"
#import "UIImage+Scale.h"

@implementation FastWineCell

@synthesize wine, parentTableViewController;

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andWine:(Wine *)theWine {
	self = [super initWithFrame:CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height)];
	if (self) {
		[self setWine:theWine];
		
		/*
		[self setCellBackgroundView:[self buildWineView]];
		
		[self.contentView addSubview:[self cellBackgroundView]];
		
		[self buildAndSaveToolbarView];
		[self.contentView addSubview:[self toolbarView]];
		
		[self setBackgroundView:nil];
		[self setSelectionStyle:UITableViewCellSelectionStyleNone];
		 */
	}
	return self;
}

- (void) drawRoundedRect:(CGRect)rect context:(CGContextRef) context {
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
	CGRect lineBounds = CGRectMake(18, 43, 300, 0);
	
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
	if (wine.vintage == nil) {
		return;
	}
	
	UIFont *font = [UIFont fontWithName:@"Baskerville" size:18];
	UIColor *textColor = [UIColor darkGrayColor];
	[textColor set];
	[self.wine.vintage drawAtPoint:point withFont:font];
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
		[[[UIImage imageNamed:@"globe.png"] scaleToSize:CGSizeMake(16, 16)] drawAtPoint:localizationPoint];
		
		
		// localization text
		float leftPadding = 20;
		if (wine.appellation != nil) {
			[[NSString stringWithFormat:@"%@, %@", wine.appellation.region.name, wine.appellation.region.country.name] drawAtPoint:CGPointMake(localizationPoint.x + leftPadding, localizationPoint.y) withFont:font];
			 
		} else if (wine.appellation == nil && wine.country != nil) {
			[[NSString stringWithFormat:@"%@", wine.country.name] drawAtPoint:CGPointMake(localizationPoint.x + leftPadding, localizationPoint.y) withFont:font];
		}
	}
}

- (void) drawContentView:(CGRect)rect highlighted:(BOOL)highlighted {
	
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	UIColor *backgroundColor = [UIColor cellarBeigeNoisyColour];
	
	
	// set background color
	[backgroundColor set];
	CGContextFillRect(context, rect);
	
	//CGContextSaveGState(context); //save state
	
	[self drawRoundedRect:rect context:context];
	
	//CGContextRestoreGState(context); // restore state, after clipping


	
	[self drawName:CGPointMake(19, 17)];
	
	[self drawVintage:CGPointMake(265, 19)];
	
	[self drawAppellationRegion:CGPointMake(20, 50) localizationPoint:CGPointMake(20, 110)];
	
	[self drawRating: CGRectMake(0, 112, 518, 0)];
	
}


@end
