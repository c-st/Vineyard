
#import "WineDetailViewController.h"
#import "AddWineViewController.h"

#import "UIColor+CellarColours.h"
#import "SSToolkit.h"



@interface WineDetailViewController ()

@end

@implementation WineDetailViewController

double deltaLatitude;

@synthesize wine, mapView;

- (id) initWithWine:(Wine *)theWine {
	if ((self = [super init])) {
		[self setWine:theWine];
	}
    return self;
}

- (void) viewWillAppear:(BOOL)animated {
	[self loadView];
}

- (void) loadView {
	[super loadView];
	//[self setTitle:[NSString stringWithFormat:@"%@", wine.name]];
	[self setTitle:@"Wine"];
	//[self.view setBackgroundColor:[UIColor cellarBeigeColour]];
	
	// TODO: add UiPageControl with scroll view to change views by swiping horizontally.
	
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
	
	// Map -200
	// -100, .. 300
	self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, -150, bound.size.width, 400)];
	
    CLLocationCoordinate2D coordinate = {wine.location.latitudeValue, wine.location.longitudeValue};
	[mapView setRegion:MKCoordinateRegionMakeWithDistance(coordinate, 1500, 1500) animated:YES];
	[mapView setCenterCoordinate:coordinate animated:YES];
	
	
	[mapView setScrollEnabled:NO];
	[mapView setZoomEnabled:NO];
	
	CLLocationCoordinate2D referencePosition = [mapView convertPoint:CGPointMake(0, 0) toCoordinateFromView:mapView];
    CLLocationCoordinate2D referencePosition2 = [mapView convertPoint:CGPointMake(0, 100) toCoordinateFromView:mapView];
    deltaLatitude = (referencePosition2.latitude - referencePosition.latitude) / 100;
	
	MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
	point.coordinate = coordinate;
	[mapView addAnnotation:point];
	 
	[scrollView addSubview:mapView];

	
	// White
	UILabel *whiteArea = [[UILabel alloc] initWithFrame:CGRectMake(bound.origin.x, 100, bound.size.width, 200)];
	[whiteArea setBackgroundColor:[UIColor whiteColor]];
	[scrollView addSubview:whiteArea];
	
	// Line view
	SSLineView *line = [[SSLineView alloc] initWithFrame:CGRectMake(0, 100, bound.size.width, 20)];
	[line setLineColor:[UIColor lightGrayColor]];
	[scrollView addSubview:line];
	
	// Shadow
	CAGradientLayer *shadow = [CAGradientLayer layer];
	shadow.frame = CGRectMake(0, 300, bound.size.width, 8);
	shadow.startPoint = CGPointMake(1.0, 0.5);
	shadow.endPoint = CGPointMake(1.0, 1.0);
	shadow.colors = @[(id)[[UIColor colorWithWhite:0.0 alpha:0.2] CGColor], (id)[[UIColor clearColor] CGColor]];
	[scrollView.layer addSublayer:shadow];
	
	
	// Name
	UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 110, 300, 25)];
	[nameLabel setBackgroundColor:[UIColor clearColor]];
    [nameLabel setFont:[UIFont fontWithName:@"Baskerville" size:20]];
	[nameLabel setTextColor:[UIColor blackColor]];
	[nameLabel setText:[wine name]];

	[scrollView addSubview:nameLabel];
	
	[self.view addSubview:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)theScrollView {
    CGFloat y = theScrollView.contentOffset.y;
    // did we drag ?
    if (y<0) {
        //we moved y pixels down, how much latitude is that ?
        double deltaLat = y * deltaLatitude;
		
        //Move the center coordinate accordingly
        CLLocationCoordinate2D newCenter = CLLocationCoordinate2DMake(wine.location.latitudeValue - deltaLat/2, wine.location.longitudeValue);
		[mapView setCenterCoordinate:newCenter animated:NO];
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


- (void)viewDidLoad {
    [super viewDidLoad];
}


@end
