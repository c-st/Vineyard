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

- (void) drawContentView:(CGRect)rect highlighted:(BOOL)highlighted {
	UIFont *font = [UIFont fontWithName:@"Baskerville" size:20];
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	UIColor *backgroundColor = [UIColor cellarBeigeNoisyColour];
	UIColor *textColor = [UIColor blackColor];
	
	// set background color
	[backgroundColor set];
	CGContextFillRect(context, rect);
	
	//CGContextSaveGState(context); //save state
	
	[self drawRoundedRect:rect context:context];
	
	//CGContextRestoreGState(context); // restore state, after clipping
	
	// some text
	
	CGPoint p;
	p.x = 42;
	p.y = 15;
	
	[textColor set];
	CGSize s = [@"hello" drawAtPoint:p withFont:font];
	
	p.x += s.width + 6; // space between words
	[self.wine.name drawAtPoint:p withFont:font];
	
	
	
	
	
	
	
	
}

	//[@"hello" drawInRect:rect withFont:[UIFont fontWithName:@"Baskerville" size:20]];
	



@end
