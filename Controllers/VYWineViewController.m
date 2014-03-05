//
//  VYWineViewController.m
//  Vineyard
//
//  Created by Christian Stangier on 23.09.13.
//  Copyright (c) 2013 Christian Stangier. All rights reserved.
//

#import "VYWineViewController.h"

@interface VYWineViewController ()
@property (weak, nonatomic) IBOutlet SwipeView *swipeView;
@property (weak, nonatomic) IBOutlet VYScrollView *scrollView;
@property (weak, nonatomic) IBOutlet EDStarRating *starRatingControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *pageSelectorControl;

@end

@implementation VYWineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	//NSLog(@"self wine: %@", [self wine]);

	[self.scrollView setDelegate:self];
	[self.swipeView setCurrentPage:1];
}

// update view from potential wine edit
- (void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	// set custom navigation item
	[[self navigationItem] setTitle:[[self wine] name]];
	CGRect frame = CGRectMake(0, 0, 0, 44);
	UILabel *label = [[UILabel alloc] initWithFrame:frame];
	[label setTextAlignment:NSTextAlignmentCenter];
	[label setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:22.0f]];
    label.text = self.navigationItem.title;
	[[self navigationItem] setTitleView:label];
	
	// stars
	[self.starRatingControl setBackgroundColor:[UIColor whiteColor]];
	[self.starRatingControl setMaxRating:5];
	[self.starRatingControl setStarImage:[[UIImage imageNamed:@"star-template.png"]
										  imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
	
	[self.starRatingControl setStarHighlightedImage:[[UIImage imageNamed:@"star-highlighted-template"]
													 imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
	
	[self.starRatingControl setDisplayMode:EDStarRatingDisplayFull];
	[self.starRatingControl setHorizontalMargin:15.0];
	[self.starRatingControl setRating:[[self.wine rating] floatValue]];
	
}

- (void) viewWillDisappear:(BOOL)animated {
	[[self scrollView] setDelegate:nil]; // workaround for crash when going back and scrollview is scrolled down
}

#pragma mark
#pragma mark Swipe view delegate

- (NSInteger) numberOfItemsInSwipeView:(SwipeView *)swipeView {
	return 3;
}

- (UIView *) swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
	if (index == 0) {
		UIView *colorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
		[colorView setBackgroundColor:[UIColor lightGrayColor]];
		
		if ([self.wine image] != nil) {
			UIImageView *wineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
			[wineImageView setImage:[UIImage imageWithData:[self.wine image]]];
			[colorView addSubview:wineImageView];
		}
		
		return colorView;
	} else if (index == 1) {
		[self setCenterLocation:CLLocationCoordinate2DMake(self.wine.appellation.region.location.latitudeValue,
														   self.wine.appellation.region.location.longitudeValue)];
		
		return [self mapViewForLocation:[self centerLocation] andZoomLevel:6];
	} else if (index == 2) {
		[self setCenterLocation:CLLocationCoordinate2DMake(self.wine.location.latitudeValue,
														   self.wine.location.longitudeValue)];
		
		return [self mapViewForLocation:[self centerLocation] andZoomLevel:15];
	} else {
		// error
		return nil;
	}
}

- (MKMapView *) mapViewForLocation:(CLLocationCoordinate2D)location andZoomLevel:(NSInteger)level {
	MKMapView *mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	[mapView setScrollEnabled:NO];
	[mapView setZoomEnabled:NO];
	[mapView setRegion:MKCoordinateRegionMakeWithDistance(location, 800, 800)];
	[mapView setCenterCoordinate:location zoomLevel:level animated:YES];
	
	CLLocationCoordinate2D referencePosition = [mapView convertPoint:CGPointMake(0, 0) toCoordinateFromView:mapView];
	CLLocationCoordinate2D referencePosition2 = [mapView convertPoint:CGPointMake(0, 100) toCoordinateFromView:mapView];
	
	self.deltaLatitudeFor1px = (referencePosition2.latitude - referencePosition.latitude) / 100;
	
	return mapView;
}

- (void) swipeViewCurrentItemIndexDidChange:(SwipeView *)theSwipeView {
	[self.pageSelectorControl setSelectedSegmentIndex:theSwipeView.currentPage];
	
}
- (IBAction)pageSelected:(UISegmentedControl *)segmentControl {
	[self.swipeView setCurrentPage:[segmentControl selectedSegmentIndex]];
}


#pragma mark
#pragma mark VYScrollView delegate

-(UIView*) accessoryViewForScrollView:(VYScrollView*)scrollView {
	UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"WineAccessoryView" owner:self options:nil] objectAtIndex:0];
	return view;
}

-(void) footerLoadedInScrollView:(VYScrollView *)scrollView {
	[(UILabel *)[scrollView footerView] setText:@"RELEASE NOW"];
}

-(void) footerUnloadedInScrollView:(VYScrollView *)scrollView {
	[(UILabel *)[scrollView footerView] setText:@"UP UP UP"];
}

#pragma mark
#pragma mark ScrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)theScrollView {
	CGFloat y = theScrollView.contentOffset.y;
    if (y < 0) {
		if ([self.swipeView currentPage] > 0 &&
			[[self.swipeView currentItemView] isKindOfClass:[MKMapView class]]) {
			double deltaLat = y * self.deltaLatitudeFor1px;
			CLLocationCoordinate2D newCenter = CLLocationCoordinate2DMake([self centerLocation].latitude-deltaLat / 2, [self centerLocation].longitude);
			[(MKMapView *)[self.swipeView currentItemView] setCenterCoordinate:newCenter animated:NO];
		}
    }
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

@end
