#import "UIColor+CellarColours.h"

#import "SettingsCell.h"
#import "AddWineViewController.h"

#import "UIImage+Tint.h"

#import "NMRangeSlider.h"

@implementation SettingsCell

@synthesize wine, cellType, propertyIdentifier, name, settingsTableViewController, viewController, textField;

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
			
		case NumberSettingsCellType: {
			[self setSelectionStyle:UITableViewCellEditingStyleNone];
			[self setAccessoryType:UITableViewCellAccessoryNone];
			textField=[[UITextField alloc]initWithFrame:CGRectMake(10, 12, self.frame.size.width - 50 - 10, 30)];
			[textField setTextColor: [UIColor lightGrayColor]];
			[textField setFont:[UIFont systemFontOfSize:16]];

			[textField setKeyboardType:UIKeyboardTypeDecimalPad];
			[textField setPlaceholder:theName];
			
			UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
			[toolBar setBarStyle:UIBarStyleBlackTranslucent];
			[toolBar sizeToFit];
			UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
			UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneClicked:)];
			[doneBtn setTintColor:[UIColor blackColor]];
			[toolBar setItems:@[flexSpace, doneBtn]];
			[textField setInputAccessoryView:toolBar];
			
			[textField addTarget:self action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
			[textField addTarget:self action:@selector(textFieldValueChangedDisappear:) forControlEvents: UIControlEventEditingDidEnd | UIControlEventEditingDidEndOnExit];
			[self.contentView addSubview:textField];
			[textField setDelegate:self];
			
			id currentValue = [wine valueForKey:propertyIdentifier];
			if (currentValue != nil && [currentValue floatValue] > 0) {
				NSLog(@"setting value is %@", currentValue);
				[textField setText:[NSString stringWithFormat:@"%.2f %@", [currentValue floatValue], [self getCurrencySymbol]]];
				//[self textFieldValueChanged:textField];
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
			[toolBar setItems:@[flexSpace, doneBtn]];
			
			[textField setInputAccessoryView:toolBar];
			[textField setInputView:pickerView];
			[textField setPlaceholder:theName];
			[textField setDelegate:self];
			
			[self.contentView addSubview:textField];
			
			// check for current value
			
			NSNumber *currentValue = [wine valueForKey:propertyIdentifier];
			if (currentValue != nil && [currentValue intValue] > 0) {
				NSInteger *currentRow = [self rowForYear:currentValue];
				NSLog(@"setting value is %@, row is %ld", currentValue, (long)currentRow);
				[pickerView selectRow:currentRow inComponent:0 animated:YES];
				[textField setText:[NSString stringWithFormat:@"%@", currentValue]];
				[textField setTextColor:[UIColor blackColor]];
			}
			break;
		}
			
		case AlcoholSettingsCellType: {
			[self setSelectionStyle:UITableViewCellEditingStyleNone];
			[self setAccessoryType:UITableViewCellAccessoryNone];
			
			textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 12, 85, 30)];
			[textField setTextColor: [UIColor lightGrayColor]];
			[textField setPlaceholder:@"Alc. Vol.%"];
			[textField setUserInteractionEnabled:NO];
			[self.contentView addSubview:textField];
			
			UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(95, 8, self.frame.size.width - 145, 30)];
			// is needed for unique Look with range slider
			UIImage *image = [[UIImage imageNamed:@"slider-default-track"] imageTintedWithColor:[UIColor redColor] fraction:0.5];
			image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 7.0, 0.0, 7.0)];
			[slider setMinimumTrackImage:image forState:UIControlStateNormal];
			[slider setMinimumValue:9.0f];
			[slider setMaximumValue:25.0f];
			[slider setValue:slider.minimumValue animated:NO];
			[slider addTarget:self action:@selector(sliderValueWasChanged:) forControlEvents:UIControlEventValueChanged];
			
			[self.contentView addSubview:slider];
			
			// check for current value
			id currentValue = [wine valueForKey:propertyIdentifier];
			if (currentValue != nil && [currentValue floatValue] > 0) {
				NSLog(@"current value %f", [currentValue floatValue]);
				[textField setText:[NSString stringWithFormat:@"%.1f %%", [currentValue floatValue]]];
				[textField setTextColor:[UIColor blackColor]];
				[slider setValue:[currentValue floatValue] animated:NO];
			}
			break;
		}
		
		case RangeSettingsCellType: {
			[self setSelectionStyle:UITableViewCellEditingStyleNone];
			[self setAccessoryType:UITableViewCellAccessoryNone];
			textField=[[UITextField alloc] initWithFrame:CGRectMake(10, 12, 85, 30)];
			[textField setPlaceholder:@"Temp."];
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
				[slider setMaximumValue:20];
			}
			
			slider.stepValue = 0.5;
			[slider setStepValueContinuously:NO];
			
			[slider setLowerValue:slider.minimumValue upperValue:slider.maximumValue animated:YES];
			[self updateRangeSliderLabel:slider];
			[textField setTextColor:[UIColor lightGrayColor]];
			id currentValue = [wine valueForKey:propertyIdentifier];
			if (currentValue != nil && [currentValue isKindOfClass:[TemperatureRange class]]) {
				TemperatureRange *currentRange = (TemperatureRange *) currentValue;
				NSLog(@"value for range found %f %f", currentRange.temperatureFromValue, currentRange.temperatureToValue);
				[self.textField setText:[NSString stringWithFormat:@"%.1f-%.1fº", currentRange.temperatureFromValue, currentRange.temperatureToValue]];
				[slider setLowerValue:currentRange.temperatureFromValue upperValue:currentRange.temperatureToValue animated:NO];
				[textField setTextColor:[UIColor blackColor]];
			}
			[slider addTarget:self action:@selector(updateRangeSliderLabel:) forControlEvents:UIControlEventValueChanged];
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
				if ([propertyIdentifier isEqualToString:@"characteristics"]) {
					[self.textLabel setText:@"Characteristics"];
				} else {
					[self.textLabel setText:[currentValue valueForKey:@"name"]];
				}
				self.textLabel.textColor = [UIColor blackColor];
				self.textLabel.font = [UIFont systemFontOfSize:16];
			} else if (currentValue != nil && ([currentValue isKindOfClass:[NSSet class]])) { // NSSet
				// NSLog(@"setting is list value: %@", propertyIdentifier);
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
		
		case DeleteWineCellType: {
			[self setSelectionStyle:UITableViewCellSelectionStyleGray];
			[self setAccessoryType:UITableViewCellAccessoryNone];
			[self.textLabel setText:@"Delete"];
			[self.textLabel setTextColor:[UIColor whiteColor]];
			[self.textLabel setTextAlignment:NSTextAlignmentCenter];
			[self.textLabel setBackgroundColor:[UIColor clearColor]];
			
			[self setBackgroundView:[[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"delete-button.png"] stretchableImageWithLeftCapWidth:8.0f topCapHeight:0.0f]]];
			
			break;
		}
			
		default:
			break;
	}
	
	return self;
}

// DetailView settings cell: display table view
- (id) initWithWine:(Wine*)wineInstance andType:(SettingsCellType)theCellType andProperty:(NSString*)thePropertyIdentifier andName:(NSString*)theName andTableViewController:(AbstractTableViewController*)theViewController {
	
	if (theCellType == DetailViewSettingsCellType) {
		[self setSettingsTableViewController:theViewController];
	} else {
		NSLog(@"wrong cellType is used.");
	}
	
	return [self initWithWine:wineInstance andType:theCellType andProperty:thePropertyIdentifier andName:theName];
}

// DetailView settings cell: display normal view
- (id) initWithWine:(Wine*)wineInstance andType:(SettingsCellType)theCellType andProperty:(NSString*)thePropertyIdentifier andName:(NSString*)theName andViewController:(AbstractTableViewController*)theViewController {
	
	if (theCellType == DetailViewSettingsCellType) {
		[self setViewController:theViewController];
	} else {
		NSLog(@"wrong cellType is used.");
	}
	
	return [self initWithWine:wineInstance andType:theCellType andProperty:thePropertyIdentifier andName:theName];
}

- (void) updatePredicateAndRefetch {
	if (self.settingsTableViewController != nil) {
		[self.settingsTableViewController.fetchedResultsController.fetchRequest setPredicate:[self.settingsTableViewController getFetchPredicate:wine]];
	}
}

// don't use it directly.
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark
#pragma mark Methods to trigger value changes

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
	//NSLog(@"updated Wine for propertyIdentifier %@ %@", propertyIdentifier, managedObject);
	
	if ([propertyIdentifier isEqualToString:@"characteristics"]) {
		[self.textLabel setText:@"S: A: T: F: B:"];
	} else {
		[self.textLabel setText:[managedObject valueForKey:@"name"]];
	}
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

- (BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (theTextField.keyboardType == UIKeyboardTypeDecimalPad) {
        NSString *newString = [theTextField.text stringByReplacingCharactersInRange:range withString:string];
        NSString *expression = @"^([0-9]+)?([\\.,\\,]([0-9]{1,2})?)?$";
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression options:NSRegularExpressionCaseInsensitive error:nil];
        NSUInteger numberOfMatches = [regex numberOfMatchesInString:newString options:0 range:NSMakeRange(0, [newString length])];
        if (numberOfMatches == 0) {
				return NO;
		}
	}
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)theTextField {
	[theTextField setTextColor: [UIColor blackColor]];
	
	// remove currency symbol
	[theTextField setText:[theTextField.text stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@" %@",[self getCurrencySymbol]] withString:@""]];
	
	// scroll to current cell
	// determine position of current cell, scroll there with scrollview.
	// send scroll event here - which is caught at AddWineViewController
	[[NSNotificationCenter defaultCenter] postNotificationName:@"scrollToUITableViewCell" object:self];
}

- (void)textFieldDidEndEditing:(UITextField *)theTextField {
	// if text was set, set colour to black.
	if ([theTextField.text length] > 0) {
		[theTextField setTextColor: [UIColor blackColor]];
	} else {
		[theTextField setTextColor: [UIColor lightGrayColor]];
	}
	
	if ([propertyIdentifier isEqualToString:@"price"]) {
		// append currency symbol
		if ([theTextField.text length] > 0) {
			[theTextField setText:[NSString stringWithFormat:@"%@ %@", theTextField.text, [self getCurrencySymbol]]];
		}
	}
}

-(void) textFieldValueChanged:(UITextField *) theTextField {
	if ([propertyIdentifier isEqualToString:@"name"]) {
		[wine setValue:theTextField.text forKey:propertyIdentifier];
	
		// propagate change to AddWineViewController
		UITableView *tv	= (UITableView *) self.superview;
		AddWineViewController *addWine = (AddWineViewController *) tv.dataSource;
		[addWine updateViewFromValidation];
	} else if ([propertyIdentifier isEqualToString:@"price"]) {
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
		[wine setValue:[formatter numberFromString:theTextField.text] forKey:propertyIdentifier];
	}
}

-(void) textFieldValueChangedDisappear:(UITextField *) theTextField {
	[self textFieldValueChanged:textField];
	[theTextField resignFirstResponder];
	[theTextField endEditing:YES];
}


#pragma mark
#pragma mark Rating picker delegate methods

-(void) ratingPickerValueChanged:(SSRatingPicker *) ratingPicker {
	[wine setValue:@(ratingPicker.selectedNumberOfStars) forKey:propertyIdentifier];
}


#pragma mark
#pragma mark Year PickerView delegate methods

// generate year as string from row
- (NSNumber *) yearForRow:(NSInteger) row {
	// current year - row
	NSDateComponents *components = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:[NSDate date]];
	return [NSNumber numberWithInteger:[components year] - row];
}

// determine row from string
- (NSInteger *) rowForYear:(NSNumber*) year {
	NSDateComponents *components = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:[NSDate date]];
	return [components year] - [year integerValue];
}

- (void) doneClicked:(UITextField *) textField {
	// hide picker
	[(UITextField *)[self.contentView subviews][0] resignFirstResponder];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	if ([propertyIdentifier isEqualToString:@"vintage"]) {
		return 1;
	}
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	if ([propertyIdentifier isEqualToString:@"vintage"]) {
		return 50;
	} 
	return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	if ([propertyIdentifier isEqualToString:@"vintage"]) {
		return [NSString stringWithFormat:@"%i", [[self yearForRow:row] integerValue]];
	}
	return @"Not defined";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	if ([propertyIdentifier isEqualToString:@"vintage"]) {
		[wine setValue:[self yearForRow:row] forKey:propertyIdentifier];
		[(UITextField *)[self.contentView subviews][0] setText:[NSString stringWithFormat:@"%i", [[self yearForRow:row] integerValue]]];
	}
}

#pragma mark
#pragma mark Range slider delegate methods

- (void) updateRangeSliderLabel:(NMRangeSlider *) slider {
	//NSLog(@"--> %.1f %.1f", slider.lowerValue, slider.upperValue);
	[self.textField setTextColor:[UIColor blackColor]];
	double fromValue = slider.lowerValue;
	double toValue = slider.upperValue;
	[self.textField setText:[NSString stringWithFormat:@"%.1f-%.1fº", fromValue, toValue]];
}

- (void) sliderForRangeWasChanged:(NMRangeSlider *) slider {
	
	[self updateRangeSliderLabel:slider];
	
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

#pragma mark
#pragma mark Slider delegate methods

- (void) updateSliderLabel:(UISlider *) slider {
	[self.textField setTextColor:[UIColor blackColor]];
	double value = slider.value;
	[self.textField setText:[NSString stringWithFormat:@"%.1f %%", value]];
}


- (void) sliderValueWasChanged:(UISlider *) slider {
	float newStep = roundf((slider.value) / 0.5f);
    slider.value = newStep * 0.5f;
	
	//NSLog(@"%.1f", slider.value);
	[self updateSliderLabel:slider];
	
	// save value
	[wine setAlcoholContentValue:slider.value];
}

- (NSString *) getCurrencySymbol {
	NSLocale *theLocale = [NSLocale currentLocale];
	return [theLocale objectForKey:NSLocaleCurrencySymbol];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    //[super setSelected:selected animated:animated];
}

- (void) selected {
	NSLog(@"selected called on settingsCell");
}

@end
