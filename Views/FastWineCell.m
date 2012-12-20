#import "FastWineCell.h"

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
    CGContextSetShadowWithColor(context, CGSizeMake(0.0, 0.0), shadowRadius, [UIColor blackColor].CGColor);
	[roundedPath fill];
	

	[roundedPath addClip];
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:1.0 alpha:0.6].CGColor);
    CGContextSetBlendMode(context, kCGBlendModeOverlay);
	
    CGContextMoveToPoint(context, CGRectGetMinX(contentRect), CGRectGetMinY(contentRect)+0.5);
    CGContextAddLineToPoint(context, CGRectGetMaxX(contentRect), CGRectGetMinY(contentRect)+0.5);
    CGContextStrokePath(context);
	
	
	CGContextRestoreGState(context); // restore state
	
	// add stroke
	CGContextSaveGState(context);
	CGContextAddPath(context, roundedPath.CGPath);
	CGContextClip(context);
	
	CGContextRestoreGState(context);
	CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:0.0 alpha:0.3].CGColor);
	CGContextAddPath(context, roundedPath.CGPath);
	CGContextDrawPath(context, kCGPathStroke);
}

- (void) drawRating:(CGRect)rect {
	if (self.wine.rating == nil) {
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

- (void) drawContentView:(CGRect)rect highlighted:(BOOL)highlighted {
	
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	UIColor *backgroundColor = [UIColor cellarBeigeNoisyColour];
	
	
	// set background color
	[backgroundColor set];
	CGContextFillRect(context, rect);
	
	//CGContextSaveGState(context); //save state
	
	[self drawRoundedRect:rect context:context];
	
	//CGContextRestoreGState(context); // restore state, after clipping

	[self drawName:CGPointMake(20, 15)];
	
	[self drawRating: CGRectMake(0, 112, 518, 0)];
	
	
	
	
}


@end
