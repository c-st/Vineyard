//
//  VYAddWineViewController.m
//  Vineyard
//
//  Created by Christian Stangier on 13.06.13.
//  Copyright (c) 2013 Christian Stangier. All rights reserved.
//

#import "VYAddEditWineViewController.h"

@interface VYAddEditWineViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *countryTextField;
@property (weak, nonatomic) IBOutlet UITextField *appellationTextField;
@property (weak, nonatomic) IBOutlet UITextField *colourTextField;
@property (weak, nonatomic) IBOutlet UITextField *varietalTextField;
@property (weak, nonatomic) IBOutlet EDStarRating *wineStarRating;
@property (weak, nonatomic) IBOutlet VYRoundedImageView *wineImageView;
@property (weak, nonatomic) IBOutlet UIPickerView *vintagePickerView;
@property (weak, nonatomic) IBOutlet UITextField *vintageTextField;
@property (weak, nonatomic) IBOutlet UITextView *notesTextView;

@property (weak, nonatomic) IBOutlet UISlider *alcoholSlider;
@property (weak, nonatomic) IBOutlet NMRangeSlider *temperatureRangeSlider;
@property (weak, nonatomic) IBOutlet UITextField *alcoholValueTextField;
@property (weak, nonatomic) IBOutlet UITextField *temperatureRangeTextField;



@property (nonatomic, strong) CLLocationManager *locationManager;
@end

@implementation VYAddEditWineViewController

#pragma mark
#pragma mark Initialization

- (id) initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
    if (self) {
        [self setNewWine:YES];
    }
    return self;
}

- (void) setWineForEditing:(Wine *)theWine {
	[self setWine:theWine];
	[self setNewWine:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	if ([self newWine]) {
		[[self navigationItem] setTitle:@"New wine"];
		[self setWine:[Wine createEntity]];
		[self.wine setCreationTime:[NSDate date]];
		[self requestLocationUpdate];
	} else {
		[[self navigationItem] setTitle:@"Edit wine"];
		[self.nameTextField setText:[self.wine name]];
		[self nameEditingChanged:nil];
	}
	
	UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
	gestureRecognizer.cancelsTouchesInView = NO;
	[self.tableView addGestureRecognizer:gestureRecognizer];
}

- (void) hideKeyboard {
    [self.nameTextField resignFirstResponder];
    [self.notesTextView resignFirstResponder];
}

- (void) viewWillAppear:(BOOL)animated {
	[self.nameTextField setText:[self.wine name]];
	[self.countryTextField setText:[[self.wine country] name]];
	[self.appellationTextField setText:[[self.wine appellation] name]];
	[self.colourTextField setText:[[self.wine colour] name]];
	[self.varietalTextField setText:[self.wine varietalsString]];
	[self.notesTextView setText:[self.wine notes]];
	[self.wineImageView setImage:[UIImage imageWithData:[self.wine image]]];
    
    // alcohol slider
    if ([self.wine alcoholContent] != nil) {
        [self.alcoholSlider setValue:[self.wine alcoholContentValue]];
        [self alcoholValueChanged:self.alcoholSlider];
    }

    // temperature range
    NSLog(@"%@", self.wine.servingTemperature);
    if ([self.wine servingTemperature] != nil) {
        [self.temperatureRangeSlider setLowerValue:[self.wine.servingTemperature temperatureFromValue]];
        [self.temperatureRangeSlider setUpperValue:[self.wine.servingTemperature temperatureToValue]];
        [self temperatureRangeValueChanged:self.temperatureRangeSlider];
    }
    
	// vintage picker
	if ([self.wine vintage] != nil) {
		NSInteger *vintageRow = [self getCurrentYear] - [self.wine vintageValue];
		[self.vintagePickerView selectRow:vintageRow inComponent:0 animated:NO];
		[self.vintageTextField setText:[NSString stringWithFormat:@"%i", [self.wine vintageValue]]];
	}
	
	[self.wineStarRating setRating:[self.wine ratingValue]];
	[self.wineStarRating setDelegate:self];
	
	[self.tableView reloadData];
	[super viewWillAppear:animated];
}

- (void) viewWillDisappear:(BOOL)animated {
	[self.nameTextField resignFirstResponder];
}


#pragma mark
#pragma mark GUI Events

- (IBAction)nameEditingChanged:(UITextField *)sender {
	[self.doneButton setEnabled:[[_nameTextField text] length] > 0];
	[self.wine setName:[_nameTextField text]];
}

- (IBAction)nameEditingFinished:(UITextField *)sender {
	[sender resignFirstResponder];
}

- (IBAction)cancelButtonTapped:(id)sender {
	if ([self newWine]) {
	[[self wine] deleteEntity];
	} else {
		[[NSManagedObjectContext defaultContext] rollback];
	}
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doneButtonTapped:(id)sender {
	NSLog(@"saving");
	if (![self.wine isValid]) {
		NSLog(@"Wine is not valid!");
		return;
	}
	[self.wine extendWine];
    
    // save wine
    [[NSManagedObjectContext defaultContext] saveToPersistentStoreWithCompletion:
     ^(BOOL success, NSError *error) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

#pragma mark
#pragma mark ED Star rating delegate

-(void)starsSelectionChanged:(EDStarRating *)control rating:(float)rating {
	[self.wine setRating:[NSNumber numberWithFloat:[self.wineStarRating rating]]];
}

#pragma mark
#pragma mark Picker view delegate & Data source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return 120;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	return [NSString stringWithFormat:@"%zd", [self getCurrentYear] - row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	[self.wine setVintage:[NSNumber numberWithInteger:[self getCurrentYear] - row]];
	[self.vintageTextField setText:[NSString stringWithFormat:@"%i", [self.wine vintageValue]]];
}

- (NSInteger) getCurrentYear {
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *components = [gregorian components:NSYearCalendarUnit fromDate:[NSDate date]];
	return [components year];
}

#pragma mark
#pragma mark Text view delegate

- (void)textViewDidEndEditing:(UITextView *)textView {
	[self.wine setNotes:[textView text]];
}


#pragma mark
#pragma mark Slider event handling

- (IBAction)alcoholValueChanged:(UISlider *)slider {
    [slider setValue:roundf(slider.value * 2.0)/2 animated:NO];
    
    [self.alcoholValueTextField setText:[NSString stringWithFormat:@"%.1f vol.", [slider value]]];
    [self.wine setAlcoholContentValue:[slider value]];
}


- (IBAction)temperatureRangeValueChanged:(NMRangeSlider *)slider {
    [slider setLowerValue:roundf(slider.lowerValue * 2.0)/2 animated:NO];
    [slider setUpperValue:roundf(slider.upperValue * 2.0)/2 animated:NO];
    
    [self.temperatureRangeTextField setText:[NSString stringWithFormat:@"%.1f%@ - %.1f%@",
                                             [slider lowerValue],
                                             @"\u00B0",
                                             [slider upperValue],
                                             @"\u00B0"]];
    
    if (self.wine.servingTemperature == nil) {
        TemperatureRange *range = [TemperatureRange createEntity];
		[self.wine setServingTemperature:range];
    }
    [self.wine.servingTemperature setTemperatureFromValue:[slider lowerValue]];
    [self.wine.servingTemperature setTemperatureToValue:[slider upperValue]];
}



#pragma mark
#pragma mark Table View Data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	// if country is set, display appellations as well.
	if (section == 1) {
		if ([self.wine country] != nil) {
			return 3;
		} else {
			return 2;
		}
	}
	
	// vintage
	if (section == 2) {
		if (_vintageRowVisible) {
			return 2;
		} else {
			return 1;
		}
	}
	
	// if colour is set, display varietals as well
	if (section == 3) {
		if ([self.wine colour] != nil) {
			return 2;
		} else {
			return 1;
		}
	}
	
	return [super tableView:tableView numberOfRowsInSection:section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSIndexPath* vintageYearRow = [NSIndexPath indexPathForRow:1 inSection:2];
	
	if (indexPath.section == 2 && indexPath.row == 0) {
		_vintageRowVisible = !_vintageRowVisible;
		
		//[tableView reloadData];
		[tableView beginUpdates];
		
		if (_vintageRowVisible) {
			[tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:vintageYearRow] withRowAnimation:UITableViewRowAnimationAutomatic];
		} else {
			[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:vintageYearRow] withRowAnimation:UITableViewRowAnimationMiddle];
		}
		
		[UIView animateWithDuration:0.3 animations:^{
			[tableView endUpdates];
		} completion:^(BOOL finished) {
			if (_vintageRowVisible) {
				[tableView scrollToRowAtIndexPath:vintageYearRow atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
			}
		}];
	}

}


#pragma mark
#pragma mark View Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	NSLog(@"prepareForSegue %@ -> %@", self, [segue destinationViewController]);
	if ([[segue destinationViewController] isKindOfClass:[VYCountryTableViewController class]]) {
		VYCountryTableViewController *countryTableViewController = [segue destinationViewController];
		[countryTableViewController setInPickerMode:YES];
		[countryTableViewController setFetchedResultsController:
		 [Country fetchAllSortedBy:@"name" ascending:YES withPredicate:nil groupBy:nil delegate:countryTableViewController]];
		
	} else if ([[segue destinationViewController] isKindOfClass:[VYAppellationTableViewController class]]) {
		VYAppellationTableViewController *appellationsTableViewController = [segue destinationViewController];
		[appellationsTableViewController setInPickerMode:YES];
		
		NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"(region.country.countryID == %@) || (%@ = null)", self.wine.country.countryID, self.wine.country.countryID];
		
		[appellationsTableViewController setFetchedResultsController:[Appellation fetchAllSortedBy:@"region.name,name" ascending:YES withPredicate:searchPredicate groupBy:@"region" delegate:appellationsTableViewController]];
		
	} else if ([[segue destinationViewController] isKindOfClass:[VYVarietalsTableViewController class]]) {
		VYVarietalsTableViewController *varietalsTableViewController = [segue destinationViewController];
		[varietalsTableViewController setSelectedVarietals:[[self.wine.varietals allObjects] mutableCopy]];
		[varietalsTableViewController setInPickerMode:YES];
		
		if (self.wine.colour != nil) { 	// display full list, if no colour is set
		NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"(grapeType.grapeTypeID == %@)", self.wine.colour.grapeTypeID];
		
		[varietalsTableViewController setFetchedResultsController:[Varietal fetchAllGroupedBy:@"grapeType"
																				withPredicate:searchPredicate sortedBy:@"grapeType,name" ascending:YES]];
		}
	}
}

-(BOOL)canPerformUnwindSegueAction:(SEL)action fromViewController:(UIViewController *)fromViewController withSender:(id)sender {
	return YES;
}

- (IBAction)unwindFromPickerView:(UIStoryboardSegue*)sender {

}

#pragma mark
#pragma mark Location

- (void) requestLocationUpdate {
	self.locationManager = [[CLLocationManager alloc] init];
	_locationManager.delegate = self;
	_locationManager.distanceFilter = kCLDistanceFilterNone;
	_locationManager.desiredAccuracy = kCLLocationAccuracyBest;
	[_locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *) manager didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation {
	
    NSLog(@"Location %f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
	
	Location *loc = [Location createEntity];
	[loc setLatitudeValue:newLocation.coordinate.latitude];
	[loc setLongitudeValue:newLocation.coordinate.longitude];
	
	// if a new wine is created, set location.
	if ([self newWine]) {
		[self.wine setLocation:loc];
	}
	
	[manager stopUpdatingLocation];
}

@end
