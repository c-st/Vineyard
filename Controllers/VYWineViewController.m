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
@property (weak, nonatomic) IBOutlet SwipeView *swipeView;

@property (weak, nonatomic) IBOutlet UISegmentedControl *pageSelectorControl;

@end

@implementation VYWineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	//NSLog(@"self wine: %@", [self wine]);

	[self.scrollView setDelegate:self];
	[self.swipeView setCurrentPage:1];
	
	
//	self.center = CLLocationCoordinate2DMake(self.wine.appellation.region.location.latitudeValue, self.wine.appellation.region.location.longitudeValue);
//	self.center = CLLocationCoordinate2DMake(self.wine.location.latitudeValue, self.wine.location.longitudeValue);
	NSLog(@"%f %f", self.wine.location.latitudeValue, self.wine.location.longitudeValue);
	

	//NSLog(@"%i", self.deltaLatitudeFor1px);
}

- (void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[[self navigationItem] setTitle:[[self wine] name]];
	CGRect frame = CGRectMake(0, 0, 0, 44);
	UILabel *label = [[UILabel alloc] initWithFrame:frame];
	//[label setBackgroundColor:[UIColor blueColor]];
	[label setTextAlignment:NSTextAlignmentCenter];
	[label setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:25.0f]];
    label.text = self.navigationItem.title;
	[[self navigationItem] setTitleView:label];
	
}

#pragma mark
#pragma mark Swipe view delegate

- (NSInteger) numberOfItemsInSwipeView:(SwipeView *)swipeView {
	return 3;
}

- (UIView *) swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
	
	if (index == 0) {
		UIView *colorView = [[UIView alloc] initWithFrame:CGRectMake(0, -300, 320, 480)];
		[colorView setBackgroundColor:[UIColor lightGrayColor]];
		return colorView;
	} else if (index == 1) {
		[self setCenterLocation:CLLocationCoordinate2DMake(self.wine.appellation.region.location.latitudeValue,
														   self.wine.appellation.region.location.longitudeValue)];
		
		return [self mapViewForLocation:[self centerLocation] andZoomLevel:5];
	} else if (index == 2) {
		[self setCenterLocation:CLLocationCoordinate2DMake(self.wine.location.latitudeValue,
														   self.wine.location.longitudeValue)];
		
		return [self mapViewForLocation:[self centerLocation] andZoomLevel:9];
	} else {
		// error
		return nil;
	}
}

- (MKMapView *) mapViewForLocation:(CLLocationCoordinate2D)location andZoomLevel:(NSInteger)level {
	MKMapView *mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, -300, 320, 480)];

	[mapView setScrollEnabled:NO];
	[mapView setZoomEnabled:NO];
	[mapView setRegion:MKCoordinateRegionMakeWithDistance(location, 1000, 1000)];
	[mapView setCenterCoordinate:location zoomLevel:level animated:YES];
	
	CLLocationCoordinate2D referencePosition = [mapView convertPoint:CGPointMake(0, 0) toCoordinateFromView:mapView];
    CLLocationCoordinate2D referencePosition2 = [mapView convertPoint:CGPointMake(0, 100) toCoordinateFromView:mapView];
	
	self.deltaLatitudeFor1px = (referencePosition2.latitude - referencePosition.latitude) / 100;
	
	return mapView  ;
}


- (void) swipeViewCurrentItemIndexDidChange:(SwipeView *)theSwipeView {
	[self.pageSelectorControl setSelectedSegmentIndex:theSwipeView.currentPage];
	
}
- (IBAction)pageSelected:(UISegmentedControl *)segmentControl {
	[self.swipeView setCurrentPage:[segmentControl selectedSegmentIndex]];
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
		if ([self.swipeView currentPage] > 0) {
			double deltaLat = y * self.deltaLatitudeFor1px;
			CLLocationCoordinate2D newCenter = CLLocationCoordinate2DMake([self centerLocation].latitude-deltaLat / 2, [self centerLocation].longitude);
			[(MKMapView *)[self.swipeView currentItemView] setCenterCoordinate:newCenter animated:NO];
		}
    }
}

@end
