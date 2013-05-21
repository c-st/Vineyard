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
	
}

- (void) drawBox:(CGPoint) point {
	[[[[UIImage imageNamed:@"openbox.png"] scaleToSize:CGSizeMake(35, 35)] imageTintedWithColor:[[UIColor cellarWineRedColour] colorWithAlphaComponent:0.75f]] drawAtPoint:point];
}

- (void) drawName:(CGPoint) point {
	UIFont *font = [UIFont fontWithName:@"Baskerville" size:21];
	UIColor *textColor = [UIColor blackColor];
	[textColor set];
	
	NSString *title = self.collection.name;
	if (title.length > 15) {
		title = [[title substringToIndex:15] stringByAppendingString:@"..."];
	}
	[title drawAtPoint:point withFont:font];
}

- (void) drawCount:(CGPoint) point {
	UIFont *font = [UIFont fontWithName:@"Baskerville" size:21];
	UIColor *textColor = [UIColor lightGrayColor];
	[textColor set];
	
	NSString *title;
	int count = [collection.wines count];
	if (count > 1 || count == 0) {
		title = [NSString stringWithFormat:@" %i wines", [collection.wines count]];
	} else if (count > 99) {
		title = [NSString stringWithFormat:@" %i", [collection.wines count]];
	} else {
		title = [NSString stringWithFormat:@" %i wine", [collection.wines count]];
	}
	
	
	//[self.collection.name drawAtPoint:point withFont:font];
	[title drawAtPoint:point withFont:font];
}

- (void) drawContentView:(CGRect)rect highlighted:(BOOL)highlighted {
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	[self drawWineCellContainer:rect context:context];
	
	[self drawBox:CGPointMake(20, 17)];
	
	[self drawName:CGPointMake(67, 24)];
	
	[self drawCount:CGPointMake(220, 24)];
	
}


@end
