#import "SettingsCell.h"

@implementation SettingsCell

@synthesize wine, cellType, propertyIdentifier, name;

- (id) initWithWine:(Wine*)wineInstance andType:(SettingsCellType)theCellType andProperty:(NSString*)thePropertyIdentifier andName:(NSString*)theName {
	self = [super init];
	
	[self setWine:wineInstance];
	[self setCellType:theCellType];
	[self setPropertyIdentifier:thePropertyIdentifier];
	[self setName:theName];
	
	switch (theCellType) {
		case TextSettingsCellType: {
			[self setAccessoryType:UITableViewCellAccessoryNone];
			UITextField *textField=[[UITextField alloc]initWithFrame:CGRectMake(10, 10, 320, 39)];
			[textField setTextColor: [UIColor lightGrayColor]];
			[textField setFont:[UIFont systemFontOfSize:16]];
			[textField setAutocorrectionType:UITextAutocapitalizationTypeNone];
			[textField setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
			[textField setAutoresizesSubviews:YES];
			[textField setBorderStyle:UITextBorderStyleNone];
			[textField setPlaceholder:theName];
			[textField addTarget:self action:@selector(textFieldValueChanged:) forControlEvents: UIControlEventEditingDidEnd | UIControlEventEditingDidEndOnExit];
						[self.contentView addSubview:textField];
			[textField setDelegate:self];
			break;
		}
		case DetailViewSettingsCellType: {
			[self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
			self.textLabel.text = name;
			break;
		}
		default:
			break;
	}
	
	// no value yet
	self.textLabel.textColor = [UIColor lightGrayColor];
	self.textLabel.font = [UIFont systemFontOfSize:16];
	
	return self;
}

// don't use it directly.
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
	[textField setTextColor: [UIColor blackColor]];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
	// if text was set, set colour to black.
	if ([textField.text length] > 0) {
		[textField setTextColor: [UIColor blackColor]];
	} else {
		[textField setTextColor: [UIColor lightGrayColor]];
	}
}

-(void) textFieldValueChanged:(UITextField *) textField {
	NSLog(@"textFieldValueChanged: %@", textField.text);
	[self.wine setName:textField.text];
	NSLog(@"attribute set %@", self.wine);
	
	[textField resignFirstResponder];
	[textField endEditing:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    //[super setSelected:selected animated:animated];
}

- (void) selected {
	NSLog(@"selected called on settingsCell");
}

@end
