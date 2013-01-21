#import "WineMapFoldViewController.h"

#import "UIColor+CellarColours.h"
#import "UIImage+Tint.h"

#import <QuartzCore/QuartzCore.h>

#import "CountryTableViewController.h"
#import "SVSegmentedControl.h"


@interface WineMapFoldViewController ()

@end

@implementation WineMapFoldViewController

@synthesize mapView;

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
	
	SVSegmentedControl *navSC = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray arrayWithObjects:@"Region", @"Tagged", nil]];
	[navSC setAlpha:0.9];
    navSC.changeHandler = ^(NSUInteger newIndex) {
        [self.mapView setWinesToBeDisplayed:[Wine findAll] showRegion:newIndex==0];
    };
	[navSC setFont:[UIFont systemFontOfSize:11]];
    [navSC setFrame:CGRectMake(0, 0, 100, 30)];
	navSC.titleEdgeInsets = UIEdgeInsetsMake(0, 14, 0, 14);
	
	navSC.center = CGPointMake(220, 475);
	navSC.thumb.tintColor = [UIColor cellarWineRedColour];
	navSC.thumb.textColor = [UIColor whiteColor];
	
	[self.view addSubview:navSC];
	
	
}

- (void) layoutSubviews {

}

- (void) viewWillAppear:(BOOL)animated {
	[mapView setWinesToBeDisplayed:[Wine findAll] showRegion:YES];
	[mapView removeOverlays:mapView.overlays];
    [mapView doClustering];
	
}


@end
