//
//  VYWineViewController.m
//  Vineyard
//
//  Created by Christian Stangier on 23.09.13.
//  Copyright (c) 2013 Christian Stangier. All rights reserved.
//

#import "VYWineViewController.h"

@interface VYWineViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation VYWineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	//NSLog(@"self wine: %@", [self wine]);
	[[self navigationItem] setTitle:[[self wine] name]];
	
	[self.scrollView setDelegate:self];
	
	self.center = CLLocationCoordinate2DMake(self.wine.appellation.region.location.latitudeValue, self.wine.appellation.region.location.longitudeValue);
//	self.center = CLLocationCoordinate2DMake(self.wine.location.latitudeValue, self.wine.location.longitudeValue);
	NSLog(@"%f %f", self.wine.location.latitudeValue, self.wine.location.longitudeValue);
	
	self.mapView.region = MKCoordinateRegionMakeWithDistance(self.center, 1000, 1000);
	[self.mapView setCenterCoordinate:self.center zoomLevel:5 animated:YES];
	
	CLLocationCoordinate2D referencePosition = [self.mapView convertPoint:CGPointMake(0, 0) toCoordinateFromView:self.mapView];
    CLLocationCoordinate2D referencePosition2 = [self.mapView convertPoint:CGPointMake(0, 100) toCoordinateFromView:self.mapView];
	self.deltaLatitudeFor1px = (referencePosition2.latitude - referencePosition.latitude) / 100;
	//NSLog(@"%i", self.deltaLatitudeFor1px);
}

#pragma mark
#pragma mark View Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([self wine] != nil) {
		NSLog(@"VYWineTableViewContoller -> prepareForSeque. Pushing wine");
		//NSLog(@"%@", NSStringFromClass([[segue destinationViewController] class]));
		
		// pass data through
		if ([[[[segue destinationViewController] viewControllers] objectAtIndex:0]
			 isKindOfClass:[VYAddEditWineViewController class]]) {
			
			VYAddEditWineViewController *editWineViewController =
				[[[segue destinationViewController] viewControllers] objectAtIndex:0];
			
			NSLog(@"target is AddWineViewController. setting wine");
			[editWineViewController setWineForEditing:[self wine]];
		}
	}
}

#pragma mark
#pragma mark Scrolling
- (void)scrollViewDidScroll:(UIScrollView *)theScrollView {
	CGFloat y = theScrollView.contentOffset.y;
    // did we drag ?
    if (y < 0) {
		double deltaLat = y* self.deltaLatitudeFor1px;
		CLLocationCoordinate2D newCenter = CLLocationCoordinate2DMake(self.center.latitude-deltaLat / 2, self.center.longitude);
		//[self.mapView setCenterCoordinate:newCenter zoomLevel:8 animated:NO];
		[self.mapView setCenterCoordinate:newCenter animated:NO];
    }
}

@end
