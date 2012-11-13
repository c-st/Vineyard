#import "SettingsCell.h"
#import "Country.h"

@implementation SettingsCell

@synthesize wine, cellType, propertyIdentifier, name, settingsViewController;

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

- (id) initWithWine:(Wine*)wineInstance andType:(SettingsCellType)theCellType andProperty:(NSString*)thePropertyIdentifier andName:(NSString*)theName andViewController:(AbstractTableViewController*)theViewController {
	
	if (theCellType == DetailViewSettingsCellType) {
		[self setSettingsViewController:theViewController];
	} else {
		NSLog(@"wrong cellType is used.");
	}
	
	return [self initWithWine:wineInstance andType:theCellType andProperty:thePropertyIdentifier andName:theName];
}

- (void) updatePredicateAndRefetch {
	[self.settingsViewController.fetchedResultsController.fetchRequest setPredicate:[self.settingsViewController getFetchPredicate:wine]];
	
	NSError *error;
	[self.settingsViewController.fetchedResultsController performFetch:&error];
}


// don't use it directly.
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) valueWasSelected:(NSManagedObject*)managedObject {
	[wine setValue:managedObject forKey:propertyIdentifier];
	NSLog(@"updated Wine %@", managedObject);
	[self.textLabel setText:[managedObject valueForKey:@"name"]];
	[self.textLabel setTextColor: [UIColor blackColor]];
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
	[wine setValue:textField.text forKey:propertyIdentifier];
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
