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
	float radius = 5.0f;
	float padding = 10.0f;
	
	CGRect frame = CGRectMake(padding, padding, self.contentView.bounds.size.width - (2 * padding), self.contentView.bounds.size.height - (2 * padding));
	rect = CGRectInset(frame, 1.0f, 1.0f);

	
	CGContextBeginPath(context);
	CGContextSetGrayFillColor(context, 0.5, 0.7);
	CGContextMoveToPoint(context, CGRectGetMinX(rect) + radius, CGRectGetMinY(rect));
	CGContextAddArc(context, CGRectGetMaxX(rect) - radius, CGRectGetMinY(rect) + radius, radius, 3 * M_PI / 2, 0, 0);
	CGContextAddArc(context, CGRectGetMaxX(rect) - radius, CGRectGetMaxY(rect) - radius, radius, 0, M_PI / 2, 0);
	CGContextAddArc(context, CGRectGetMinX(rect) + radius, CGRectGetMaxY(rect) - radius, radius, M_PI / 2, M_PI, 0);
	CGContextAddArc(context, CGRectGetMinX(rect) + radius, CGRectGetMinY(rect) + radius, radius, M_PI, 3 * M_PI / 2, 0);
	
	CGContextClosePath(context);
	CGContextFillPath(context);
}

- (void) drawContentView:(CGRect)rect highlighted:(BOOL)highlighted {
	UIFont *font = [UIFont fontWithName:@"Baskerville" size:20];
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	
	
	
	UIColor *backgroundColor = [UIColor cellarBeigeNoisyColour];
	UIColor *textColor = [UIColor blackColor];
	
	// set background color
	[backgroundColor set];
	CGContextFillRect(context, rect);
	
	CGPoint p;
	p.x = 42;
	p.y = 15;
	
	[textColor set];
	CGSize s = [@"hello" drawAtPoint:p withFont:font];
	
	p.x += s.width + 6; // space between words
	[self.wine.name drawAtPoint:p withFont:font];
	
	
	
	[self drawRoundedRect:rect context:context];
	
	
	
	
}

	//[@"hello" drawInRect:rect withFont:[UIFont fontWithName:@"Baskerville" size:20]];
	



@end
