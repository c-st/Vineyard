
#import "ModalTextFieldView.h"

@implementation ModalTextFieldView

@synthesize textField;

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
		[titleLabel setText:@"Add Collection"];
		[self addSubview:titleLabel];
		
		// right button
		self.saveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[saveButton setFrame:CGRectMake(self.frame.size.width - 70, 10, 60, 30)];
		[saveButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
		[saveButton setTintColor:[UIColor lightGrayColor]];
		[saveButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
		saveButton.layer.borderColor = [UIColor blackColor].CGColor;
		[saveButton setTitle:@"Add" forState:UIControlStateNormal];
		[saveButton addTarget:self.delegate action:@selector(triggerSaveButton) forControlEvents:UIControlEventTouchUpInside];
		[saveButton setEnabled:NO];
		[self addSubview:saveButton];
		
		// Name
		UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 70, 70, 20)];
		[nameLabel setBackgroundColor:[UIColor clearColor]];
		[nameLabel setText:@"Name:"];
		[self addSubview:nameLabel];
		
		// text field
		self.textField = [[UITextField alloc] initWithFrame:CGRectMake(80, 70, 220, 20)];
		[textField setBackgroundColor:[UIColor redColor]];
		[textField setFont:[UIFont systemFontOfSize:16]];
		[textField setBackgroundColor:[UIColor clearColor]];
		[textField becomeFirstResponder];
		[textField addTarget:self action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
		[self addSubview:textField];
		
		SSLineView *line2 = [[SSLineView alloc] initWithFrame:CGRectMake(20, 95, 280, 2)];
		[line2 setLineColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.6]];
		[line2 setInsetColor:[UIColor clearColor]];
		[self addSubview:line2];
		
    }
    return self;
}

- (void) triggerCancelButton {
	[delegate cancelButtonPressed:self.textField];
}

- (void) triggerSaveButton {
	[self.textField setText:[[self.textField text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
	[delegate saveButtonPressed:self.textField];
}

- (void) textFieldValueChanged:(UITextField *) theTextField {
	if ([[theTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] > 0) {
		[self.saveButton setEnabled:YES];
	} else {
		[self.saveButton setEnabled:NO];
	}
}

@end
