#import "WineMapFoldViewController.h"

#import "UIColor+CellarColours.h"
#import "UIImage+Tint.h"

#import <QuartzCore/QuartzCore.h>

#import "CountryTableViewController.h"



@interface WineMapFoldViewController ()

@end

@implementation WineMapFoldViewController

@synthesize mapView, segmentedControl;

- (void) viewDidLoad {
    [super viewDidLoad];
	[self.view setBackgroundColor:[UIColor darkGrayColor]]; //darkGray
	
	self.mapView = [[CellarMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
	
	[self.view addSubview:mapView];
	
	CAGradientLayer *shadow = [CAGradientLayer layer];
	shadow.frame = CGRectMake(0, 0, 5, self.view.frame.size.height);
	shadow.endPoint = CGPointMake(1.0, 0.5);
	shadow.startPoint = CGPointMake(0, 0.5);
	shadow.colors = @[(id)[[UIColor colorWithWhite:0.0 alpha:0.6] CGColor], (id)[[UIColor clearColor] CGColor]];
	[self.view.layer addSublayer:shadow];
	
	self.segmentedControl = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@"Region", @"Tagged", nil]];
	[self.segmentedControl setAlpha:0.7];
	__weak CellarMapView *dupMapView = mapView;
    self.segmentedControl.changeHandler = ^(NSUInteger newIndex) {
        [dupMapView setWinesToBeDisplayed:[Wine findAll] showRegion:newIndex==0];
		[dupMapView removeOverlays:dupMapView.overlays];
		[dupMapView doClustering];
    };
	[self.segmentedControl setFont:[UIFont systemFontOfSize:11]];
    [self.segmentedControl setFrame:CGRectMake(0, 0, 100, 30)];
	self.segmentedControl.titleEdgeInsets = UIEdgeInsetsMake(0, 14, 0, 14);
	
	self.segmentedControl.center = CGPointMake(220, 460);
	self.segmentedControl.thumb.tintColor = [UIColor cellarWineRedColour];
	self.segmentedControl.thumb.textColor = [UIColor whiteColor];
	
	[self.view addSubview:self.segmentedControl];
}

- (void) layoutSubviews {

}

- (void) viewWillAppear:(BOOL)animated {
	[mapView setWinesToBeDisplayed:[Wine findAll] showRegion:self.segmentedControl.selectedIndex==0];
	[mapView removeOverlays:mapView.overlays];
    [mapView doClustering];
	
}


@end
