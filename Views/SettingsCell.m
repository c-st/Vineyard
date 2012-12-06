#import "SettingsCell.h"

#import "Country.h"
#import "GrapeType.h"
#import "AddWineViewController.h"

#import "UIColor+CellarColours.h"

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
			UITextField *textField=[[UITextField alloc]initWithFrame:CGRectMake(10, 12, self.frame.size.width - 50 - 10, 30)];
			[textField setTextColor: [UIColor lightGrayColor]];
			[textField setFont:[UIFont systemFontOfSize:16]];
			[textField setAutocorrectionType: UITextAutocorrectionTypeNo];
			[textField setAutocapitalizationType:UITextAutocapitalizationTypeWords];
			[textField setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
			[textField setAutoresizesSubviews:YES];
			[textField setBorderStyle:UITextBorderStyleNone];
			[textField setPlaceholder:theName];
			[textField addTarget:self action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
			[textField addTarget:self action:@selector(textFieldValueChangedDisappear:) forControlEvents: UIControlEventEditingDidEnd | UIControlEventEditingDidEndOnExit];
			[self.contentView addSubview:textField];
			[textField setDelegate:self];
			
			// check if we have an initial value
			id currentValue = [wine valueForKey:propertyIdentifier];
			if (currentValue != nil && [currentValue isKindOfClass:[NSString class]]) {
				NSLog(@"setting value is %@", currentValue);
				[textField setText:currentValue];
				[textField setTextColor:[UIColor blackColor]];
			}
			
			break;
		}
			
		case YearSettingsCellType: {
			[self setAccessoryType:UITableViewCellAccessoryNone];
			UIPickerView *pickerView = [[UIPickerView alloc] init];
			[pickerView setDataSource:self];
			[pickerView setDelegate:self];
			[pickerView setShowsSelectionIndicator:YES];
			
			UITextField *textField=[[UITextField alloc]initWithFrame:CGRectMake(10, 12, self.frame.size.width - 50 - 10, 30)];
			[textField setTextColor: [UIColor lightGrayColor]];
			
			UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
			[toolBar setBarStyle:UIBarStyleBlackTranslucent];
			[toolBar sizeToFit];
			UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
			UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneClicked:)];
			[doneBtn setTintColor:[UIColor blackColor]];
			[toolBar setItems:[NSArray arrayWithObjects:flexSpace, doneBtn, nil]];
			
			[textField setInputAccessoryView:toolBar];
			[textField setInputView:pickerView];
			[textField setPlaceholder:theName];
			[textField setDelegate:self];
			
			[self.contentView addSubview:textField];
			
			// check for current value
			id currentValue = [wine valueForKey:propertyIdentifier];
			if (currentValue != nil && [currentValue isKindOfClass:[NSString class]]) {
				NSInteger *currentRow = [self rowForYearString:currentValue];
				NSLog(@"setting value is %@, row is %ld", currentValue, (long)currentRow);
			
				[pickerView selectRow:currentRow inComponent:0 animated:YES];
				
				[textField setText:currentValue];
				[textField setTextColor:[UIColor blackColor]];
			}
			break;
		}
			
		case RatingSettingsCellType: {
			[self setAccessoryType:UITableViewCellAccessoryNone];
			SSRatingPicker *ratingPicker = [[SSRatingPicker alloc] initWithFrame:CGRectMake(8, 0, self.frame.size.width - 50 - 10, 40)];
			[ratingPicker setBackgroundColor:[UIColor clearColor]];
			[ratingPicker setTotalNumberOfStars:6];
			[ratingPicker.textLabel setText:@""];
			[ratingPicker addTarget:self action:@selector(ratingPickerValueChanged:) forControlEvents:UIControlEventValueChanged];
			[self.contentView addSubview:ratingPicker];
			
			// check if we have an initial value
			id currentValue = [wine valueForKey:propertyIdentifier];
			if (currentValue != nil && [currentValue isKindOfClass:[NSNumber class]]) {
				[ratingPicker setSelectedNumberOfStars:[wine.rating floatValue]];
				NSLog(@"setting value is %@", currentValue);
			}
			
			break;
		}
			
		case DetailViewSettingsCellType: {
			[self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
			self.textLabel.text = name;
			
			// check if we have an initial value
			id currentValue = [wine valueForKey:propertyIdentifier];
			if (currentValue != nil && [currentValue isKindOfClass:[NSManagedObject class]]) { // NSManagedObject
				//NSLog(@"setting is managed object: %@", propertyIdentifier);
				[self.textLabel setText:[currentValue valueForKey:@"name"]];
				self.textLabel.textColor = [UIColor blackColor];
				self.textLabel.font = [UIFont systemFontOfSize:16];
			} else if (currentValue != nil && ([currentValue isKindOfClass:[NSSet class]])) { // NSSet
				NSLog(@"setting is list value: %@", propertyIdentifier);
				if ([(NSSet*) currentValue count] > 0) { // with values
					NSSet *values = (NSSet *) currentValue;
					NSString *names = [[NSString alloc] init];
					for (NSManagedObject *object in values) {
						names = [names stringByAppendingString:[[object valueForKey:@"name"] stringByAppendingString:@" "]];
					}
					[self.textLabel setText:names];
					self.textLabel.textColor = [UIColor blackColor];
					self.textLabel.font = [UIFont systemFontOfSize:16];
				} else { // no values yet
					self.textLabel.textColor = [UIColor lightGrayColor];
					self.textLabel.font = [UIFont systemFontOfSize:16];
				}
			} else if (currentValue != nil) { // NSObject
				NSLog(@"setting is object value %@", propertyIdentifier);
				self.textLabel.textColor = [UIColor blackColor];
				self.textLabel.font = [UIFont systemFontOfSize:16];
				[self.textLabel setText:[NSString stringWithFormat:@"%@", currentValue]];
			} else {
				// no value yet
				self.textLabel.textColor = [UIColor lightGrayColor];
				self.textLabel.font = [UIFont systemFontOfSize:16];
			}
			break;
		}
		default:
			break;
	}
	
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
	// reset appellation if country was changed.
	if ([propertyIdentifier isEqualToString:@"country"]) {
		//only if the value was actually changed
		if (![wine.country isEqual:managedObject]) {
			[wine setValue:nil forKey:@"appellation"];
		}
	}
	
	// reset varietals if colour was changed
	if ([propertyIdentifier isEqualToString:@"colour"]) {
		//only if the value was actually changed
		if (![wine.colour isEqual:managedObject]) {
			[wine setValue:nil forKey:@"varietals"];
		}
	}
	
	[wine setValue:managedObject forKey:propertyIdentifier];
	NSLog(@"updated Wine for propertyIdentifier %@", propertyIdentifier);
	
	[self.textLabel setText:[managedObject valueForKey:@"name"]];
	[self.textLabel setTextColor: [UIColor blackColor]];
}

- (void) listValueWasSelected:(NSSet*)list {
	[wine setValue:list forKey:propertyIdentifier];
	NSLog(@"updated Wine for propertyIdentifier %@ with list value", propertyIdentifier);
	
	[self.textLabel setText:@"some values..."];
	[self.textLabel setTextColor: [UIColor blackColor]];
}

- (void) objectValueWasSelected:(id)object {
	[wine setValue:object forKey:propertyIdentifier];
	NSLog(@"updated Wine for propertyIdentifier %@ with object value %@", propertyIdentifier, object);
	[self.textLabel setText:[NSString stringWithFormat:@"%@", object]];
	[self.textLabel setTextColor: [UIColor blackColor]];
}


#pragma mark
#pragma mark Text field delegate methods

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
	[wine setValue:textField.text forKey:propertyIdentifier];
	
	// propagate change to AddWineViewController
	UITableView *tv	= (UITableView *) self.superview;
	AddWineViewController *addWine = (AddWineViewController *) tv.dataSource;
	[addWine updateViewFromValidation];
}

-(void) textFieldValueChangedDisappear:(UITextField *) textField {
	[self textFieldValueChanged:textField];
	[textField resignFirstResponder];
	[textField endEditing:YES];
}


#pragma mark
#pragma mark Rating picker delegate methods

-(void) ratingPickerValueChanged:(SSRatingPicker *) ratingPicker {
	[wine setValue:[NSNumber numberWithFloat:ratingPicker.selectedNumberOfStars] forKey:propertyIdentifier];
}


#pragma mark
#pragma mark Year PickerView delegate methods

// generate year as string from row
- (NSString *) yearStringForRow:(NSInteger) row {
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy"];
	NSDate *date = [[NSDate date] dateByAddingTimeInterval:-365*24*60*60*(row)];
	NSString *yearString = [formatter stringFromDate:date];
	return yearString;
}

// determine row from string
- (NSInteger *) rowForYearString:(NSString*) year {
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy"];
	NSDate *date = [formatter dateFromString:year];
	NSDateComponents *components = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:date];
	int *determinedYear = [components year];
	components = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:[NSDate date]];
	int *currentYear = [components year];
	return (long)currentYear-(long)determinedYear;
}

- (void) doneClicked:(UITextField *) textField {
	// hide picker
	[(UITextField *)[[self.contentView subviews] objectAtIndex:0] resignFirstResponder];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return 30;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	return [self yearStringForRow:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	NSLog(@"did select");
	[wine setValue:[self yearStringForRow:row] forKey:propertyIdentifier];
	[(UITextField *)[[self.contentView subviews] objectAtIndex:0] setText:[self yearStringForRow:row]];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    //[super setSelected:selected animated:animated];
}

- (void) selected {
	NSLog(@"selected called on settingsCell");
}

@end
