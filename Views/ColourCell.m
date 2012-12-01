#import "ColourCell.h"

@implementation ColourCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andColour:(UIColor *)theColour {
	self = [super initWithFrame:CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height)];
	if (self) {
		//[self setWine:theWine];
		
		[self.contentView setBackgroundColor:[UIColor clearColor]];
		
		//[self setCellBackgroundView:[self buildWineView]];
		//[self.contentView addSubview:[self cellBackgroundView]];
		
		//[self buildAndSaveToolbarView];
		//[self.contentView addSubview:[self toolbarView]];
		
		[self setBackgroundView:nil];
		[self setSelectionStyle:UITableViewCellSelectionStyleNone];
	}
	return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
