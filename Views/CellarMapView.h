#import <MapKit/MapKit.h>

@interface CellarMapView : MKMapView {
	CLLocationCoordinate2D location;
	int zoomLevel;
	double deltaLatitude;
}

@property CLLocationCoordinate2D location;
@property int zoomLevel;
@property double deltaLatitude;


- (id) initWithFrame:(CGRect) frame andLocation:(CLLocationCoordinate2D) rootLocation andZoomLevel:(int) zoomLevel;
@end
