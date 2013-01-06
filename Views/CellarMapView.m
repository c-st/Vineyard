#import "CellarMapView.h"
#import "MKMapView+ZoomLevel.h"

@implementation CellarMapView
@synthesize location, zoomLevel, deltaLatitude;

- (id) initWithFrame:(CGRect) frame andLocation:(CLLocationCoordinate2D) rootLocation andZoomLevel:(int)theZoomLevel{
	self = [super initWithFrame:frame];
    if (self) {
		self.location = rootLocation;
		self.zoomLevel = theZoomLevel;
		[self setCenterCoordinate:location zoomLevel:zoomLevel animated:YES];
		
    }
    return self;
}


@end
