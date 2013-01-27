
#import "WineDetailViewController.h"
#import "AddWineViewController.h"
#import "ModalCollectionView.h"

#import "MKMapView+ZoomLevel.h"
#import "UIColor+CellarColours.h"
#import "SSToolkit.h"

#import "UIViewController+KNSemiModal.h"

@interface WineDetailViewController ()

@end

@implementation WineDetailViewController

@synthesize wine, swipeView, pageControl, pageLabel;
@synthesize locationMapView, addedMapView;

- (id) initWithWine:(Wine *)theWine {
	if ((self = [super init])) {
		[self setWine:theWine];
	}
    return self;
}

#pragma mark
#pragma mark View

- (void) viewWillAppear:(BOOL)animated {
	if ([self.wine.name length] == 0) {
		[[self navigationController] popViewControllerAnimated:NO];
	} else {
		[self loadView];
	}
}

- (CellarMapView*) buildLocationView:(CLLocationCoordinate2D)coordinate andZoomLevel:(int)zoomLevel {
	CGRect bound = [[UIScreen mainScreen] bounds];
	CellarMapView *mapView = [[CellarMapView alloc] initWithFrame:CGRectMake(0, -150, bound.size.width, 400) andLocation:coordinate andZoomLevel:zoomLevel];
	
	//NSLog(@"using coordinate %f %f", coordinate.latitude, coordinate.longitude);
	
	[mapView setScrollEnabled:NO];
	[mapView setZoomEnabled:NO];
	
	CLLocationCoordinate2D referencePosition = [mapView convertPoint:CGPointMake(0, 0) toCoordinateFromView:mapView];
    CLLocationCoordinate2D referencePosition2 = [mapView convertPoint:CGPointMake(0, 100) toCoordinateFromView:mapView];
	
    mapView.deltaLatitude = (referencePosition2.latitude - referencePosition.latitude) / 100;
	
	mapView.mapType = MKMapTypeStandard;
	
	return mapView;
}

- (UIView *) buildSwipeView {
	self.swipeView = [[SwipeView alloc] initWithFrame:CGRectMake(0, -150, self.view.frame.size.width, 400)];
	swipeView.alignment = SwipeViewAlignmentCenter;
    swipeView.pagingEnabled = YES;
    swipeView.wrapEnabled = NO;
    swipeView.itemsPerPage = 1;
    swipeView.truncateFinalPage = YES;
	
	swipeView.delaysContentTouches = YES;
	
	swipeView.dataSource = self;
	swipeView.delegate = self;
	
	self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 230, self.view.frame.size.width, 20)];
	pageControl.numberOfPages = 2;
	pageControl.currentPage = 0;
	pageControl.currentPageIndicatorTintColor = [[UIColor cellarWineRedColour] colorWithAlphaComponent:0.6];
	pageControl.pageIndicatorTintColor = [[UIColor cellarWineRedColour] colorWithAlphaComponent:0.3];
	[pageControl addTarget:self action:@selector(pageControlTapped:) forControlEvents:UIControlEventValueChanged];
	[swipeView addSubview:pageControl];
	
	self.pageLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 230, 200, 20)];
	UIFont *font = [UIFont systemFontOfSize:12];
	[pageLabel setFont:font];
	[pageLabel setBackgroundColor:[UIColor clearColor]];
	[self.pageLabel setTextColor:[UIColor darkGrayColor]];
	[pageLabel setText:@"Wine region"];
	[swipeView addSubview:pageLabel];
	
	return swipeView;
}

- (void) addContainerViews:(UIView *) view {
	CGRect bound = [[UIScreen mainScreen] bounds];
	
	// White area
	UILabel *whiteArea = [[UILabel alloc] initWithFrame:CGRectMake(bound.origin.x, 100, bound.size.width, 270)];
	[whiteArea setBackgroundColor:[UIColor cellarGrayColour]];
	[view addSubview:whiteArea];
	
	// Line view
	SSLineView *line2 = [[SSLineView alloc] initWithFrame:CGRectMake(0, 190, bound.size.width, 20)];
	[line2 setLineColor:[UIColor whiteColor]];
	[line2 setInsetColor:[UIColor lightGrayColor]];
	[view addSubview:line2];
	
	// Shadow
	CAGradientLayer *shadow = [CAGradientLayer layer];
	shadow.frame = CGRectMake(0, 190, bound.size.width, 6);
	shadow.startPoint = CGPointMake(1.0, 0.5);
	shadow.endPoint = CGPointMake(1.0, 1.0);
	shadow.colors = @[(id)[[UIColor colorWithWhite:0.0 alpha:0.15] CGColor], (id)[[UIColor clearColor] CGColor]];
	[view.layer addSublayer:shadow];
	
	// Shadow 2
	CAGradientLayer *shadow2 = [CAGradientLayer layer];
	shadow2.frame = CGRectMake(0, 370, bound.size.width, 4);
	shadow2.startPoint = CGPointMake(1.0, 0.5);
	shadow2.endPoint = CGPointMake(1.0, 1.0);
	shadow2.colors = @[(id)[[UIColor colorWithWhite:0.0 alpha:0.2] CGColor], (id)[[UIColor clearColor] CGColor]];
	[view.layer addSublayer:shadow2];
	
	// Line view
	SSLineView *line = [[SSLineView alloc] initWithFrame:CGRectMake(0, 100, bound.size.width, 20)];
	[line setLineColor:[UIColor lightGrayColor]];
	[line setInsetColor:[UIColor whiteColor]];
	[view addSubview:line];
}

- (void) addHeaderArea:(UIView *) view {
	// Name
	UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 110, 270, 30)];
	[nameLabel setBackgroundColor:[UIColor clearColor]];
    [nameLabel setFont:[UIFont fontWithName:@"Baskerville" size:24]];
	[nameLabel setTextColor:[UIColor blackColor]];
	[nameLabel setText:[wine name]];
	[view addSubview:nameLabel];
	
	// Vintage
	UILabel *vintageLabel = [[UILabel alloc] initWithFrame:CGRectMake(270, 108, 50, 25)];
	[vintageLabel setBackgroundColor:[UIColor clearColor]];
	[vintageLabel setTextColor:[UIColor darkGrayColor]];
	[vintageLabel setFont:[UIFont fontWithName:@"Baskerville" size:20]];
	[vintageLabel setText:[wine vintage]];
	[view addSubview:vintageLabel];
	
	// Rating
	SSRatingPicker *ratingPicker = [[SSRatingPicker alloc] initWithFrame:CGRectMake(8, 150, 300, 40)];
	[ratingPicker setBackgroundColor:[UIColor clearColor]];
	[ratingPicker setUserInteractionEnabled:NO];
	[ratingPicker setTotalNumberOfStars:6];
	[ratingPicker.textLabel setText:@""];
	if ([wine.rating isKindOfClass:[NSNumber class]]) {
		[ratingPicker setSelectedNumberOfStars:[wine.rating floatValue]];
	}
	[view addSubview:ratingPicker];
}


- (void) loadView {
	[super loadView];
	
	UIBarButtonItem *editButton =
	[[UIBarButtonItem alloc] initWithTitle: @"Edit" style:UIBarButtonItemStylePlain target:self action: @selector(editWine)];
	[[self navigationItem] setRightBarButtonItem:editButton];
	
	// Scroll view
	CGRect bound = [[UIScreen mainScreen] bounds];
	
	UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(bound.origin.x,
																			  bound.origin.y,
																			  bound.size.width,
																			  self.view.frame.size.height)];
	
	[scrollView setContentSize: CGSizeMake(self.view.frame.size.width, self.view.frame.size.height )];
	[scrollView setContentOffset: CGPointMake(0, 0)];
	[scrollView setContentInset:UIEdgeInsetsMake(1.0,0,0,0.0)];
	[scrollView setBackgroundColor:[UIColor cellarBeigeNoisyColour]];
	[scrollView setShowsVerticalScrollIndicator:NO];
	[scrollView setScrollEnabled:YES];
	[scrollView setUserInteractionEnabled:YES];
	[scrollView setDelegate:self];
	
	
	// init map views
	self.locationMapView = [self buildLocationView:CLLocationCoordinate2DMake(wine.appellation.region.location.latitudeValue,
																			  wine.appellation.region.location.longitudeValue) andZoomLevel:5];
	
	self.addedMapView = [self buildLocationView:CLLocationCoordinate2DMake(wine.location.latitudeValue,
																		   wine.location.longitudeValue) andZoomLevel:11];
	MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
	point.coordinate = self.addedMapView.location;
	[self.addedMapView addAnnotation:point];
	
	[scrollView addSubview:[self buildSwipeView]];
	
	[self addContainerViews:scrollView];

	[self addHeaderArea:scrollView];
	
	UIButton *addToCollectionButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[addToCollectionButton setFrame:CGRectMake(50, 200, 150, 40)];
	[addToCollectionButton setTitle:@"Add to collection" forState:UIControlStateNormal];
	[addToCollectionButton addTarget:self action:@selector(addToCollectionButtonPressed) forControlEvents:UIControlEventTouchUpInside];
	[scrollView addSubview:addToCollectionButton];
	
	[self.view addSubview:scrollView];
}

#pragma mark
#pragma mark Swipe view delegate methods

- (NSInteger) numberOfItemsInSwipeView:(SwipeView *)swipeView {
	return 2;
}

- (UIView *) swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
	if (index == 0) {
		return [self locationMapView];
	} else if (index == 1) {
		return [self addedMapView];
	}
	
	NSLog(@"no view for index %i", index);
	return nil;
}

- (void) swipeViewCurrentItemIndexDidChange:(SwipeView *)theSwipeView {
	if (theSwipeView.currentPage == 0) {
		[pageLabel setText:@"Wine region"];
	} else if (theSwipeView.currentPage == 1) {
		[pageLabel setText:@"Wine added"];
	}
	self.pageControl.currentPage = theSwipeView.currentPage;
}

- (void) pageControlTapped:(UIPageControl*) sender {
	[swipeView scrollToPage:pageControl.currentPage duration:0.4];
}

#pragma mark
#pragma mark Map & Location

- (void) scrollViewDidScroll:(UIScrollView *)theScrollView {
	// determine active mapView
	CellarMapView *mapView = nil;
	if (self.swipeView.currentPage == 0) {
		mapView = self.locationMapView;
	} else if (self.swipeView.currentPage == 1) {
		mapView = self.addedMapView;
	}
	
    CGFloat y = theScrollView.contentOffset.y;
    if (y < 0) { // drag
        // we moved y pixels down, how much latitude is that ?
        double deltaLat = y * mapView.deltaLatitude;
		
        // move the center coordinate accordingly
		CLLocationCoordinate2D coordinate = mapView.location;
		CLLocationCoordinate2D newCenter = CLLocationCoordinate2DMake(coordinate.latitude - (deltaLat / 2),
																	  coordinate.longitude);
		
		[mapView setCenterCoordinate:newCenter zoomLevel:mapView.zoomLevel animated:NO];
    }
}

- (void) editWine {
	// Transition to AddWineViewController withWine
	AddWineViewController *addWineController = [[AddWineViewController alloc] initWithWine:wine];
	[UIView animateWithDuration:0.5 animations:^{
		[[self navigationController] pushViewController:addWineController animated:YES];
		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
		
	} completion:^(BOOL finished){}];
}

#pragma mark
#pragma mark Add To Collection button

- (void) addToCollectionButtonPressed {
	ModalCollectionView *modalCollectionView = [[ModalCollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 250) andWine:self.wine];
	[modalCollectionView setDelegate:self];
	
	[self presentSemiView:modalCollectionView withOptions:@{
	 KNSemiModalOptionKeys.pushParentBack    : @(YES),
	 KNSemiModalOptionKeys.animationDuration : @(0.25),
	 KNSemiModalOptionKeys.shadowOpacity     : @(0.3),
	 KNSemiModalOptionKeys.parentAlpha		 : @(0.4)
	 }];
}

- (void) cancelButtonPressed:(id) sender {
	[self dismissSemiModalView];
}

- (void) saveButtonPressed:(NSMutableArray*) collections {
	// use given list to persist collections
	[self.wine setCollections:[NSSet setWithArray:collections]];
	[[NSManagedObjectContext defaultContext] saveToPersistentStoreAndWait];
	[self dismissSemiModalView];
}


@end
