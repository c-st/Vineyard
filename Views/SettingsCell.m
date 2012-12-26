#import "UIColor+CellarColours.h"

#import "SettingsCell.h"
#import "AddWineViewController.h"

#import "NMRangeSlider.h"

@implementation SettingsCell

@synthesize wine, cellType, propertyIdentifier, name, settingsViewController, textField;

- (id) initWithWine:(Wine*)wineInstance andType:(SettingsCellType)theCellType andProperty:(NSString*)thePropertyIdentifier andName:(NSString*)theName {
	self = [super init];
	
	[self setWine:wineInstance];
	[self setCellType:theCellType];
	[self setPropertyIdentifier:thePropertyIdentifier];
	[self setName:theName];
	//[self setSelectionStyle:UITableViewCellEditingStyleNone];
	
	switch (theCellType) {
		case TextSettingsCellType: {
			[self setSelectionStyle:UITableViewCellEditingStyleNone];
			[self setAccessoryType:UITableViewCellAccessoryNone];
			textField=[[UITextField alloc]initWithFrame:CGRectMake(10, 12, self.frame.size.width - 50 - 10, 30)];
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
			[self setSelectionStyle:UITableViewCellEditingStyleNone];
			[self setAccessoryType:UITableViewCellAccessoryNone];
			UIPickerView *pickerView = [[UIPickerView alloc] init];
			[pickerView setDataSource:self];
			[pickerView setDelegate:self];
			[pickerView setShowsSelectionIndicator:YES];
			
			textField=[[UITextField alloc]initWithFrame:CGRectMake(10, 12, self.frame.size.width - 50 - 10, 30)];
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
		
		case RangeSettingsCellType: {
			[self setSelectionStyle:UITableViewCellEditingStyleNone];
			[self setAccessoryType:UITableViewCellAccessoryNone];
			textField=[[UITextField alloc] initWithFrame:CGRectMake(10, 12, 85, 30)];
			[textField setTextColor: [UIColor lightGrayColor]];
			[textField setPlaceholder:@"8-20º"];
			[textField setUserInteractionEnabled:NO];
			[self.contentView addSubview:textField];
			
			// add range slider
			NMRangeSlider *slider = [[NMRangeSlider alloc] initWithFrame:CGRectMake(95, 8, self.frame.size.width - 145, 30)];
			
			// Woraround: make sure slider is aligned properly.
			[slider setMinimumValue:0];
			[slider setMaximumValue:10];
			[slider setLowerValue:slider.minimumValue upperValue:slider.maximumValue animated:NO];
			
			// set minimum / maximum value based on ranges
			if (self.wine.colour.defaultTemperatureRange != nil) {
				TemperatureRange *range = self.wine.colour.defaultTemperatureRange;
				NSLog(@"found default range. %f %f", range.temperatureFromValue, range.temperatureToValue);
				[slider setMinimumValue:range.temperatureFromValue];
				[slider setMaximumValue:range.temperatureToValue];
			} else {
				[slider setMinimumValue:5];
				[slider setMaximumValue:10];
			}
			
			slider.stepValue = 0.5;
			[slider setStepValueContinuously:YES];
			
			[slider setLowerValue:slider.minimumValue upperValue:slider.maximumValue animated:YES];
			[self updateSliderLabel:slider];
			id currentValue = [wine valueForKey:propertyIdentifier];
			if (currentValue != nil && [currentValue isKindOfClass:[TemperatureRange class]]) {
				TemperatureRange *currentRange = (TemperatureRange *) currentValue;
				NSLog(@"value for range found %f %f", currentRange.temperatureFromValue, currentRange.temperatureToValue);
				[self.textField setText:[NSString stringWithFormat:@"%.1f-%.1fº", currentRange.temperatureFromValue, currentRange.temperatureToValue]];
				[slider setLowerValue:currentRange.temperatureFromValue upperValue:currentRange.temperatureToValue animated:NO];
				[textField setTextColor:[UIColor blackColor]];
			}
			
			[slider addTarget:self action:@selector(updateSliderLabel:) forControlEvents:UIControlEventValueChanged];
			[slider addTarget:self action:@selector(sliderForRangeWasChanged:) forControlEvents:UIControlEventTouchUpInside];
			
			[self.contentView addSubview:slider];
			
			break;
		}
		
		case RatingSettingsCellType: {
			[self setSelectionStyle:UITableViewCellEditingStyleNone];
			[self setAccessoryType:UITableViewCellAccessoryNone];
			SSRatingPicker *ratingPicker = [[SSRatingPicker alloc] initWithFrame:CGRectMake(8, 11, self.frame.size.width - 50 - 10, 40)];
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
	NSLog(@"updated Wine for propertyIdentifier %@ %@", propertyIdentifier, managedObject);
	
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

- (void)textFieldDidBeginEditing:(UITextField *)theTextField {
	[theTextField setTextColor: [UIColor blackColor]];
}

- (void)textFieldDidEndEditing:(UITextField *)theTextField {
	// if text was set, set colour to black.
	if ([theTextField.text length] > 0) {
		[theTextField setTextColor: [UIColor blackColor]];
	} else {
		[theTextField setTextColor: [UIColor lightGrayColor]];
	}
}

-(void) textFieldValueChanged:(UITextField *) theTextField {
	[wine setValue:theTextField.text forKey:propertyIdentifier];
	
	// propagate change to AddWineViewController
	UITableView *tv	= (UITableView *) self.superview;
	AddWineViewController *addWine = (AddWineViewController *) tv.dataSource;
	[addWine updateViewFromValidation];
}

-(void) textFieldValueChangedDisappear:(UITextField *) theTextField {
	[self textFieldValueChanged:textField];
	[theTextField resignFirstResponder];
	[theTextField endEditing:YES];
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
	[wine setValue:[self yearStringForRow:row] forKey:propertyIdentifier];
	[(UITextField *)[[self.contentView subviews] objectAtIndex:0] setText:[self yearStringForRow:row]];
}

#pragma mark
#pragma mark Range slider delegate methods

- (void) updateSliderLabel:(NMRangeSlider *) slider {
	//NSLog(@"--> %.1f %.1f", slider.lowerValue, slider.upperValue);
	double fromValue = slider.lowerValue;
	double toValue = slider.upperValue;
	[self.textField setText:[NSString stringWithFormat:@"%.1f-%.1fº", fromValue, toValue]];
}

- (void) sliderForRangeWasChanged:(NMRangeSlider *) slider {
	[self.textField setTextColor:[UIColor blackColor]];
	[self updateSliderLabel:slider];
	
	double fromValue = slider.lowerValue;
	double toValue = slider.upperValue;
	
	// save value
	if (wine.servingTemperature != nil) {
		[wine.servingTemperature setTemperatureFromValue:fromValue];
		[wine.servingTemperature setTemperatureToValue:toValue];
	} else {
		TemperatureRange *range = [TemperatureRange createEntity];
		[range setTemperatureFromValue:fromValue];
		[range setTemperatureToValue:toValue];
		[wine setServingTemperature:range];
	}
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    //[super setSelected:selected animated:animated];
}

- (void) selected {
	NSLog(@"selected called on settingsCell");
}

@end
