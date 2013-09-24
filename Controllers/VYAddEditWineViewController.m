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
		[self setWine:[Wine createEntity]];
		[_wine setCreationTime:[NSDate date]];
		[self requestLocationUpdate];
		[[self navigationItem] setTitle:@"New wine"];
	} else {
		[[self navigationItem] setTitle:@"Edit wine"];
		[self.nameTextField setText:[self.wine name]];
		[self nameEditingChanged:nil];
		// set title etc.
	}
}

#pragma mark
#pragma mark GUI Events

- (IBAction)nameEditingChanged:(id)sender {
	[_doneButton setEnabled:[[_nameTextField text] length] > 0];
	[_wine setName:[_nameTextField text]];
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
	if (![_wine isValid]) {
		NSLog(@"Wine is not valid!");
		return;
	}
	[_wine extendWine];
	[[NSManagedObjectContext defaultContext] saveToPersistentStoreAndWait];
	[self dismissViewControllerAnimated:YES completion:nil];
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
