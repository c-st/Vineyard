
#import "ModalCollectionView.h"

@implementation ModalCollectionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor cellarBeigeNoisyColour]];
		
		SSLineView *line = [[SSLineView alloc] initWithFrame:CGRectMake(0, 45, self.frame.size.width, 2)];
		[line setLineColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.8]];
		[line setInsetColor:[UIColor whiteColor]];
		[self addSubview:line];
		
		// left button
		UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[cancelButton setFrame:CGRectMake(10, 10, 60, 30)];
		[cancelButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
		[cancelButton setTintColor:[UIColor lightGrayColor]];
		[cancelButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
		cancelButton.layer.borderColor = [UIColor blackColor].CGColor;
		[cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
		[cancelButton addTarget:self.delegate action:@selector(triggerCancelButton) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:cancelButton];
		
		// title
		UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 15, 160, 20)];
		[titleLabel setTextAlignment:NSTextAlignmentCenter];
		[titleLabel setBackgroundColor:[UIColor clearColor]];
		[titleLabel setTextColor:[UIColor darkGrayColor]];
		[titleLabel setFont:[UIFont systemFontOfSize:17]];
		[titleLabel setText:@"Add To Collection"];
		[self addSubview:titleLabel];
		
		// right button
		self.saveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[saveButton setFrame:CGRectMake(self.frame.size.width - 70, 10, 60, 30)];
		[saveButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
		[saveButton setTintColor:[UIColor lightGrayColor]];
		[saveButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
		saveButton.layer.borderColor = [UIColor blackColor].CGColor;
		[saveButton setTitle:@"Done" forState:UIControlStateNormal];
		[saveButton addTarget:self.delegate action:@selector(triggerSaveButton) forControlEvents:UIControlEventTouchUpInside];
		[saveButton setEnabled:NO];
		[self addSubview:saveButton];

		// table view
    }
    return self;
}

- (void) triggerCancelButton {
	[delegate cancelButtonPressed:nil];
}

- (void) triggerSaveButton {
	[delegate saveButtonPressed:nil];
}

@end
