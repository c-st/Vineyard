#import <MapKit/MapKit.h>

@interface CellarMapView : MKMapView {
	CLLocationCoordinate2D location;
}

@property CLLocationCoordinate2D location;

- (id) initWithFrame:(CGRect) frame andLocation:(CLLocationCoordinate2D) rootLocation;
@end
