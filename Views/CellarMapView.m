#import "CellarMapView.h"

@implementation CellarMapView
@synthesize location;

- (id) initWithFrame:(CGRect) frame andLocation:(CLLocationCoordinate2D) rootLocation {
	self = [super initWithFrame:frame];
    if (self) {
		self.location = rootLocation;
    }
    return self;
}


@end
