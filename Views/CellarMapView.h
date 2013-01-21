#import <MapKit/MapKit.h>
#import "OCMapView.h"

@interface CellarMapView : OCMapView {
	CLLocationCoordinate2D location;
	int zoomLevel;
	double deltaLatitude;
}

@property CLLocationCoordinate2D location;
@property int zoomLevel;
@property double deltaLatitude;


- (id) initWithFrame:(CGRect) frame andLocation:(CLLocationCoordinate2D) rootLocation andZoomLevel:(int) zoomLevel;
@end
