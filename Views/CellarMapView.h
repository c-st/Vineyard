#import <MapKit/MapKit.h>
#import "OCMapView.h"

#import "Wine.h"
#import "Location.h"
#import "Appellation.h"
#import "Region.h"

@interface CellarMapView : OCMapView <MKMapViewDelegate> {
	CLLocationCoordinate2D location;
	int zoomLevel;
	double deltaLatitude;
}

@property CLLocationCoordinate2D location;
@property int zoomLevel;
@property double deltaLatitude;


- (id) initWithFrame:(CGRect) frame andLocation:(CLLocationCoordinate2D) rootLocation andZoomLevel:(int) zoomLevel;

- (void) setWinesToBeDisplayed:(NSArray*) wines;
@end
