#import "CellarTableViewCell.h"

#import "UIColor+CellarColours.h"

@implementation CellarTableViewCell

@synthesize showArrow;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setShowArrow:NO];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(void) drawRect:(CGRect)rect {
	if ([self showArrow]) {
		CGFloat x = CGRectGetMaxX(self.bounds)-13;
		CGFloat y = CGRectGetMidY(self.bounds)-0.5;
		const CGFloat R = 4.5;
		CGContextRef ctxt = UIGraphicsGetCurrentContext();
		CGContextMoveToPoint(ctxt, x-R, y-R);
		CGContextAddLineToPoint(ctxt, x, y);
		CGContextAddLineToPoint(ctxt, x-R, y+R);
		CGContextSetLineCap(ctxt, kCGLineCapSquare);
		CGContextSetLineJoin(ctxt, kCGLineJoinMiter);
		CGContextSetLineWidth(ctxt, 3);
	
		[[UIColor colorWithRed:(48.0f/255.0f) green:(48.0f/255.0f) blue:(48.0f/255.0f) alpha:0.5f] setStroke];
		CGContextStrokePath(ctxt);
	}
	
	[super drawRect:rect];
}

@end
