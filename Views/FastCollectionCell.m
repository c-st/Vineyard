#import "FastCollectionCell.h"

#import "UIImage+Scale.h"
#import "UIImage+Tint.h"

@implementation FastCollectionCell

@synthesize collection, parentTableViewController;

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andCollection:(Collection *)theCollection {
	self = [super initWithFrame:CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height)];
	if (self) {
		[self setCollection:theCollection];
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

- (void) drawContentView:(CGRect)rect highlighted:(BOOL)highlighted {
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	[self drawWineCellContainer:rect context:context];
	
	//[self drawName:CGPointMake(19, 14)];
	
	//[self drawVintage:CGPointMake(265, 15)];
	
	//[self drawAppellationRegion:CGPointMake(20, 40) localizationPoint:CGPointMake(18, 93)];
	
	//[self drawVarietals:CGPointMake(17, 55)];
	
	//[self drawTemperature:CGPointMake(21, 74)];
	
	//[self drawColour:CGPointMake(266, 33)];
	
	//[self drawRating: CGRectMake(0, 90, 518, 0)];
}


@end
