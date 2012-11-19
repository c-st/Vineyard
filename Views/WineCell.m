#import "WineCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation WineCell

@synthesize wine, cellBackgroundView;

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andWine:(Wine *)theWine {
	self = [super initWithFrame:CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height)];
	if (self) {
		[self setWine:theWine];
		
		[self.contentView setBackgroundColor:[UIColor clearColor]];
		
		[self setCellBackgroundView:[self buildWineView]];
		[self.contentView addSubview:[self cellBackgroundView]];
		
		[self setBackgroundView:nil];
		[self setSelectionStyle:UITableViewCellSelectionStyleNone];
		
	}
	return self;
}

- (UIView*) buildWineView {
	UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(10, 19,
														  self.contentView.bounds.size.width - 21,
														  120)];
	// shadow etc.
	[bg setBackgroundColor:[UIColor whiteColor]];
	bg.layer.shadowColor = [UIColor blackColor].CGColor;
	
	//
	
	UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 20)];
	[nameLabel setBackgroundColor:[UIColor clearColor]];
	[nameLabel setShadowColor:[UIColor lightGrayColor]];
    [nameLabel setShadowOffset:CGSizeMake(0,1)];
    [nameLabel setFont:[UIFont boldSystemFontOfSize:16]];
	
	[nameLabel setTextColor:[UIColor darkGrayColor]];
	[nameLabel setText:[wine name]];
	[bg addSubview:nameLabel];
	
	return bg;
}


- (void) layoutSubviews {
	//[super layoutSubviews];
	
	self.cellBackgroundView.layer.shadowOpacity = 0.9f;
	self.cellBackgroundView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
	self.cellBackgroundView.layer.shadowRadius = 2.0f;
	self.cellBackgroundView.layer.masksToBounds = NO;
	//[self.cellBackgroundView.layer setShouldRasterize:YES];
	self.cellBackgroundView.layer.opaque = YES;
	self.cellBackgroundView.layer.cornerRadius = 4.0;
	
	[self.cellBackgroundView.layer setShadowPath:[[UIBezierPath bezierPathWithRoundedRect:self.cellBackgroundView.bounds cornerRadius:4.0f] CGPath]];
	// add shadow
}

- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
	//[self.textLabel setText:[self.wine name]];

}

@end
