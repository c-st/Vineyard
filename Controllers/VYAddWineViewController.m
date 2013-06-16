//
//  VYAddWineViewController.m
//  Vineyard
//
//  Created by Christian Stangier on 13.06.13.
//  Copyright (c) 2013 Christian Stangier. All rights reserved.
//

#import "VYAddWineViewController.h"

@interface VYAddWineViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) Wine *wine;

@property (nonatomic, strong) CLLocationManager *locationManager;
@end

@implementation VYAddWineViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		// TODO: is not called from storyboard. viewDidLoad ok?
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	// new wine
	NSLog(@"new");
	[self setWine:[Wine createEntity]];
	[_wine setCreationTime:[NSDate date]];
}

- (IBAction)nameEditingChanged:(id)sender {
	[_doneButton setEnabled:[[_nameTextField text] length] > 0];
	[_wine setName:[_nameTextField text]];
}

- (IBAction)cancelButtonTapped:(id)sender {
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doneButtonTapped:(id)sender {
	if (![_wine isValid]) {
		NSLog(@"Wine is not valid!");
		return;
	}
	
	NSLog(@"saving entry... %@", _wine);
	[_wine extendWine];
		
	[[NSManagedObjectContext defaultContext] saveToPersistentStoreAndWait];
	[self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    NSLog(@"Location %f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
	
	// if a new wine is created, set location.
	//if ([self newWine]) {
	
	Location *loc = [Location createEntity];
	[loc setLatitudeValue:newLocation.coordinate.latitude];
	[loc setLongitudeValue:newLocation.coordinate.longitude];
	[self.wine setLocation:loc];
	
	[manager stopUpdatingLocation];
}

@end
