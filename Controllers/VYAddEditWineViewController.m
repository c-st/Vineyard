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
    //[super viewDidLoad];
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
}

- (void) viewWillAppear:(BOOL)animated {
	[self.nameTextField setText:[self.wine name]];
	[self.countryTextField setText:[[self.wine country] name]];
	[self.appellationTextField setText:[[self.wine appellation] name]];
	[self.colourTextField setText:[[self.wine colour] name]];
	[self.varietalTextField setText:[self.wine varietalsString]];
	
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
	[[NSManagedObjectContext defaultContext] saveToPersistentStoreAndWait];
	[self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark
#pragma mark Table View Data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	// if country is set, display appellations as well.
	if (section == 0) {
		if ([self.wine country] != nil) {
			return 3;
		} else {
			return 2;
		}
	}
	
	// if colour is set, display varietals as well
	if (section == 1) {
		if ([self.wine colour] != nil) {
			return 3;
		} else {
			return 2;
		}
	}
	
	return [super tableView:tableView numberOfRowsInSection:section];
}

#pragma mark
#pragma mark View Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	NSLog(@"prepareForSegue %@ -> %@", self, [segue destinationViewController]);
	if ([[segue destinationViewController] isKindOfClass:[VYCountryTableViewController class]]) {
		VYCountryTableViewController *countryTableViewController = [segue destinationViewController];
		[countryTableViewController setInPickerMode:YES];
		[countryTableViewController setFetchedResultsController:[Country fetchAllSortedBy:@"name" ascending:YES withPredicate:nil groupBy:nil delegate:countryTableViewController]];
		
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
	if ([[sender sourceViewController] isKindOfClass:[VYCountryTableViewController class]]) {
	}
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
